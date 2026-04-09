import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/core/database/database.dart' as db;
import 'package:ai_gym_mentor/core/widgets/skeleton_card.dart';
import 'package:ai_gym_mentor/core/widgets/speed_dial_fab.dart';
import 'package:ai_gym_mentor/features/exercises/exercises_provider.dart';
import 'package:ai_gym_mentor/core/domain/entities/exercise.dart' as entity;

class ExercisesScreen extends ConsumerStatefulWidget {
  const ExercisesScreen({super.key});

  @override
  ConsumerState<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends ConsumerState<ExercisesScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const List<String> muscleGroups = [
    'All Muscles',
    'Chest',
    'Back',
    'Shoulders',
    'Biceps',
    'Triceps',
    'Quads',
    'Hamstrings',
    'Glutes',
    'Calves',
    'Core',
    'Cardio',
    'Full Body'
  ];

  static const List<String> equipmentTypes = [
    'All Equipment',
    'Barbell',
    'Dumbbell',
    'Machine',
    'Cable',
    'Bodyweight',
    'Kettlebell',
    'Bands',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      ref
          .read(exerciseFiltersProvider.notifier)
          .setSearch(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(filteredExercisesProvider);
    final filters = ref.watch(exerciseFiltersProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            expandedHeight: 280,
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(16, 56, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exercises',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(170),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Search exercises...',
                        prefixIcon: const Icon(LucideIcons.search),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withValues(alpha: 0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Row(
                      children: muscleGroups.map((muscle) {
                        final isSelected = filters['muscle'] == muscle;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(muscle),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                ref
                                    .read(exerciseFiltersProvider.notifier)
                                    .setMuscle(muscle);
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Row(
                      children: equipmentTypes.map((eq) {
                        final isSelected = filters['equipment'] == eq;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(eq),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                ref
                                    .read(exerciseFiltersProvider.notifier)
                                    .setEquipment(eq);
                              }
                            },
                            selectedColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          exercisesAsync.when(
            data: (exercises) {
              if (exercises.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.dumbbell,
                          size: 64,
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No exercises found',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () {
                            _searchController.clear();
                            ref.read(exerciseFiltersProvider.notifier).reset();
                          },
                          icon: const Icon(LucideIcons.rotateCcw, size: 16),
                          label: const Text('Reset Filters'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Group by first letter
              final groups = <String, List<entity.Exercise>>{};
              for (var ex in exercises) {
                final letter = ex.name[0].toUpperCase();
                groups.putIfAbsent(letter, () => []).add(ex);
              }
              final sortedLetters = groups.keys.toList()..sort();

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final letter = sortedLetters[index];
                    final items = groups[letter]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            letter,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        ...items.map((ex) => Slidable(
                              key: ValueKey('exercise_${ex.id}'),
                              startActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                extentRatio: 0.25,
                                children: [
                                  SlidableAction(
                                    onPressed: (_) => context
                                        .push('/exercises/history/${ex.id}'),
                                    backgroundColor: Colors.indigo,
                                    foregroundColor: Colors.white,
                                    icon: LucideIcons.history,
                                    label: 'History',
                                    borderRadius: const BorderRadius.horizontal(
                                        left: Radius.circular(12)),
                                  ),
                                ],
                              ),
                              endActionPane: ex.isCustom
                                  ? ActionPane(
                                      motion: const DrawerMotion(),
                                      extentRatio: 0.5,
                                      children: [
                                        SlidableAction(
                                          onPressed: (_) => context
                                              .push('/exercises/${ex.id}/edit'),
                                          backgroundColor: Colors.orange,
                                          foregroundColor: Colors.white,
                                          icon: LucideIcons.pencil,
                                          label: 'Edit',
                                        ),
                                        SlidableAction(
                                          onPressed: (_) => _deleteExercise(ex),
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: LucideIcons.trash2,
                                          label: 'Delete',
                                          borderRadius:
                                              const BorderRadius.horizontal(
                                                  right: Radius.circular(12)),
                                        ),
                                      ],
                                    )
                                  : null,
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                elevation: 0,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest
                                    .withValues(alpha: 0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  title: Hero(
                                    tag: 'exercise_${ex.id}',
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        ex.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withValues(alpha: 0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            ex.primaryMuscle,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              LucideIcons.activity,
                                              size: 12,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              ex.equipment,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () =>
                                      context.push('/exercises/${ex.id}'),
                                ),
                              ),
                            )),
                      ],
                    );
                  },
                  childCount: sortedLetters.length,
                ),
              );
            },
            loading: () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, __) => const SkeletonCard(height: 72),
                childCount: 8,
              ),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(child: Text('Error: $err')),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
      floatingActionButton: SpeedDialFab(
        icon: LucideIcons.plus,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        children: [
          SpeedDialChild(
            icon: LucideIcons.plus,
            label: 'New Exercise',
            onTap: () => context.push('/exercises/create'),
          ),
          SpeedDialChild(
            icon: LucideIcons.upload,
            label: 'Import JSON',
            onTap: () {},
          ),
          SpeedDialChild(
            icon: LucideIcons.globe,
            label: 'Browse Global Library',
            onTap: () => context.push('/exercises/library'),
          ),
          SpeedDialChild(
            icon: LucideIcons.arrowUpDown,
            label: 'Sort by Muscle',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _deleteExercise(entity.Exercise exercise) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Exercise?'),
        content: Text(
            'Are you sure you want to delete "${exercise.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final database = ref.read(db.appDatabaseProvider);
              await (database.delete(database.exercises)
                    ..where((t) => t.id.equals(exercise.id)))
                  .go();
              ref.invalidate(allExercisesProvider);
              if (mounted) Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
