import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:ai_gym_mentor/core/domain/entities/workout_program.dart' as ent;
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ai_gym_mentor/features/programs/providers/programs_notifier.dart';
import 'dart:convert';

class ProgramDetailScreen extends ConsumerWidget {
  final int templateId;
  final int? initialDayId;

  const ProgramDetailScreen({super.key, required this.templateId, this.initialDayId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(programsProvider);

    return state.when(
      loading: () => const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Text('Error: $err')),
      ),
      data: (programsState) {
        final program = programsState.templates
            .where((t) => t.id == templateId)
            .firstOrNull;

        if (program == null) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: const BackButton(color: Colors.black)),
            body: const Center(child: Text('Program not found')),
          );
        }

        if (program.days.isEmpty) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: const BackButton(color: Colors.black),
              title: Text(program.name,
                  style: GoogleFonts.outfit(color: Colors.black)),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LucideIcons.calendarX2,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No days found for this program.',
                    style:
                        GoogleFonts.outfit(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.push('/programs/edit/${program.id}'),
                    child: const Text('Add Days'),
                  ),
                ],
              ),
            ),
          );
        }

        final initialIndex = initialDayId != null
            ? program.days.indexWhere((d) => d.id == initialDayId)
            : 0;

        return DefaultTabController(
          length: program.days.length,
          initialIndex: initialIndex != -1 ? initialIndex : 0,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                _buildAppBar(context, program),
                _buildOverview(context, program),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabBarDelegate(
                    TabBar(
                      isScrollable: true,
                      labelColor: Colors.teal[900],
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.teal[900],
                      indicatorWeight: 3,
                      labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                      tabs: program.days.map((day) {
                        final weekdayName = day.weekday != null
                            ? _getWeekdayName(day.weekday!).substring(0, 3)
                            : 'Day ${day.order + 1}';
                        return Tab(
                            text: day.weekday != null
                                ? '$weekdayName (D${day.order + 1})'
                                : 'Day ${day.order + 1}');
                      }).toList(),
                    ),
                  ),
                ),
              ],
              body: TabBarView(
                children: program.days
                    .map((day) =>
                        _buildDaySingleView(context, ref, day, program.name))
                    .toList(),
              ),
            ),
            floatingActionButton: _buildBottomButton(context, ref, program),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context, ent.WorkoutProgram program) {
    final totalExercises = program.days.fold(0, (sum, day) => sum + day.exercises.length);
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.orange[900],
      leading: IconButton(
        icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
        onPressed: () => context.pop(),
        style: IconButton.styleFrom(backgroundColor: Colors.black26),
      ),
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.pencil, color: Colors.white),
          onPressed: () => context.push('/programs/edit/${program.id}'),
          style: IconButton.styleFrom(backgroundColor: Colors.black26),
          tooltip: 'Edit program',
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange[900]!, Colors.orange[600]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              // Decorative dumbbell icon
              Positioned(
                right: -30,
                top: 20,
                child: Opacity(
                  opacity: 0.12,
                  child: Icon(LucideIcons.dumbbell, size: 180, color: Colors.white),
                ),
              ),
              // Program name and stats at the bottom of the expanded area
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      program.name,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        height: 1.2,
                        shadows: [
                          const Shadow(
                            color: Colors.black38,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _statPill(LucideIcons.calendar, '${program.days.length} Days'),
                        const SizedBox(width: 8),
                        _statPill(LucideIcons.dumbbell, '$totalExercises Exercises'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statPill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }


  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          color: Colors.grey[600],
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildOverview(BuildContext context, ent.WorkoutProgram program) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              program.description ??
                  'A comprehensive strength building program designed for peak performance.',
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySingleView(BuildContext context, WidgetRef ref, ent.ProgramDay day,
      String programName) {
    final muscleGroups = _deriveMuscleGroups(day);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day.name,
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    muscleGroups,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.teal[700],
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => _showStartDayConfirm(context, ref, day, programName),
                  icon: const Icon(LucideIcons.play, size: 14, color: Colors.white),
                  label: Text(
                    'START',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    LucideIcons.calendar, 
                    size: 20, 
                    color: day.weekday != null ? Colors.teal : Colors.blue
                  ),
                  onPressed: () => _showWeekdayPicker(context, ref, day),
                  style: IconButton.styleFrom(
                    backgroundColor: (day.weekday != null ? Colors.teal : Colors.blue).withOpacity(0.1),
                    padding: const EdgeInsets.all(8),
                  ),
                  tooltip: 'Set weekday',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...day.exercises.map((ex) => _buildExerciseTile(context, ex)),
      ],
    );
  }


  String _deriveMuscleGroups(ent.ProgramDay day) {
    if (day.exercises.isEmpty) return 'Rest Day';
    final muscles = day.exercises
        .map((e) => e.exercise.primaryMuscles.firstOrNull ?? "Other")
        .toSet()
        .toList();
    if (muscles.length > 2) return '${muscles[0]} & More';
    return muscles.join(' & ');
  }

  Widget _buildBottomButton(
      BuildContext context, WidgetRef ref, ent.WorkoutProgram program) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () async {
            final router = GoRouter.of(context);
            final repo = ref.read(workoutRepositoryProvider);
            final days = await repo.getTemplateDays(templateId);
            debugPrint('ProgramDetailScreen _buildBottomButton: days count=${days.length}');
            if (days.isNotEmpty && context.mounted) {
              debugPrint('ProgramDetailScreen _buildBottomButton: starting workout templateId=$templateId, dayId=${days.first.id}');
              final id =
                  await ref.read(workoutHomeProvider.notifier).startWorkout(
                        templateId: templateId,
                        dayId: days.first.id,
                        name: program.name,
                      );
              debugPrint('ProgramDetailScreen _buildBottomButton: created workout id=$id');
              if (context.mounted) {
                // Navigate only if context is still mounted
                router.push(
                    '/app/workout/active?id=$id&dayId=${days.first.id}');
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
          ),
          child: Text(
            'Start Default Schedule',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showStartDayConfirm(BuildContext context, WidgetRef ref,
      ent.ProgramDay day, String programName) {
    // Capture router from the OUTER context BEFORE showing dialog
    final router = GoRouter.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Start ${day.name}?'),
        content:
            const Text('Do you want to start this specific workout session now?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Close dialog using dialogContext
              Navigator.pop(dialogContext);

              debugPrint(
                  'ProgramDetailScreen: Starting workout with templateId=${day.templateId}, dayId=${day.id}');

              // Async operation after dialog is closed
              final id =
                  await ref.read(workoutHomeProvider.notifier).startWorkout(
                        templateId: day.templateId,
                        dayId: day.id,
                        name: programName,
                      );

              debugPrint('ProgramDetailScreen: Created workout with id=$id');

              // Use the outer `context` for mounted check and the pre-captured router
              if (context.mounted) {
                router.push('/app/workout/active?id=$id&dayId=${day.id}');
              }
            },
            child: const Text('Start Now',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
  Widget _buildExerciseTile(BuildContext context, ent.ProgramExercise ex) {
    final setsInfo = _formatSets(ex.setsJson);
    final imageUrl = ex.exercise.imageUrls.isNotEmpty 
        ? ex.exercise.imageUrls.first 
        : (ex.exercise.gifUrl ?? '');
    final hasImage = imageUrl.isNotEmpty;

    // Generate a consistent color from exercise name
    final nameHash = ex.exercise.name.codeUnits.fold(0, (a, b) => a + b);
    final hue = (nameHash * 37) % 360;
    final avatarColor = HSVColor.fromAHSV(1.0, hue.toDouble(), 0.6, 0.7).toColor();
    final initial = ex.exercise.name.isNotEmpty ? ex.exercise.name[0].toUpperCase() : '?';

    return InkWell(
      onTap: () => context.push('/exercises/${ex.exercise.id}'),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // Exercise Thumbnail
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: avatarColor.withOpacity(0.15),
                border: Border.all(color: avatarColor.withOpacity(0.3), width: 1.5),
              ),
              clipBehavior: Clip.antiAlias,
              child: hasImage
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: Text(
                          initial,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: avatarColor,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Text(
                          initial,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: avatarColor,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        initial,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: avatarColor,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 16),
            // Exercise Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ex.exercise.name,
                    style: GoogleFonts.outfit(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B82F6), // Vibrant Blue
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    setsInfo,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, color: Colors.grey[300], size: 18),
          ],
        ),
      ),
    );
  }

  String _formatSets(String setsJson) {
    try {
      final List<dynamic> sets = jsonDecode(setsJson);
      if (sets.isEmpty) return '1 set';
      final int count = sets.length;
      final firstSet = sets.first;
      final reps = firstSet['reps'] ?? '10';
      return '$count ${count == 1 ? "set" : "sets"} • $reps reps';
    } catch (e) {
      return '3 sets • 12 reps'; // Default fallback matching common exercises
    }
  }

  void _showWeekdayPicker(BuildContext context, WidgetRef ref, ent.ProgramDay day) {
    final weekdays = [
      'None',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ListView.builder(
        shrinkWrap: true,
        itemCount: weekdays.length,
        itemBuilder: (context, index) {
          final isNone = index == 0;
          final weekdayValue = isNone ? null : index;
          return ListTile(
            title: Text(weekdays[index]),
            leading: Icon(
              isNone ? LucideIcons.slash : LucideIcons.calendar,
              color: day.weekday == weekdayValue ? Colors.green : null,
            ),
            trailing: day.weekday == weekdayValue ? const Icon(LucideIcons.check) : null,
            onTap: () {
              ref.read(workoutRepositoryProvider).updateDayWeekday(day.id, weekdayValue);
              // Invalidate programs and home to refresh UI
              ref.invalidate(workoutHomeProvider);
              // We need to trigger a rebuild of the current screen
              // Since it's a FutureBuilder, we might need a better way, but for now:
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  String _getWeekdayName(int weekday) {
    const names = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    if (weekday < 1 || weekday > 7) return 'Unknown';
    return names[weekday];
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return false;
  }
}
