import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/exercise_providers.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/core/database/database.dart' as db;
import 'package:ai_gym_mentor/features/exercise_database/data/datasources/gemini_service.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/exercise_history_provider.dart';

class ExerciseDetailScreen extends ConsumerStatefulWidget {
  final int exerciseId;
  final bool isEditing;

  const ExerciseDetailScreen({
    super.key,
    required this.exerciseId,
    this.isEditing = false,
  });

  @override
  ConsumerState<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends ConsumerState<ExerciseDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (widget.exerciseId > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(exerciseRepositoryProvider).markRecentlyViewed(widget.exerciseId);
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exerciseAsync = ref.watch(exerciseDetailProvider(widget.exerciseId));
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOffline = connectivityAsync.value == false;

    return exerciseAsync.when(
      data: (exercise) {
        if (exercise == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Exercise Not Found')),
            body: const Center(child: Text('Could not find this exercise')),
          );
        }

        if (widget.exerciseId == 0 || widget.isEditing) {
          return _buildFormScreen(exercise);
        }

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                _buildPremiumHeader(exercise, isOffline),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Theme.of(context).colorScheme.primary,
                        unselectedLabelColor: Theme.of(context).colorScheme.outline,
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: const [
                          Tab(text: 'Overview'),
                          Tab(text: 'Guide'),
                          Tab(text: 'Progress'),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(exercise),
                _buildGuideTab(exercise),
                _buildProgressTab(exercise),
              ],
            ),
          ),
          bottomNavigationBar: _buildActionBottomBar(exercise),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildPremiumHeader(ExerciseEntity exercise, bool isOffline) {
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.black.withValues(alpha: 0.3),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundColor: Colors.black.withValues(alpha: 0.3),
            child: IconButton(
              icon: Icon(
                exercise.isEnriched ? LucideIcons.sparkles : LucideIcons.sparkle,
                color: exercise.isEnriched ? Colors.amber : Colors.white,
                size: 18,
              ),
              onPressed: () => _showEnrichmentDialog(context, exercise),
              tooltip: 'AI Enrichment',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundColor: Colors.black.withValues(alpha: 0.3),
            child: IconButton(
              icon: Icon(
                exercise.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: exercise.isFavorite ? Colors.red : Colors.white,
                size: 18,
              ),
              onPressed: () async {
                await ref.read(exerciseRepositoryProvider).toggleFavorite(
                  exercise.id,
                  !exercise.isFavorite,
                );
                ref.invalidate(exerciseDetailProvider(widget.exerciseId));
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'ex_${exercise.id}',
              child: exercise.gifUrl != null && !isOffline
                  ? CachedNetworkImage(
                      imageUrl: exercise.gifUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: Colors.grey.shade900),
                    )
                  : exercise.imageUrls.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: exercise.imageUrls.first,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Icon(LucideIcons.dumbbell, size: 80, color: Colors.white.withValues(alpha: 0.2)),
                          ),
                        ),
            ),
            // Gradient Overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
            // Header Info
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      exercise.difficulty.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        exercise.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      if (exercise.isEnriched) ...[
                        const SizedBox(width: 8),
                        const Icon(LucideIcons.sparkles, color: Colors.amber, size: 20),
                      ],
                    ],
                  ),
                  if (exercise.nameHi != null) 
                    Text(
                      '${exercise.nameHi} | ${exercise.nameMr ?? ""}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    '${exercise.equipment} • ${exercise.mechanic ?? "Compound"}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab(ExerciseEntity exercise) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildSectionHeader('Muscles Targeted', LucideIcons.target),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ...exercise.primaryMuscles.map((m) => _PremiumMuscleChip(m, isPrimary: true)),
            ...exercise.secondaryMuscles.map((m) => _PremiumMuscleChip(m, isPrimary: false)),
          ],
        ),
        const SizedBox(height: 32),
        if (exercise.overview?.isNotEmpty ?? false) ...[
          _buildSectionHeader('About', LucideIcons.info),
          const SizedBox(height: 12),
          Text(
            exercise.overview!,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 32),
        ],
        _buildSectionHeader('Force Type', LucideIcons.activity),
        const SizedBox(height: 12),
        _buildInfoTile(
          LucideIcons.arrowUpDown,
          'Force',
          exercise.force ?? 'Dynamic',
          'Direction of energy output during movement',
        ),
        const SizedBox(height: 32),
        _buildSectionHeader('Related Exercises', LucideIcons.gitBranch),
        const SizedBox(height: 12),
        _buildSimilarExercisesGrid(exercise),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildGuideTab(ExerciseEntity exercise) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildSectionHeader('Step-by-Step Instructions', LucideIcons.listOrdered),
        const SizedBox(height: 16),
        ...exercise.instructions.asMap().entries.map((entry) => _PremiumInstructionStep(
              stepNumber: entry.key + 1,
              instruction: entry.value,
              isLast: entry.key == exercise.instructions.length - 1,
            )),
        const SizedBox(height: 32),
        if (exercise.safetyTips.isNotEmpty) ...[
          _buildSectionHeader('Safety Tips', LucideIcons.shieldAlert, color: Colors.amber),
          const SizedBox(height: 12),
          ...exercise.safetyTips.map((tip) => _PremiumSafetyTip(tip: tip)),
          const SizedBox(height: 32),
        ],
        if (exercise.commonMistakes.isNotEmpty) ...[
          _buildSectionHeader('Common Mistakes', LucideIcons.circleX, color: Colors.red),
          const SizedBox(height: 12),
          ...exercise.commonMistakes.map((mistake) => _PremiumMistakeCard(mistake: mistake)),
          const SizedBox(height: 40),
        ],
      ],
    );
  }

  Widget _buildProgressTab(ExerciseEntity exercise) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildSectionHeader('Performance Stats', LucideIcons.chartBar),
        const SizedBox(height: 16),
        _buildExerciseStats(exercise),
        const SizedBox(height: 32),
        _buildSectionHeader('Progression Path', LucideIcons.trendingUp),
        const SizedBox(height: 16),
        _buildProgressionPathVisual(exercise),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, {Color? color}) {
    final themeColor = color ?? Theme.of(context).colorScheme.primary;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: themeColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: themeColor),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline)),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBottomBar(ExerciseEntity exercise) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Add to Plan', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              onPressed: () => context.push('/exercises/history/${exercise.id}'),
              icon: Icon(LucideIcons.history, color: Theme.of(context).colorScheme.primary),
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSimilarExercisesGrid(ExerciseEntity exercise) {
    final similarAsync = ref.watch(relatedExercisesProvider(exercise.id));
    return similarAsync.when(
      data: (similar) {
        if (similar.isEmpty) return const Text('No related exercises found.');
        return SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similar.length,
            itemBuilder: (context, index) {
              final ex = similar[index];
              return Container(
                width: 130,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: ex.imageUrls.isNotEmpty
                        ? CachedNetworkImage(imageUrl: ex.imageUrls.first, height: 80, width: double.infinity, fit: BoxFit.cover)
                        : Container(height: 80, color: Colors.grey.shade200),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(ex.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildExerciseStats(ExerciseEntity exercise) {
    final statsAsync = ref.watch(exerciseStatsProvider(exercise.id));
    return statsAsync.when(
      data: (stats) {
        if (stats.isEmpty) return const _EmptyStatsPlaceholder();
        return Row(
          children: [
             _ExpandedStatCard(title: 'Max Weight', value: '${stats['maxWeight']}kg', icon: LucideIcons.weight),
             const SizedBox(width: 12),
             _ExpandedStatCard(title: 'Best 1RM', value: '${(stats['best1RM'] as double).toStringAsFixed(1)}kg', icon: LucideIcons.trophy),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildProgressionPathVisual(ExerciseEntity exercise) {
    final progressionAsync = ref.watch(progressionChainProvider(exercise.id));
    return progressionAsync.when(
      data: (chain) {
        if (chain.isEmpty) return const Text('No progression data available.');
        return Column(
          children: chain.asMap().entries.map((entry) {
            final isCurrent = entry.value.id == exercise.id;
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isCurrent ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceVariant,
                    child: Icon(
                      isCurrent ? Icons.check : LucideIcons.chevronRight,
                      size: 16,
                      color: isCurrent ? Colors.white : Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  title: Text(entry.value.name, style: TextStyle(fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal)),
                  subtitle: Text(entry.value.difficulty),
                  onTap: isCurrent ? null : () => context.pushReplacement('/exercises/${entry.value.id}'),
                ),
                if (entry.key < chain.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: Container(width: 2, height: 20, color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5)),
                  ),
              ],
            );
          }).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  void _showEnrichmentDialog(BuildContext context, ExerciseEntity exercise) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(LucideIcons.sparkles, color: Colors.amber),
            SizedBox(width: 12),
            Text('AI Enrichment'),
          ],
        ),
        content: Text(exercise.isEnriched 
          ? 'This exercise has already been enriched. Would you like to re-sync with AI for potentially newer insights?' 
          : 'Sync with Gemini AI to generate professional safety tips, common mistakes, and localized names (Hindi/Marathi).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _enrichExercise(exercise);
            },
            child: const Text('Enrich Now'),
          ),
        ],
      ),
    );
  }

  Future<void> _enrichExercise(ExerciseEntity exercise) async {
    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Consulting AI Expert...', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );

    try {
      final data = await ref.read(geminiServiceProvider.notifier).enrichExercise(exercise);
      
      await ref.read(exerciseRepositoryProvider).saveEnrichedContent(
        exercise.id,
        safetyTips: List<String>.from(data['safety_tips']),
        commonMistakes: List<String>.from(data['common_mistakes']),
        variations: List<String>.from(data['variations']),
        enrichedOverview: data['overview'],
        enrichmentSource: 'gemini-1.5-flash',
      );

      // Trigger re-fetch
      ref.invalidate(exerciseDetailProvider(widget.exerciseId));
      
      if (mounted) {
        Navigator.pop(context); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Exercise enriched successfully! ✨'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to enrich: $e')),
        );
      }
    }
  }

  Widget _buildFormScreen(ExerciseEntity exercise) {
    // Basic implementation for now, will polish if needed in Phase 7
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Exercise')),
      body: const Center(child: Text('Editor Mode - To be enhanced')),
    );
  }
}

