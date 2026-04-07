import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:drift/drift.dart' hide Column;

final syncLogProvider = FutureProvider<List<SyncQueueData>>((ref) async {
  final db = ref.read(appDatabaseProvider);
  return (db.select(db.syncQueue)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
        ..limit(50))
      .get();
});

class SyncLogScreen extends ConsumerWidget {
  const SyncLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logAsync = ref.watch(syncLogProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync History'),
        actions: [
          IconButton(
            onPressed: () => ref.refresh(syncLogProvider),
            icon: const Icon(LucideIcons.refreshCw),
          ),
        ],
      ),
      body: logAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.history, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No sync history found', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: logs.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final log = logs[index];
              return _SyncLogTile(log: log);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _SyncLogTile extends StatelessWidget {
  final SyncQueueData log;
  const _SyncLogTile({required this.log});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    switch (log.status) {
      case 'done':
        statusColor = Colors.green;
        statusIcon = LucideIcons.circleCheck;
        break;
      case 'failed':
        statusColor = Colors.red;
        statusIcon = LucideIcons.circleAlert;
        break;
      case 'pending':
      default:
        statusColor = Colors.orange;
        statusIcon = LucideIcons.clock;
        break;
    }

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(statusIcon, color: statusColor, size: 20),
      ),
      title: Text(
        '${log.type[0].toUpperCase()}${log.type.substring(1)} Sync',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat('MMM d, yyyy • HH:mm').format(log.createdAt)),
          if (log.error != null)
            Text(
              log.error!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      trailing: log.attempts > 0 
          ? Chip(
              label: Text('Retries: ${log.attempts}', style: const TextStyle(fontSize: 10)),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            )
          : null,
      onTap: log.error != null ? () => _showErrorDetail(context) : null,
    );
  }

  void _showErrorDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sync Error Detail'),
        content: SingleChildScrollView(
          child: Text(log.error ?? 'Unknown error'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
