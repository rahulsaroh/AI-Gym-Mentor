import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ai_gym_mentor/core/database/database.dart' as db;
import 'package:ai_gym_mentor/core/widgets/skeleton_card.dart';
import 'package:ai_gym_mentor/core/widgets/speed_dial_fab.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/exercise_providers.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/models/exercise_filter_model.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/l10n/app_localizations.dart';

class ExerciseListScreen extends ConsumerStatefulWidget {
  final bool selectionMode;
  final void Function(ExerciseEntity)? onExerciseSelected;

  const ExerciseListScreen({
    super.key,
    this.selectionMode = false,
    this.onExerciseSelected,
  });

  @override
  ConsumerState<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends ConsumerState<ExerciseListScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  final ScrollController _scrollController = ScrollController();

  static const List<String> bodyPartFilters = [
    'All',
    'Chest',
    'Back',
    'Shoulders',
    'Arms',
    'Core',
    'Legs',
    'Full Body',
  ];

  static const List<String> difficultyFilters = [
    'All',
    'Beginner',
    'Intermediate',
    'Expert',
  ];

  static const List<String> equipmentFilters = [
    'All',
    'Barbell',
    'Dumbbell',
    'Cable',
    'Machine',
    'Bodyweight',
    'Kettlebell',
    'Band',
    'Plate',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(exerciseFilterStateProvider.notifier).updateFilter(
        (filter) => filter.copyWith(searchQuery: query),
      );
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(exerciseListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(exerciseListProvider);
    final filter = ref.watch(exerciseFilterStateProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final recentlyViewedAsync = ref.watch(recentlyViewedProvider);
    final bodyPartAsync = ref.watch(bodyPartsProvider);
    final equipmentAsync = ref.watch(equipmentProvider);
    final isOffline = connectivityAsync.value == false;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          _buildPremiumAppBar(context, isOffline),
          _buildSearchAndFilters(context, filter, bodyPartAsync, equipmentAsync),
          if (!filter.isActive)
            recentlyViewedAsync.when(
              data: (recent) {
                if (recent.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
                return SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                        child: Text(
                          AppLocalizations.of(context)!.recently_viewed,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: recent.length,
                          itemBuilder: (context, index) {
                            final ex = recent[index];
                            return _RecentlyViewedPremiumCard(
                              exercise: ex,
                              onTap: () => context.push('/exercises/${ex.id}'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              error: (_, __) => const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                filter.isActive ? 'Search Results' : 'All Exercises',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          exercisesAsync.when(
            data: (exercises) {
              if (exercises.isEmpty) {
                return _buildEmptyState(context);
              }

              // Prefetch images for performance (Phase 8.4)
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _prefetchFirstImages(exercises, context);
              });

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= exercises.length) return null;
                      final ex = exercises[index];
                      return _ExercisePremiumCard(
                        exercise: ex,
                        selectionMode: widget.selectionMode,
                        onTap: widget.selectionMode
                            ? () {
                                widget.onExerciseSelected?.call(ex);
                                context.pop();
                              }
                            : () => context.push('/exercises/${ex.id}'),
                        onFavorite: () async {
                          await ref.read(exerciseRepositoryProvider).toggleFavorite(ex.id, !ex.isFavorite);
                          ref.invalidate(exerciseListProvider);
                        },
                      );
                    },
                    childCount: exercises.length,
                  ),
                ),
              );
            },
            loading: () => SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, __) => const PremiumShimmerCard(),
                  childCount: 6,
                ),
              ),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(child: Text('Error: $err')),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
        ],
      ),
      floatingActionButton: !widget.selectionMode
          ? SpeedDialFab(
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
                  icon: LucideIcons.globe,
                  label: 'Global Library',
                  onTap: () => context.push('/exercises/library'),
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildPremiumAppBar(BuildContext context, bool isOffline) {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      stretch: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.blurBackground, StretchMode.zoomBackground],
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: Text(
          widget.selectionMode 
            ? AppLocalizations.of(context)!.select_exercise 
            : AppLocalizations.of(context)!.library,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        background: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                      Theme.of(context).colorScheme.surface,
                    ],
                  ),
                ),
              ),
            ),
            // Decorative shapes for premium feel
            Positioned(
              right: -50,
              top: -20,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters(
    BuildContext context, 
    ExerciseFilter filter, 
    AsyncValue<List<String>> bodyPartAsync, 
    AsyncValue<List<String>> equipmentAsync
  ) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search_hint,
                prefixIcon: Icon(LucideIcons.search, size: 20, color: Theme.of(context).colorScheme.primary),
                suffixIcon: _searchController.text.isNotEmpty 
                  ? IconButton(
                      icon: const Icon(LucideIcons.x, size: 16),
                      onPressed: () {
                        _searchController.clear();
                        _onSearchChanged('');
                      },
                    )
                  : null,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // Body Part Horizontal Filter
          _buildFilterHeader('Body Part'),
          SizedBox(
            height: 50,
            child: bodyPartAsync.when(
              data: (parts) {
                final displayParts = ['All', ...parts];
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: displayParts.length,
                  itemBuilder: (context, index) {
                    final part = displayParts[index];
                    final isSelected = (part == 'All' && filter.bodyPart == null) || filter.bodyPart == part;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(part),
                        selected: isSelected,
                        onSelected: (selected) {
                          ref.read(exerciseFilterStateProvider.notifier).updateFilter(
                            (s) => s.copyWith(bodyPart: part == 'All' ? null : part)
                          );
                        },
                        showCheckmark: false,
                        labelStyle: TextStyle(
                          color: isSelected ? Theme.of(context).colorScheme.onPrimary : null,
                          fontWeight: isSelected ? FontWeight.bold : null,
                        ),
                        selectedColor: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                );
              },
              loading: () => Center(child: CupertinoActivityIndicator()),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 12),
          
          // Equipment Horizontal Filter
          _buildFilterHeader('Equipment'),
          SizedBox(
            height: 50,
            child: equipmentAsync.when(
              data: (equips) {
                final displayEquips = ['All', ...equips];
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: displayEquips.length,
                  itemBuilder: (context, index) {
                    final equip = displayEquips[index];
                    final isSelected = (equip == 'All' && filter.equipment == null) || filter.equipment == equip;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(equip),
                        selected: isSelected,
                        onSelected: (selected) {
                          ref.read(exerciseFilterStateProvider.notifier).updateFilter(
                            (s) => s.copyWith(equipment: equip == 'All' ? null : equip)
                          );
                        },
                        showCheckmark: false,
                        labelStyle: TextStyle(
                          color: isSelected ? Theme.of(context).colorScheme.onPrimary : null,
                          fontWeight: isSelected ? FontWeight.bold : null,
                        ),
                        selectedColor: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                );
              },
              loading: () => Center(child: CupertinoActivityIndicator()),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFilterHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).colorScheme.outline,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return FilterChip(
      label: Text(label, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      checkmarkColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outlineVariant,
          width: 0.5,
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context, String title, List<String> options, String? current, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final opt = options[index];
                  final isSelected = (current == opt) || (current == null && opt == 'All');
                  return ListTile(
                    title: Text(opt),
                    trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                    onTap: () {
                      onSelect(opt);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _prefetchFirstImages(List<ExerciseEntity> exercises, BuildContext context) {
    for (final ex in exercises.take(10)) {
      if (ex.imageUrls.isNotEmpty) {
        precacheImage(CachedNetworkImageProvider(ex.imageUrls.first), context);
      }
    }
  }

  Widget _buildEmptyState(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.searchX, size: 48, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)),
            ),
            const SizedBox(height: 24),
            Text(AppLocalizations.of(context)!.no_exercises_found, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters.',
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.tonal(
              onPressed: () {
                _searchController.clear();
                ref.read(exerciseFilterStateProvider.notifier).updateFilter((_) => const ExerciseFilter());
              },
              child: Text(AppLocalizations.of(context)!.clear_all_filters),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentlyViewedPremiumCard extends StatelessWidget {
  final ExerciseEntity exercise;
  final VoidCallback onTap;

  const _RecentlyViewedPremiumCard({
    required this.exercise,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Hero(
                  tag: 'ex_recent_${exercise.id}',
                  child: exercise.imageUrls.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: exercise.imageUrls.first,
                          width: 110,
                          height: 85,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => _FallbackImage(name: exercise.name),
                        )
                      : _FallbackImage(name: exercise.name, height: 85),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              exercise.name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 1.2),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExercisePremiumCard extends StatelessWidget {
  final ExerciseEntity exercise;
  final bool selectionMode;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const _ExercisePremiumCard({
    required this.exercise,
    required this.selectionMode,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Hero(
                      tag: 'ex_${exercise.id}',
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          exercise.imageUrls.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: exercise.imageUrls.first,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) => _FallbackImage(name: exercise.name, size: 70),
                                )
                              : _FallbackImage(name: exercise.name, size: 70),
                          if (selectionMode)
                            Container(
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                              child: const Center(
                                child: Icon(Icons.check_circle, color: Colors.white, size: 24),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${exercise.primaryMuscles.join(", ")} • ${exercise.equipment}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      _PremiumDifficultyBadge(difficulty: exercise.difficulty),
                    ],
                  ),
                ),
                if (!selectionMode)
                  IconButton(
                    icon: Icon(
                      exercise.isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                      size: 20,
                      color: exercise.isFavorite ? Colors.red : Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                    ),
                    onPressed: onFavorite,
                  )
                else
                  Icon(LucideIcons.circlePlus, size: 24, color: Theme.of(context).colorScheme.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FallbackImage extends StatelessWidget {
  final String name;
  final double size;
  final double? height;

  const _FallbackImage({required this.name, this.size = 60, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: height ?? size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
          ],
        ),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?',
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class _PremiumDifficultyBadge extends StatelessWidget {
  final String difficulty;

  const _PremiumDifficultyBadge({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (difficulty.toLowerCase()) {
      case 'beginner': color = Colors.green; break;
      case 'intermediate': color = Colors.orange; break;
      case 'expert': color = Colors.red; break;
      default: color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        difficulty.toUpperCase(),
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class PremiumShimmerCard extends StatelessWidget {
  const PremiumShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.2),
      highlightColor: Theme.of(context).colorScheme.surface,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
