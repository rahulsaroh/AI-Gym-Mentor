import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/features/programs/providers/mesocycles_notifier.dart';
import 'package:ai_gym_mentor/core/domain/entities/mesocycle.dart' as ent;

class MesocycleListView extends ConsumerWidget {
  const MesocycleListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(mesocyclesProvider);

    return stateAsync.when(
      data: (state) {
        if (state.mesocycles.isEmpty) {
          return _buildEmptyState(context);
        }

        final active = state.mesocycles.where((m) => !m.isArchived).toList();
        final archived = state.mesocycles.where((m) => m.isArchived).toList();

        return RefreshIndicator(
          onRefresh: () => ref.read(mesocyclesProvider.notifier).refresh(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            children: [
              if (active.isNotEmpty) ...[
                _buildSectionHeader('Active Blocks'),
                ...active.map((m) => _MesocycleCard(mesocycle: m)),
              ],
              if (archived.isNotEmpty) ...[
                const SizedBox(height: 24),
                _buildSectionHeader('Archived'),
                ...archived.map((m) => _MesocycleCard(mesocycle: m)),
              ],
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.layers, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No Mesocycles yet',
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Plan your training in blocks for better results.',
            style: GoogleFonts.outfit(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _MesocycleCard extends ConsumerWidget {
  final ent.MesocycleEntity mesocycle;
  const _MesocycleCard({required this.mesocycle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: () => context.push('/programs/mesocycle/${mesocycle.id}'),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mesocycle.name,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${mesocycle.weeksCount} Weeks • ${mesocycle.daysPerWeek} Days/Week',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _tag(mesocycle.goal.label, Colors.teal),
                  const SizedBox(width: 8),
                  _tag(mesocycle.experienceLevel, Colors.blue),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(LucideIcons.ellipsis, size: 20),
                    onPressed: () => _showOptions(context, ref),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'WEEK 1',
        style: GoogleFonts.outfit(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.orange[800],
        ),
      ),
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color.withOpacity(0.8),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(mesocycle.isArchived ? LucideIcons.archiveRestore : LucideIcons.archive),
              title: Text(mesocycle.isArchived ? 'Unarchive' : 'Archive'),
              onTap: () {
                ref.read(mesocyclesProvider.notifier).archiveMesocycle(mesocycle.id, !mesocycle.isArchived);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.trash, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirm(context, ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Mesocycle?'),
        content: const Text('This will delete all weeks, days, and history links for this block. This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              ref.read(mesocyclesProvider.notifier).deleteMesocycle(mesocycle.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
