import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gym_gemini_pro/core/domain/entities/exercise.dart';
import 'exercise_library_provider.dart';
import 'widgets/exercise_media_widget.dart';

class ExerciseLibraryScreen extends ConsumerStatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  ConsumerState<ExerciseLibraryScreen> createState() =>
      _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends ConsumerState<ExerciseLibraryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      ref
          .read(exerciseLibrarySearchProvider.notifier)
          .setQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(filteredLibraryExercisesProvider);
    final filters = ref.watch(exerciseLibraryFiltersProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, filters),
          exercisesAsync.when(
            data: (exercises) => _buildExerciseList(exercises),
            loading: () => _buildLoadingList(),
            error: (err, stack) => SliverFillRemaining(
              child: Center(
                  child: Text('Error: $err',
                      style: const TextStyle(color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Map<String, String?> filters) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Exercise Library',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        background: ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withValues(alpha: 0.5), Colors.black],
          ).createShader(rect),
          blendMode: BlendMode.darken,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[900]!, Colors.purple[900]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(LucideIcons.dumbbell,
                size: 100, color: Colors.white.withValues(alpha: 0.1)),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search 800+ exercises...',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                  prefixIcon:
                      const Icon(LucideIcons.search, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            _buildFilterChips(filters),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips(Map<String, String?> filters) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _filterChip(
            label: filters['category'] ?? 'Category',
            isActive: filters['category'] != null,
            onTap: () => _showFilterPicker('category',
                ['Strength', 'Stretching', 'Cardio', 'Plyometrics']),
          ),
          const SizedBox(width: 8),
          _filterChip(
            label: filters['equipment'] ?? 'Equipment',
            isActive: filters['equipment'] != null,
            onTap: () => _showFilterPicker('equipment', [
              'Barbell',
              'Dumbbell',
              'Machine',
              'Cable',
              'Bodyweight',
              'None'
            ]),
          ),
          const SizedBox(width: 8),
          _filterChip(
            label: filters['difficulty'] ?? 'Difficulty',
            isActive: filters['difficulty'] != null,
            onTap: () => _showFilterPicker(
                'difficulty', ['Beginner', 'Intermediate', 'Expert']),
          ),
          if (filters.values.any((v) => v != null))
            IconButton(
              icon: const Icon(LucideIcons.x, color: Colors.red, size: 20),
              onPressed: () =>
                  ref.read(exerciseLibraryFiltersProvider.notifier).reset(),
            ),
        ],
      ),
    );
  }

  Widget _filterChip(
      {required String label,
      required bool isActive,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue[700] : Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: isActive ? Colors.blue : Colors.transparent),
        ),
        child: Row(
          children: [
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down, color: Colors.white70, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseList(List<Exercise> exercises) {
    if (exercises.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
            child: Text('No exercises found',
                style: TextStyle(color: Colors.grey))),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final exercise = exercises[index];
            return _buildExerciseCard(exercise);
          },
          childCount: exercises.length,
        ),
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    return GestureDetector(
      onTap: () => context.push('/exercises/library/${exercise.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ExerciseMediaWidget(
                animatedUrl: exercise.gifUrl,
                staticUrl: exercise.imageUrl,
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    exercise.category,
                    style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(LucideIcons.dumbbell,
                          size: 10, color: Colors.grey[400]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          exercise.equipment,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingList() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey[900]!,
            highlightColor: Colors.grey[800]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          childCount: 6,
        ),
      ),
    );
  }

  void _showFilterPicker(String filter, List<String> options) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select $filter',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            const SizedBox(height: 10),
            ...options.map((opt) => ListTile(
                  title: Text(opt, style: const TextStyle(color: Colors.white)),
                  onTap: () {
                    if (filter == 'category') {
                      ref
                          .read(exerciseLibraryFiltersProvider.notifier)
                          .setCategory(opt);
                    }
                    if (filter == 'equipment') {
                      ref
                          .read(exerciseLibraryFiltersProvider.notifier)
                          .setEquipment(opt);
                    }
                    if (filter == 'difficulty') {
                      ref
                          .read(exerciseLibraryFiltersProvider.notifier)
                          .setDifficulty(opt);
                    }
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
