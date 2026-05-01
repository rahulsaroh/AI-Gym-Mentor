import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/exercise_providers.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/models/exercise_filter_model.dart';
import 'package:ai_gym_mentor/l10n/app_localizations.dart';

class ExerciseLibraryScreen extends ConsumerStatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  ConsumerState<ExerciseLibraryScreen> createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends ConsumerState<ExerciseLibraryScreen> {
  late TextEditingController _searchController;
  Timer? _debounce;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(exerciseFilterStateProvider.notifier).updateFilter(
            (f) => f.copyWith(searchQuery: query),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(exerciseListProvider);
    final filter = ref.watch(exerciseFilterStateProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Exercise Library', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(filter.favoritesOnly ? LucideIcons.heart : LucideIcons.heart),
            color: filter.favoritesOnly ? Colors.red : null,
            onPressed: () {
              ref.read(exerciseFilterStateProvider.notifier).updateFilter(
                    (f) => f.copyWith(favoritesOnly: !f.favoritesOnly),
                  );
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.globe),
            tooltip: 'GitHub Library',
            onPressed: () => context.push('/exercise-library'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search 2000+ exercises...',
                prefixIcon: const Icon(LucideIcons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(LucideIcons.x),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Filters Row
          _buildFilters(context, ref, filter),

          // Exercise List
          Expanded(
            child: exercisesAsync.when(
              data: (exercises) {
                if (exercises.isEmpty) {
                  return _buildEmptyState(context);
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return _ExerciseListItem(exercise: exercise);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/exercises/create'),
        child: const Icon(LucideIcons.plus),
      ),
    );
  }

  Widget _buildFilters(BuildContext context, WidgetRef ref, ExerciseFilter filter) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _FilterChip(
            label: filter.bodyPart ?? 'All Muscles',
            isActive: filter.bodyPart != null,
            onTap: () => _showMusclePicker(context, ref),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: filter.equipment ?? 'Any Equipment',
            isActive: filter.equipment != null,
            onTap: () => _showEquipmentPicker(context, ref),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: filter.category ?? 'Any Type',
            isActive: filter.category != null,
            onTap: () => _showCategoryPicker(context, ref),
          ),
        ],
      ),
    );
  }

  void _showMusclePicker(BuildContext context, WidgetRef ref) {
    final muscles = ['Chest', 'Back', 'Shoulders', 'Biceps', 'Triceps', 'Quads', 'Hamstrings', 'Glutes', 'Abs', 'Calves', 'Forearms', 'Full Body'];
    _showPicker(context, 'Select Muscle', muscles, (val) {
      ref.read(exerciseFilterStateProvider.notifier).updateFilter((f) => f.copyWith(bodyPart: val));
    });
  }

  void _showEquipmentPicker(BuildContext context, WidgetRef ref) {
    final equipment = ['Barbell', 'Dumbbell', 'Cable', 'Machine', 'Bodyweight', 'Kettlebell', 'Band', 'Plate', 'Other'];
    _showPicker(context, 'Select Equipment', equipment, (val) {
      ref.read(exerciseFilterStateProvider.notifier).updateFilter((f) => f.copyWith(equipment: val));
    });
  }

  void _showCategoryPicker(BuildContext context, WidgetRef ref) {
    final categories = ['Strength', 'Stretching', 'Cardio', 'Powerlifting', 'Strongman', 'Plyometrics'];
    _showPicker(context, 'Select Category', categories, (val) {
      ref.read(exerciseFilterStateProvider.notifier).updateFilter((f) => f.copyWith(category: val));
    });
  }

  void _showPicker(BuildContext context, String title, List<String> options, Function(String?) onSelect) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: const Text('All / Any'),
            onTap: () {
              onSelect(null);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(options[index]),
                onTap: () {
                  onSelect(options[index]);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.searchX, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text('No exercises found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Try broadening your search or filters', style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.read(exerciseFilterStateProvider.notifier).updateFilter((_) => const ExerciseFilter());
              _searchController.clear();
            },
            child: const Text('Clear All Filters'),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Theme.of(context).colorScheme.onSurface,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              LucideIcons.chevronDown,
              size: 14,
              color: isActive ? Colors.white70 : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseListItem extends StatelessWidget {
  final ExerciseEntity exercise;

  const _ExerciseListItem({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(LucideIcons.dumbbell, color: Theme.of(context).primaryColor),
        ),
        title: Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                _buildTag(context, exercise.primaryMuscles.first),
                const SizedBox(width: 8),
                _buildTag(context, exercise.equipment ?? 'None'),
              ],
            ),
          ],
        ),
        trailing: const Icon(LucideIcons.chevronRight, size: 20),
        onTap: () => context.push('/exercises/${exercise.id}'),
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
