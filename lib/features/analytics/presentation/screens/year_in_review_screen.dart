import 'package:ai_gym_mentor/features/analytics/presentation/providers/year_in_review_providers.dart';
import 'package:ai_gym_mentor/features/analytics/domain/year_in_review_models.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/widgets/year_activity_heatmap.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/widgets/muscle_balance_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';

class YearInReviewScreen extends ConsumerStatefulWidget {
  final int initialYear;
  const YearInReviewScreen({super.key, required this.initialYear});

  @override
  ConsumerState<YearInReviewScreen> createState() => _YearInReviewScreenState();
}

class _YearInReviewScreenState extends ConsumerState<YearInReviewScreen> {
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    final reviewAsync = ref.watch(yearInReviewProvider(_selectedYear));
    final availableYears = ref.watch(availableReviewYearsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: reviewAsync.when(
        data: (data) => data == null ? _buildEmptyState() : _buildContent(data, availableYears.value ?? []),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildContent(YearInReviewData data, List<int> years) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(data, years),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildHeadlineGrid(data.headlineStats),
                const SizedBox(height: 32),
                _buildConsistencySection(data.consistencyData),
                const SizedBox(height: 32),
                _buildStrengthSection(data.strengthHighlights),
                const SizedBox(height: 32),
                _buildMuscleSection(data.muscleBreakdown),
                const SizedBox(height: 32),
                _buildPersonalRecords(data.prAchievements),
                const SizedBox(height: 32),
                _buildInsightsSection(data.motivationalInsights),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar(YearInReviewData data, List<int> years) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: const Color(0xFF1A1A2E), // Premium dark navy
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF1A1A2E), const Color(0xFF16213E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${data.year}',
                  style: GoogleFonts.outfit(
                      fontSize: 80,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withOpacity(0.1),
                      letterSpacing: 8),
                ),
                Text(
                  'YEAR IN REVIEW',
                  style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[400],
                      letterSpacing: 4),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeroStat('Workouts', '${data.headlineStats.totalWorkouts}'),
                    const SizedBox(width: 32),
                    _buildHeroStat('PRs', '${data.strengthHighlights.newPrsCount}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(LucideIcons.chevronLeft, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        if (years.isNotEmpty)
          _buildYearPicker(years),
      ],
    );
  }

  Widget _buildHeroStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.outfit(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: GoogleFonts.outfit(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildYearPicker(List<int> years) {
    return PopupMenuButton<int>(
      icon: const Icon(LucideIcons.calendar, color: Colors.white),
      onSelected: (year) => setState(() => _selectedYear = year),
      itemBuilder: (context) => years.map((y) => PopupMenuItem(
        value: y,
        child: Text('$y'),
      )).toList(),
    );
  }

  Widget _buildHeadlineGrid(HeadlineStats stats) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildStatCard('Training Days', '${stats.totalTrainingDays}', LucideIcons.calendarDays, Colors.blue),
        _buildStatCard('Total Volume', '${(stats.totalVolume / 1000).toStringAsFixed(1)}k', LucideIcons.layers, Colors.orange),
        _buildStatCard('Sets Done', '${stats.totalSets}', LucideIcons.listTodo, Colors.purple),
        _buildStatCard('Total Reps', '${stats.totalReps}', LucideIcons.repeat, Colors.teal),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const Spacer(),
          Text(value, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildConsistencySection(ConsistencyData data) {
     return _buildSectionLayout(
       'Your Journey',
       Column(
         children: [
           YearActivityHeatmap(dailyActivity: data.dailyActivity, year: _selectedYear),
           const SizedBox(height: 24),
           Row(
             children: [
                _buildCallout('Best Month', data.bestMonth, LucideIcons.trophy, Colors.amber),
                const SizedBox(width: 16),
                _buildCallout('Longest Streak', '${data.longestStreak} days', LucideIcons.flame, Colors.deepOrange),
             ],
           ),
         ],
       ),
     );
  }

  Widget _buildStrengthSection(StrengthHighlights highlights) {
    return _buildSectionLayout(
      'Strength Highlights',
      Column(
        children: [
          ...highlights.biggestGains.map((gain) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(backgroundColor: Colors.green[50], child: const Icon(LucideIcons.trendingUp, size: 16, color: Colors.green)),
            title: Text(gain.exerciseName, style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            subtitle: Text('Increased by ${gain.percentageImprovement.toStringAsFixed(1)}%', style: GoogleFonts.outfit(fontSize: 12)),
          )),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                const Icon(LucideIcons.weight, color: Colors.blue),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Heaviest Lift', style: GoogleFonts.outfit(fontSize: 12, color: Colors.blue[800], fontWeight: FontWeight.bold)),
                    Text('${highlights.heaviestLift.weight}kg on ${highlights.heaviestLift.exerciseName}', 
                         style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleSection(MuscleBreakdown breakdown) {
    return _buildSectionLayout(
      'Body Focus',
      Column(
        children: [
          MuscleBalanceChart(balanceData: {
            'labels': breakdown.volumeByMuscle.keys.toList(),
            'thisMonth': breakdown.volumeByMuscle.values.toList(),
          }),
          const SizedBox(height: 16),
          Text('Most trained: ${breakdown.mostTrainedMuscle}', 
               style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _buildPersonalRecords(List<PersonalRecordAchievement> prs) {
    return _buildSectionLayout(
      'Hall of Fame',
      Column(
        children: [
          if (prs.isEmpty)
            Text('No PRs logged this year yet.', style: GoogleFonts.outfit(color: Colors.grey))
          else
            ...prs.take(5).map((pr) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              color: Colors.orange[50],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                title: Text(pr.exerciseName, style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                subtitle: Text(DateFormat.yMMMd().format(pr.date)),
                trailing: Text('${pr.estimated1Rm.toInt()}kg e1RM', 
                             style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.orange[800])),
              ),
            )),
        ],
      ),
    );
  }

  Widget _buildInsightsSection(List<String> insights) {
    return _buildSectionLayout(
      'Highlights & Insights',
      Column(
        children: insights.map((i) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[100]!),
          ),
          child: Row(
            children: [
              const Icon(LucideIcons.sparkles, color: Colors.blue, size: 18),
              const SizedBox(width: 16),
              Expanded(child: Text(i, style: GoogleFonts.outfit(fontSize: 14))),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildSectionLayout(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildCallout(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.outfit(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
                Text(value, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
     return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const Icon(LucideIcons.calendarOff, size: 64, color: Colors.grey),
           const SizedBox(height: 24),
           Text('No data for $_selectedYear', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
           const SizedBox(height: 32),
           ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Back')),
         ],
       ),
     );
  }
}
