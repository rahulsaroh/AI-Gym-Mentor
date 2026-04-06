import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_gemini_pro/features/programs/providers/programs_notifier.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgramsScreen extends ConsumerWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(programsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Plans', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.download),
            onPressed: () => ref.read(programsNotifierProvider.notifier).importTemplate(),
            tooltip: 'Import JSON',
          ),
        ],
      ),
      body: stateAsync.when(
        data: (state) {
          if (state.templates.isEmpty) {
            return _buildEmptyState(ref);
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(programsNotifierProvider.notifier).refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.templates.length,
              itemBuilder: (context, index) {
                final template = state.templates[index];
                return _ProgramCard(template: template);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildEmptyState(WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.calendar, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No plans found',
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Import a plan or create your first one.',
            style: GoogleFonts.outfit(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => ref.read(programsNotifierProvider.notifier).importTemplate(),
            icon: const Icon(LucideIcons.download),
            label: const Text('Import JSON Plan'),
          ),
        ],
      ),
    );
  }
}

class _ProgramCard extends ConsumerWidget {
  final WorkoutTemplate template;
  const _ProgramCard({required this.template});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: InkWell(
        onTap: () {
          // Future: Navigate to template details
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          template.name,
                          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        if (template.description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            template.description!,
                            style: GoogleFonts.outfit(fontSize: 14, color: Colors.grey[600]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(LucideIcons.ellipsisVertical, size: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'export',
                        child: Row(children: [Icon(LucideIcons.share, size: 18), SizedBox(width: 8), Text('Export JSON')]),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(children: [Icon(LucideIcons.trash, size: 18, color: Colors.red), SizedBox(width: 8), Text('Delete', style: TextStyle(color: Colors.red))]),
                      ),
                    ],
                    onSelected: (val) {
                      if (val == 'export') {
                        ref.read(programsNotifierProvider.notifier).exportTemplate(template.id);
                      } else if (val == 'delete') {
                        _showDeleteDialog(context, ref);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStat(context, LucideIcons.calendarDays, 'Split'),
                  const SizedBox(width: 24),
                  _buildStat(context, LucideIcons.layers, 'Unlimited'),
                  const SizedBox(width: 24),
                  _buildStat(context, LucideIcons.zap, 'Pro'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Plan?', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to delete "${template.name}"? This action cannot be undone.', style: GoogleFonts.outfit()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.outfit(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              ref.read(programsNotifierProvider.notifier).deleteTemplate(template.id);
              Navigator.pop(context);
            },
            child: Text('Delete', style: GoogleFonts.outfit(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
