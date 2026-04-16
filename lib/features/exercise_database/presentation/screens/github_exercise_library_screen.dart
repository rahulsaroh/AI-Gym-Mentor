import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/github_exercise_provider.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/widgets/github_exercise_card.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';
import 'package:ai_gym_mentor/services/github_exercise_service.dart';

class GithubExerciseLibraryScreen extends ConsumerStatefulWidget {
  const GithubExerciseLibraryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GithubExerciseLibraryScreen> createState() =>
      _GithubExerciseLibraryScreenState();
}

class _GithubExerciseLibraryScreenState
    extends ConsumerState<GithubExerciseLibraryScreen> {
  late TextEditingController _searchController;
  bool _showFilters = false;
  Timer? _debounce;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // Pre-fill if there is existing state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchController.text = ref.read(githubFilterProvider).searchQuery;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(githubFilterProvider.notifier).updateSearchQuery(query);
    });
  }

  void _clearFilters() {
    _searchController.clear();
    ref.read(githubFilterProvider.notifier).clearAll();
  }

  @override
  Widget build(BuildContext context) {
    final hasFilters = ref.watch(hasActiveFiltersProvider);
    final filteredExercises = ref.watch(filteredGithubExercisesProvider);
    final bodyParts = ref.watch(bodyPartsProvider);
    final equipment = ref.watch(equipmentTypesProvider);
    final selectedBodyPart = ref.watch(selectedBodyPartProvider);
    final selectedEquipment = ref.watch(selectedEquipmentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Library'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.upload),
            tooltip: 'Sync exercises from CSV',
            onPressed: () async {
              final githubService = GithubExerciseService();
              final githubExercises = await githubService.getAllExercises();
              final repo = ref.read(exerciseRepositoryProvider);
              final synced = await repo.syncAllExercisesFromCsv(githubExercises);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Synced $synced exercises from CSV')),
                );
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(filteredGithubExercisesProvider);
        },
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBar(
                controller: _searchController,
                onChanged: _handleSearch,
                hintText: 'Search exercises...',
                leading: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(LucideIcons.search),
                ),
                trailing: [
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(LucideIcons.x),
                      onPressed: () {
                        _searchController.clear();
                        _handleSearch('');
                      },
                    ),
                ],
              ),
            ),
            // Filter row with body part chips
            bodPartFilterRow(
              context,
              bodyParts,
              selectedBodyPart,
              (bodyPart) {
                ref.read(githubFilterProvider.notifier).updateBodyPart(bodyPart);
              },
            ),
            // Equipment filter chips
            if (_showFilters || selectedEquipment != null)
              equipmentFilterRow(
                context,
                equipment,
                selectedEquipment,
                (equip) {
                  ref.read(githubFilterProvider.notifier).updateEquipment(equip);
                },
              ),
            // Show/Hide Filters toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _showFilters = !_showFilters;
                      });
                    },
                    icon: Icon(
                      _showFilters
                          ? LucideIcons.chevronUp
                          : LucideIcons.chevronDown,
                    ),
                    label: Text(_showFilters ? 'Hide Filters' : 'More Filters'),
                  ),
                  const Spacer(),
                  if (hasFilters)
                    TextButton.icon(
                      onPressed: _clearFilters,
                      icon: const Icon(LucideIcons.x),
                      label: const Text('Clear'),
                    ),
                ],
              ),
            ),
            // Results count
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: filteredExercises.when(
                data: (exercises) => Text(
                  'Showing ${exercises.length} exercises',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                loading: () => const SizedBox.shrink(),
                error: (err, stack) => const SizedBox.shrink(),
              ),
            ),
            // Exercise Grid
            Expanded(
              child: filteredExercises.when(
                data: (exercises) {
                  if (exercises.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.search,
                            size: 48,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No exercises found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your filters',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      return GithubExerciseCard(
                        exercise: exercise,
                        onTap: () async {
                          final localId = await ref
                              .read(exerciseRepositoryProvider)
                              .ensureGithubExercise(exercise);
                          if (context.mounted) {
                            context.push('/exercises/$localId');
                          }
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.inbox,
                        size: 48,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading exercises',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref.refresh(filteredGithubExercisesProvider);
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodPartFilterRow(
    BuildContext context,
    AsyncValue<List<String>> bodyPartsAsync,
    String? selectedBodyPart,
    Function(String?) onSelected,
  ) {
    return bodyPartsAsync.when(
      data: (bodyParts) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              FilterChip(
                label: const Text('All'),
                selected: selectedBodyPart == null,
                onSelected: (_) {
                  onSelected(null);
                },
              ),
              ...bodyParts.map(
                (bodyPart) => Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FilterChip(
                    label: Text(bodyPart),
                    selected: selectedBodyPart == bodyPart,
                    onSelected: (_) {
                      onSelected(
                        selectedBodyPart == bodyPart ? null : bodyPart,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => const Padding(
        padding: EdgeInsets.all(12.0),
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => const SizedBox.shrink(),
    );
  }

  Widget equipmentFilterRow(
    BuildContext context,
    AsyncValue<List<String>> equipmentAsync,
    String? selectedEquipment,
    Function(String?) onSelected,
  ) {
    return equipmentAsync.when(
      data: (equipment) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              const Text(
                'Equipment: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              FilterChip(
                label: const Text('Any'),
                selected: selectedEquipment == null,
                onSelected: (_) {
                  onSelected(null);
                },
              ),
              ...equipment.take(10).map(
                    (equip) => Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: FilterChip(
                        label: Text(equip),
                        selected: selectedEquipment == equip,
                        onSelected: (_) {
                          onSelected(
                            selectedEquipment == equip ? null : equip,
                          );
                        },
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
      loading: () => const SizedBox.shrink(),
      error: (err, stack) => const SizedBox.shrink(),
    );
  }
}
