import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ai_gym_mentor/services/github_exercise_service.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';

class ExercisePickerOverlay extends ConsumerStatefulWidget {
  final Function(int) onSelect;

  const ExercisePickerOverlay({super.key, required this.onSelect});

  @override
  ConsumerState<ExercisePickerOverlay> createState() =>
      _ExercisePickerOverlayState();
}

class _ExercisePickerOverlayState extends ConsumerState<ExercisePickerOverlay> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _muscles = [
    'All',
    'Chest',
    'Back',
    'Shoulders',
    'Quads',
    'Hamstrings',
    'Glutes',
    'Calves',
    'Biceps',
    'Triceps',
    'Abs'
  ];
  Timer? _debounce;
  String? _selectedBodyPart;

  final _githubService = GithubExerciseService();
  List<GithubExercise> _exercises = [];
  List<GithubExercise> _filteredExercises = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    setState(() => _isLoading = true);
    try {
      _exercises = await _githubService.getAllExercises();
      _applyFilters();
    } catch (e) {
      debugPrint('Error loading GitHub exercises: $e');
    }
    setState(() => _isLoading = false);
  }

  void _applyFilters() {
    _filteredExercises = _exercises.where((ex) {
      final query = _searchController.text.toLowerCase();
      if (query.isNotEmpty) {
        if (!ex.name.toLowerCase().contains(query) &&
            !ex.bodyPart.toLowerCase().contains(query)) {
          return false;
        }
      }
      if (_selectedBodyPart != null && _selectedBodyPart != 'All') {
        if (ex.bodyPart.toLowerCase() != _selectedBodyPart!.toLowerCase()) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      _applyFilters();
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 12, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Exercise',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(LucideIcons.x, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Search movements...',
                        prefixIcon: Icon(LucideIcons.search, size: 18, color: Theme.of(context).colorScheme.primary),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withValues(alpha: 0.3),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _muscles.length,
                  itemBuilder: (context, index) {
                    final muscle = _muscles[index];
                    final isSelected = (_selectedBodyPart == muscle) || (_selectedBodyPart == null && muscle == 'All');
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FilterChip(
                        label: Text(muscle),
                        selected: isSelected,
                        onSelected: (val) {
                          setState(() {
                            _selectedBodyPart = muscle == 'All' ? null : muscle;
                            _applyFilters();
                          });
                        },
                        showCheckmark: false,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.onSurface,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _filteredExercises.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(LucideIcons.searchX, size: 40, color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5)),
                                const SizedBox(height: 16),
                                const Text('No exercises found', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        : ListView.separated(
                            controller: scrollController,
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                            itemCount: _filteredExercises.length,
                            separatorBuilder: (_, _) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final ex = _filteredExercises[index];
                              return _CompactPickerCard(
                                exercise: ex,
                                onTap: () async {
                                  final exerciseId = await ref
                                      .read(exerciseRepositoryProvider)
                                      .ensureGithubExercise(ex);
                                  widget.onSelect(exerciseId);
                                                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CompactPickerCard extends StatelessWidget {
  final GithubExercise exercise;
  final VoidCallback onTap;

  const _CompactPickerCard({required this.exercise, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: exercise.gifUrl,
                fit: BoxFit.cover,
                placeholder: (_, _) => Center(child: Icon(LucideIcons.dumbbell, size: 20, color: Theme.of(context).colorScheme.primary)),
                errorWidget: (_, _, _) => Center(child: Icon(LucideIcons.dumbbell, size: 20, color: Theme.of(context).colorScheme.primary)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${exercise.target} • ${exercise.equipment}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.plus, size: 18, color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
