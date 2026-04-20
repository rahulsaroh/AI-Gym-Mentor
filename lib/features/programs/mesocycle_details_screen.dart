import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/core/domain/entities/mesocycle.dart' as ent;
import 'package:ai_gym_mentor/features/programs/providers/mesocycles_notifier.dart';
import 'package:ai_gym_mentor/features/programs/repositories/mesocycle_repository.dart';
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';

class MesocycleDetailsScreen extends ConsumerWidget {
  final int mesocycleId;
  const MesocycleDetailsScreen({super.key, required this.mesocycleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(mesocyclesProvider);

    return stateAsync.when(
      data: (state) {
        final mesocycle = state.mesocycles.firstWhere((m) => m.id == mesocycleId);
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              _buildAppBar(context, mesocycle),
              _buildHeader(mesocycle),
              _buildStats(mesocycle),
              _buildWeeksList(context, ref, mesocycle),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _buildAppBar(BuildContext context, ent.MesocycleEntity mesocycle) {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      backgroundColor: Colors.orange[800],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(mesocycle.name, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange[900]!, Colors.orange[400]!],
            ),
          ),
          child: const Center(
            child: Opacity(opacity: 0.2, child: Icon(LucideIcons.activity, size: 80, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ent.MesocycleEntity mes) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _badge(mes.goal.label, Colors.teal),
                const SizedBox(width: 8),
                _badge('${mes.weeksCount} Weeks', Colors.blue),
              ],
            ),
            const SizedBox(height: 16),
            if (mes.notes != null)
              Text(mes.notes!, style: GoogleFonts.outfit(color: Colors.grey[600], height: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(ent.MesocycleEntity mes) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            _statItem('WEEKS', '${mes.weeksCount}'),
            _statItem('DAYS/WK', '${mes.daysPerWeek}'),
            _statItem('TYPE', mes.splitType.split(' ').first),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey[100]!)),
        child: Column(
          children: [
            Text(label, style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[500])),
            const SizedBox(height: 4),
            Text(value, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeksList(BuildContext context, WidgetRef ref, ent.MesocycleEntity mes) {
    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final week = mes.weeks[index];
            return Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text('WEEK ${week.weekNumber}', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                subtitle: Text(week.phaseName.label, style: TextStyle(color: _getPhaseColor(week.phaseName), fontWeight: FontWeight.bold, fontSize: 12)),
                leading: CircleAvatar(
                  backgroundColor: week.weekNumber == 1 ? Colors.orange[700] : Colors.grey[100],
                  foregroundColor: week.weekNumber == 1 ? Colors.white : Colors.grey[600],
                  child: Text('${week.weekNumber}'),
                ),
                children: week.days.map((day) => _buildDayTile(context, ref, day, mes.name)).toList(),
              ),
            );
          },
          childCount: mes.weeks.length,
        ),
      ),
    );
  }

  Widget _buildDayTile(BuildContext context, WidgetRef ref, ent.MesocycleDayEntity day, String mesName) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(day.title, style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
        subtitle: Text('${day.exercises.length} Exercises • ${day.splitLabel ?? ""}', style: GoogleFonts.outfit(fontSize: 12)),
        trailing: IconButton(
          icon: Icon(LucideIcons.play, color: Colors.green[600]),
          onPressed: () => _startWorkout(context, ref, day, mesName),
        ),
      ),
    );
  }

  Future<void> _startWorkout(BuildContext context, WidgetRef ref, ent.MesocycleDayEntity day, String mesName) async {
    final repo = ref.read(mesocycleRepositoryProvider);
    final workoutId = await repo.startMesocycleWorkout(day, mesName);
    
    // Refresh home state so the new workout appears
    ref.invalidate(workoutHomeProvider);
    
    if (context.mounted) {
      context.push('/app/workout/active?id=$workoutId');
    }
  }

  Color _getPhaseColor(ent.MesocyclePhase phase) {
    switch (phase) {
      case ent.MesocyclePhase.onRamp: return Colors.blue;
      case ent.MesocyclePhase.accumulation: return Colors.green;
      case ent.MesocyclePhase.intensification: return Colors.orange[800]!;
      case ent.MesocyclePhase.deload: return Colors.purple;
      case ent.MesocyclePhase.custom: return Colors.grey;
    }
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
