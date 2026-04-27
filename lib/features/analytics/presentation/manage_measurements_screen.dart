import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';

class ManageMeasurementsScreen extends ConsumerStatefulWidget {
  const ManageMeasurementsScreen({super.key});

  @override
  ConsumerState<ManageMeasurementsScreen> createState() => _ManageMeasurementsScreenState();
}

class _ManageMeasurementsScreenState extends ConsumerState<ManageMeasurementsScreen> {
  final Set<int> _selectedIds = {};

  void _deleteSelected() async {
    if (_selectedIds.isEmpty) return;
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Selected?', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to delete the selected measurement logs?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final notifier = ref.read(bodyMeasurementsListProvider.notifier);
        await notifier.deleteMeasurements(_selectedIds);
        setState(() {
          _selectedIds.clear();
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Selected measurements deleted.')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  void _deleteAllLogs() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Reset Everything?', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: const Text('This will delete ALL history logs and targets. This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Reset Everything'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(bodyMeasurementsListProvider.notifier).clearAllHistory();
        await ref.read(bodyTargetsListProvider.notifier).clearAllTargets();
        ref.invalidate(physiqueAchievementProvider);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('All data has been cleared.')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error clearing data: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final measurementsAsync = ref.watch(bodyMeasurementsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Logs', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        actions: [
          ...measurementsAsync.when(
            data: (measurements) {
              final sorted = [...measurements]..sort((a, b) => b.date.compareTo(a.date));
              if (sorted.isEmpty) return [];
              return [
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (_selectedIds.length == sorted.length) {
                        _selectedIds.clear();
                      } else {
                        _selectedIds.clear();
                        _selectedIds.addAll(sorted.map((m) => m.id));
                      }
                    });
                  },
                  child: Text(
                    _selectedIds.length == sorted.length ? 'Deselect' : 'Select All',
                    style: GoogleFonts.outfit(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                  ),
                ),
                if (_selectedIds.isNotEmpty)
                  IconButton(
                    icon: const Icon(LucideIcons.trash2, color: Colors.red),
                    onPressed: _deleteSelected,
                    tooltip: 'Delete Selected',
                  ),
              ];
            },
            loading: () => [],
            error: (_, __) => [],
          ),
          PopupMenuButton<String>(
            icon: const Icon(LucideIcons.ellipsisVertical),
            onSelected: (val) {
              if (val == 'clear_all') _deleteAllLogs();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear_all',
                child: Row(children: [
                  Icon(LucideIcons.trash2, size: 18, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Reset Everything', style: TextStyle(color: Colors.red)),
                ]),
              ),
            ],
          ),
        ],
      ),
      body: measurementsAsync.when(
        data: (measurements) {
          if (measurements.isEmpty) {
            return const Center(child: Text('No measurement logs found.'));
          }
          
          // Sort by date descending
          final sorted = [...measurements]..sort((a, b) => b.date.compareTo(a.date));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              final m = sorted[index];
              final isSelected = _selectedIds.contains(m.id);
              final dateStr = DateFormat('MMM d, yyyy').format(m.date);
              final timeStr = DateFormat('h:mm a').format(m.date);
              
              int loggedCount = 0;
              if (m.weight != null) loggedCount++;
              if (m.bodyFat != null) loggedCount++;
              if (m.neck != null) loggedCount++;
              if (m.chest != null) loggedCount++;
              if (m.shoulders != null) loggedCount++;
              if (m.armLeft != null) loggedCount++;
              if (m.armRight != null) loggedCount++;
              if (m.forearmLeft != null) loggedCount++;
              if (m.forearmRight != null) loggedCount++;
              if (m.waist != null) loggedCount++;
              if (m.waistNaval != null) loggedCount++;
              if (m.hips != null) loggedCount++;
              if (m.thighLeft != null) loggedCount++;
              if (m.thighRight != null) loggedCount++;
              if (m.calfLeft != null) loggedCount++;
              if (m.calfRight != null) loggedCount++;
              if (m.height != null) loggedCount++;
              if (m.customValues != null) loggedCount += m.customValues!.length;

              return Dismissible(
                key: ValueKey(m.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) => _confirmDeleteDay(context, m.date),
                onDismissed: (_) async {
                  try {
                    await ref.read(bodyMeasurementsListProvider.notifier).deleteMeasurement(m.id);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Log entry deleted.')),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error deleting log: $e'), backgroundColor: Colors.red),
                      );
                    }
                    // Re-invalidate to restore the item if deletion failed
                    ref.invalidate(bodyMeasurementsListProvider);
                  }
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(LucideIcons.trash2, color: Colors.red),
                ),
                child: Card(
                  elevation: 0,
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                      : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: CheckboxListTile(
                    value: isSelected,
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          _selectedIds.add(m.id);
                        } else {
                          _selectedIds.remove(m.id);
                        }
                      });
                    },
                    title: Text(dateStr, style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                    subtitle: Text('$timeStr  ·  $loggedCount metrics logged', style: GoogleFonts.outfit(fontSize: 12)),
                    secondary: m.weight != null 
                      ? Text('${m.weight} kg', style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold))
                      : const Icon(LucideIcons.activity, size: 20, color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<bool> _confirmDeleteDay(BuildContext context, DateTime date) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Day Log?', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: Text(
          'This will permanently delete all body measurements logged on ${DateFormat('MMM d, yyyy').format(date)}.',
          style: GoogleFonts.outfit(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
