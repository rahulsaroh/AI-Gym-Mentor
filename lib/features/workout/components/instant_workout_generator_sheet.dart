import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/workout/providers/instant_workout_notifier.dart';

class InstantWorkoutGeneratorSheet extends ConsumerStatefulWidget {
  const InstantWorkoutGeneratorSheet({super.key});

  @override
  ConsumerState<InstantWorkoutGeneratorSheet> createState() => _InstantWorkoutGeneratorSheetState();
}

class _InstantWorkoutGeneratorSheetState extends ConsumerState<InstantWorkoutGeneratorSheet> {
  final List<String> _selectedBodyParts = [];
  String _selectedEquipment = 'Full Gym';
  int _selectedDuration = 45;

  final List<String> _bodyParts = [
    'Chest', 'Back', 'Shoulders', 'Biceps', 'Triceps', 'Abs', 
    'Quads', 'Hamstrings', 'Glutes', 'Calves', 'Legs'
  ];

  final List<String> _equipmentOptions = ['Full Gym', 'Bodyweight Only', 'Home (Dumbbell)'];
  final List<int> _durationOptions = [15, 30, 45, 60, 90];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final generationState = ref.watch(instantWorkoutProvider);

    // Listen for completion to navigate
    ref.listen(instantWorkoutProvider, (previous, next) {
      if (next.hasValue && next.value != null) {
        final id = next.value!;
        final router = GoRouter.of(context);
        Navigator.pop(context); // Close sheet
        router.push('/app/workout/active?id=$id');
        ref.read(instantWorkoutProvider.notifier).reset();
      } else if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate workout: ${next.error}')),
        );
      }
    });

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [colorScheme.primary, colorScheme.tertiary],
                      ).createShader(bounds);
                    },
                    child: const Icon(LucideIcons.sparkles, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'AI Generator',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(LucideIcons.x),
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Tell us what you want to target today, and our AI will build a personalized plan for you.',
            style: TextStyle(color: colorScheme.outline, fontSize: 13),
          ),
          const SizedBox(height: 24),

          // 1. Body Parts
          _buildSectionHeader(context, 'BODY PARTS', LucideIcons.target),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _bodyParts.map((part) {
              final isSelected = _selectedBodyParts.contains(part);
              return FilterChip(
                selected: isSelected,
                label: Text(part),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedBodyParts.add(part);
                    } else {
                      _selectedBodyParts.remove(part);
                    }
                  });
                },
                selectedColor: colorScheme.primaryContainer,
                checkmarkColor: colorScheme.primary,
                labelStyle: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // 2. Equipment & Time
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(context, 'EQUIPMENT', LucideIcons.dumbbell),
                    const SizedBox(height: 12),
                    _buildDropdown<String>(
                      context: context,
                      value: _selectedEquipment,
                      items: _equipmentOptions,
                      onChanged: (val) => setState(() => _selectedEquipment = val!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(context, 'DURATION', LucideIcons.clock),
                    const SizedBox(height: 12),
                    _buildDropdown<int>(
                      context: context,
                      value: _selectedDuration,
                      items: _durationOptions,
                      onChanged: (val) => setState(() => _selectedDuration = val!),
                      suffix: ' min',
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // 3. Generate Button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _selectedBodyParts.isEmpty || generationState.isLoading
                  ? null
                  : () => ref.read(instantWorkoutProvider.notifier).generateWorkout(
                        bodyParts: _selectedBodyParts,
                        equipment: _selectedEquipment,
                        duration: _selectedDuration,
                      ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                backgroundColor: colorScheme.primary,
              ),
              child: generationState.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(LucideIcons.sparkles, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          'GENERATE WORKOUT',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 14, color: colorScheme.primary),
        const SizedBox(width: 6),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required BuildContext context,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    String suffix = '',
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          items: items.map((e) => DropdownMenuItem<T>(
            value: e,
            child: Text('$e$suffix', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w600)),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