class _PremiumMuscleChip extends StatelessWidget {
  final String muscle;
  final bool isPrimary;

  const _PremiumMuscleChip(this.muscle, {required this.isPrimary});

  @override
  Widget build(BuildContext context) {
    final color = isPrimary ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isPrimary ? color.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: isPrimary ? 0.3 : 0.2)),
      ),
      child: Text(
        muscle,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
          color: isPrimary ? color : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}

class _PremiumInstructionStep extends StatelessWidget {
  final int stepNumber;
  final String instruction;
  final bool isLast;

  const _PremiumInstructionStep({
    required this.stepNumber,
    required this.instruction,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$stepNumber',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text(
                instruction,
                style: const TextStyle(fontSize: 15, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumSafetyTip extends StatelessWidget {
  final String tip;
  const _PremiumSafetyTip({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(LucideIcons.shieldAlert, size: 18, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(child: Text(tip, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

class _PremiumMistakeCard extends StatelessWidget {
  final String mistake;
  const _PremiumMistakeCard({required this.mistake});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(LucideIcons.circleX, size: 18, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(child: Text(mistake, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

class _ExpandedStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _ExpandedStatCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(title, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline)),
          ],
        ),
      ),
    );
  }
}

class _EmptyStatsPlaceholder extends StatelessWidget {
  const _EmptyStatsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5), style: BorderStyle.none),
      ),
      child: Column(
        children: [
          Icon(LucideIcons.chartBar, size: 32, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 12),
          Text('No session data yet', style: TextStyle(color: Theme.of(context).colorScheme.outline, fontWeight: FontWeight.bold)),
          Text('Complete a workout to see stats.', style: TextStyle(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.7), fontSize: 12)),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final Widget _tabBar;

  @override
  double get minExtent => 48;
  @override
  double get maxExtent => 48;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
