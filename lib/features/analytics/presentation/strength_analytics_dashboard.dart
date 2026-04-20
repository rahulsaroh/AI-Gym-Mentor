import 'package:ai_gym_mentor/features/analytics/presentation/strength_analytics_notifier.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/exercise_strength_detail_screen.dart';
import 'package:ai_gym_mentor/features/analytics/data/strength_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/core/database/database.dart';

class StrengthAnalyticsDashboard extends ConsumerWidget {
  const StrengthAnalyticsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(strengthAnalyticsProvider);
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();

    return stateAsync.when(
      data: (state) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildTimeRangeFilters(context, ref, state.timeRange),
          const SizedBox(height: 24),
          
          if (state.isBackfilling)
            _buildBackfillIndicator(context),
            
          _buildOverallStats(context, state),
          const SizedBox(height: 32),

          if (state.topMovers.isNotEmpty) ...[
            _buildTopMovers(context, state, settings.weightUnit),
            const SizedBox(height: 32),
          ],
          
          if (state.stagnatingExercises.isNotEmpty) ...[
            _buildStagnationAlerts(context, state),
            const SizedBox(height: 32),
          ],
          
          _buildRecentPRs(context, state, settings.weightUnit),
          const SizedBox(height: 32),
          
          _buildTrackedExercises(context, state, settings.weightUnit),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading strength data: $e')),
    );
  }

  Widget _buildTimeRangeFilters(BuildContext context, WidgetRef ref, StrengthTimeRange current) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: StrengthTimeRange.values.map((range) {
          final isSelected = range == current;
          final label = _getRangeLabel(range);
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(label, style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.black,
              )),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  ref.read(strengthAnalyticsProvider.notifier).setTimeRange(range);
                }
              },
              selectedColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Colors.grey[100],
              side: BorderSide.none,
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getRangeLabel(StrengthTimeRange range) {
    switch (range) {
      case StrengthTimeRange.last30Days: return '30 Days';
      case StrengthTimeRange.last90Days: return '90 Days';
      case StrengthTimeRange.lastYear: return 'Last Year';
      case StrengthTimeRange.allTime: return 'All Time';
    }
  }

  Widget _buildOverallStats(BuildContext context, StrengthOverviewState state) {
    final prCount = state.recentPRs.length;
    final strongest = state.enrichedSnapshots.isNotEmpty 
        ? state.enrichedSnapshots.map((e) => e['snapshot'] as Exercise1RmSnapshot).reduce((a, b) => a.estimated1Rm > b.estimated1Rm ? a : b)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Strength Overview', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold)),
            _buildGlobalTrendChip(context, state.globalTrend),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                'Period PRs',
                '$prCount',
                LucideIcons.trophy,
                Colors.orange,
                subtitle: 'New records detected',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                context,
                'Top e1RM',
                strongest != null ? '${strongest.estimated1Rm.toInt()}' : '—',
                LucideIcons.dumbbell,
                Colors.blue,
                subtitle: 'Heaviest estimated lift',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGlobalTrendChip(BuildContext context, double trend) {
    final isPositive = trend > 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (isPositive ? Colors.green : Colors.red).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isPositive ? LucideIcons.trendingUp : LucideIcons.trendingDown, 
               size: 14, color: isPositive ? Colors.green : Colors.red),
          const SizedBox(width: 4),
          Text(
            '${trend > 0 ? '+' : ''}${trend.toStringAsFixed(1)}%',
            style: GoogleFonts.outfit(
              fontSize: 12, 
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green : Colors.red
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon, Color color, {String? subtitle}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            radius: 18,
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(value, style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold)),
          Text(label, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
          if (subtitle != null)
            Text(subtitle, style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildTopMovers(BuildContext context, StrengthOverviewState state, WeightUnit unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Top Strength Movers', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.topMovers.length,
            itemBuilder: (context, index) {
              final mover = state.topMovers[index];
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mover['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(LucideIcons.arrowUpRight, color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '+${(mover['changePercent'] as double).toStringAsFixed(1)}%',
                          style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    Text(
                      '${mover['startRm'].toInt()} → ${mover['endRm'].toInt()}${unit == WeightUnit.kg ? 'kg' : 'lbs'}',
                      style: GoogleFonts.outfit(color: Colors.white.withOpacity(0.8), fontSize: 11),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStagnationAlerts(BuildContext context, StrengthOverviewState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Plateau Warnings', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ...state.stagnatingExercises.take(2).map((ex) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red[100]!),
          ),
          child: Row(
            children: [
              Icon(LucideIcons.info, color: Colors.red[700], size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ex['name'], style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.red[900])),
                    Text('No improvement in ${ex['daysSinceImprovement']} days', style: GoogleFonts.outfit(fontSize: 12, color: Colors.red[700])),
                  ],
                ),
              ),
              Text('STAGNANT', style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.red[700])),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildRecentPRs(BuildContext context, StrengthOverviewState state, WeightUnit unit) {
    if (state.recentPRs.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Achievements', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('New Records', style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.recentPRs.length,
            itemBuilder: (context, index) {
              final pr = state.recentPRs[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                   gradient: LinearGradient(
                    colors: [Colors.orange[400]!, Colors.orange[600]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(LucideIcons.star, color: Colors.white, size: 20),
                    const Spacer(),
                    Text(
                      'Personal Best', 
                      style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      '${pr.estimated1Rm.toInt()}${unit == WeightUnit.kg ? 'kg' : 'lbs'} e1RM',
                      style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrackedExercises(BuildContext context, StrengthOverviewState state, WeightUnit unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Strength by Exercise', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        if (state.enrichedSnapshots.isEmpty)
           _buildEmptyState()
        else
          ...state.enrichedSnapshots.map((e) {
            final s = e['snapshot'] as Exercise1RmSnapshot;
            final name = e['exerciseName'] as String;
            final metrics = state.exerciseMetrics[s.exerciseId];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey[100]!),
              ),
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExerciseStrengthDetailScreen(exerciseId: s.exerciseId, exerciseName: name)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                title: Text(name, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
                subtitle: Text('Trained ${DateFormat.yMMMd().format(s.date)}', style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey[500])),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${s.estimated1Rm.toInt()}${unit == WeightUnit.kg ? 'kg' : 'lbs'}',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[700]),
                    ),
                    if (metrics != null && (metrics['changePercent'] as double) != 0)
                      _buildTrendIndicator(metrics['changePercent']),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildTrendIndicator(double change) {
    final isPositive = change > 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPositive ? LucideIcons.trendingUp : LucideIcons.trendingDown,
          size: 12,
          color: isPositive ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 4),
        Text(
          '${isPositive ? '+' : ''}${change.toStringAsFixed(1)}%',
          style: GoogleFonts.outfit(
            fontSize: 11,
            color: isPositive ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey[100]!)),
      child: Column(
        children: [
          Icon(LucideIcons.activity, size: 48, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text('No data for this period', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.grey[600])),
          Text('Log weighted sets with 1-12 reps to unlock 1RM analytics.', 
               style: GoogleFonts.outfit(color: Colors.grey[500], fontSize: 12), 
               textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildBackfillIndicator(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Analyzing historical strength patterns...',
              style: GoogleFonts.outfit(fontSize: 13, color: Colors.blue[800], fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

