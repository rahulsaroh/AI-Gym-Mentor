import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/core/widgets/skeleton_card.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
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

  @override
  Widget build(BuildContext context) {
    final prsAsync = ref.watch(fullPRHistoryProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('PR Hall of Fame'),
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
                final filtered = _filter == 'All' 
                  ? prs 
                  : prs.where((p) => (p['primaryMuscle'] as String?)?.toLowerCase() == _filter.toLowerCase()).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.frown, size: 48, color: Theme.of(context).colorScheme.outline),
                        const SizedBox(height: 16),
                        Text(
                          _filter == 'All' ? 'No PRs yet. Keep pushing!' : 'No PRs found for $_filter',
                          style: TextStyle(color: Theme.of(context).colorScheme.outline),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final pr = filtered[index];
                    return _PRListTile(pr: pr);
                  },
                );
              },
              loading: () => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 8,
                itemBuilder: (_, _) => const SkeletonCard(height: 80, margin: EdgeInsets.only(bottom: 12)),
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

  const _FilterBar({required this.currentFilter, required this.onFilterChanged});

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
      'Abs'
    ];

    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: muscles.length,
        itemBuilder: (context, index) {
          final m = muscles[index];
          final isSelected = currentFilter == m;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(m),
              selected: isSelected,
              onSelected: (_) => onFilterChanged(m),
              showCheckmark: false,
              selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              labelStyle: TextStyle(
                color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
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
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () => context.push('/exercises/${pr['exerciseId']}'),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(LucideIcons.award, color: Colors.amber, size: 22),
        ),
        title: Text(
          pr['name'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(LucideIcons.calendar, size: 12, color: Theme.of(context).colorScheme.outline),
                const SizedBox(width: 4),
                Text(
                  DateFormat('MMM d, yyyy').format(pr['date']),
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              pr['value'],
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              '1RM: ${(pr['rm'] as double).toStringAsFixed(1)}kg',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
