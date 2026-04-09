import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_gemini_pro/core/widgets/skeleton_card.dart';
import 'package:gym_gemini_pro/features/analytics/analytics_providers.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';

class PRHallOfFameScreen extends ConsumerStatefulWidget {
  const PRHallOfFameScreen({super.key});

  @override
  ConsumerState<PRHallOfFameScreen> createState() => _PRHallOfFameScreenState();
}

class _PRHallOfFameScreenState extends ConsumerState<PRHallOfFameScreen> {
  String _filter = 'All';
  final String _sort = 'Recent';

  @override
  Widget build(BuildContext context) {
    final prsAsync = ref.watch(
        recentPRsProvider); // This currently only gets last 30, but I'll use it for now

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Hall of Fame'),
      ),
      body: Column(
        children: [
          _FilterBar(
            currentFilter: _filter,
            onFilterChanged: (f) => setState(() => _filter = f),
          ),
          Expanded(
            child: prsAsync.when(
              data: (prs) {
                if (prs.isEmpty) {
                  return const Center(child: Text('No PRs yet. Keep pushing!'));
                }

                // Sort logic
                final sorted = [...prs];
                if (_sort == 'Recent') {
                  sorted.sort((a, b) =>
                      (b['date'] as DateTime).compareTo(a['date'] as DateTime));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: sorted.length,
                  itemBuilder: (context, index) {
                    final pr = sorted[index];
                    return _PRListTile(pr: pr);
                  },
                );
              },
              loading: () => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (_, __) => const SkeletonCard(
                    height: 72, margin: EdgeInsets.only(bottom: 12)),
              ),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final String currentFilter;
  final ValueChanged<String> onFilterChanged;

  const _FilterBar(
      {required this.currentFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    final muscles = [
      'All',
      'Chest',
      'Back',
      'Shoulders',
      'Biceps',
      'Triceps',
      'Legs',
      'Core'
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: muscles
            .map((m) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(m),
                    selected: currentFilter == m,
                    onSelected: (_) => onFilterChanged(m),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _PRListTile extends StatelessWidget {
  final Map<String, dynamic> pr;
  const _PRListTile({required this.pr});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () => context.push('/exercises/history/${pr['exerciseId']}'),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(LucideIcons.trophy, color: Colors.amber, size: 20),
        ),
        title: Text(pr['name'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle:
            Text('Achieved on ${DateFormat('MMM d, yyyy').format(pr['date'])}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(pr['value'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue)),
            Text('1RM: ${(pr['rm'] as double).toStringAsFixed(1)}kg',
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
