import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/exercise_providers.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/models/exercise_filter_model.dart';
import 'package:ai_gym_mentor/l10n/app_localizations.dart';

class MuscleGroupScreen extends ConsumerStatefulWidget {
  const MuscleGroupScreen({super.key});

  @override
  ConsumerState<MuscleGroupScreen> createState() => _MuscleGroupScreenState();
}

class _MuscleGroupScreenState extends ConsumerState<MuscleGroupScreen> {
  bool _isFront = true;

  final List<Map<String, dynamic>> _muscleGroups = [
    {'name': 'Chest', 'icon': LucideIcons.target, 'id': 'pectoralis-major', 'color': Colors.red},
    {'name': 'Back', 'icon': LucideIcons.stretchVertical, 'id': 'latissimus-dorsi', 'color': Colors.blue},
    {'name': 'Shoulders', 'icon': LucideIcons.moveUp, 'id': 'deltoids', 'color': Colors.orange},
    {'name': 'Biceps', 'icon': LucideIcons.dumbbell, 'id': 'biceps-brachii', 'color': Colors.purple},
    {'name': 'Triceps', 'icon': LucideIcons.dumbbell, 'id': 'triceps-brachii', 'color': Colors.cyan},
    {'name': 'Quads', 'icon': LucideIcons.footprints, 'id': 'quadriceps', 'color': Colors.green},
    {'name': 'Hamstrings', 'icon': LucideIcons.footprints, 'id': 'hamstrings', 'color': Colors.brown},
    {'name': 'Glutes', 'icon': LucideIcons.circle, 'id': 'gluteus-maximus', 'color': Colors.pink},
    {'name': 'Abs', 'icon': LucideIcons.activity, 'id': 'rectus-abdominis', 'color': Colors.teal},
    {'name': 'Calves', 'icon': LucideIcons.footprints, 'id': 'gastrocnemius', 'color': Colors.indigo},
  ];

  @override
  Widget build(BuildContext context) {
    final countsAsync = ref.watch(bodyPartCountsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.muscles_worked, style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () => setState(() => _isFront = !_isFront),
            icon: Icon(_isFront ? Icons.flip_to_back : Icons.flip_to_front),
            tooltip: 'Flip Body',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Interactive Body Preview
            Container(
              height: 300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    _isFront ? 'assets/svgs/body_front.svg' : 'assets/svgs/body_back.svg',
                    height: 250,
                    // We can't easily color specific paths with just SvgPicture.asset
                    // For a truly premium feel, we'd use a custom painter or path-aware SVG library
                  ),
                  // Overlays for interactivity (simplified regions)
                  if (_isFront) ...[
                    _buildRegion(80, 75, 40, 30, 'Chest'),
                    _buildRegion(100, 105, 30, 60, 'Abs'),
                    _buildRegion(70, 200, 30, 60, 'Quads'),
                    _buildRegion(115, 200, 30, 60, 'Quads'),
                  ] else ...[
                    _buildRegion(80, 80, 40, 60, 'Back'),
                    _buildRegion(75, 200, 30, 60, 'Hamstrings'),
                    _buildRegion(110, 200, 30, 60, 'Hamstrings'),
                    _buildRegion(90, 160, 40, 40, 'Glutes'),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.recently_viewed, // Or use a new key like "explore_by_region" if I added it
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(exerciseFilterStateProvider.notifier).updateFilter((_) => const ExerciseFilter());
                    context.push('/exercises');
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            countsAsync.when(
              data: (counts) => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _muscleGroups.length,
                itemBuilder: (context, index) {
                  final group = _muscleGroups[index];
                  final count = counts[group['name']] ?? 0;
                  return _MuscleGroupPremiumCard(
                    name: group['name'],
                    icon: group['icon'],
                    color: group['color'],
                    count: count,
                    onTap: () {
                      ref.read(exerciseFilterStateProvider.notifier).updateFilter(
                        (s) => s.copyWith(bodyPart: group['name']),
                      );
                      context.push('/exercises');
                    },
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildRegion(double left, double top, double width, double height, String target) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {
          ref.read(exerciseFilterStateProvider.notifier).updateFilter(
            (s) => s.copyWith(bodyPart: target),
          );
          context.push('/exercises');
        },
        child: Container(
          width: width,
          height: height,
          color: Colors.transparent, // Highlight target region
        ),
      ),
    );
  }
}

class _MuscleGroupPremiumCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final int count;
  final VoidCallback onTap;

  const _MuscleGroupPremiumCard({
    required this.name,
    required this.icon,
    required this.color,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '$count exercises',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
