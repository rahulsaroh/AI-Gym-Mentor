import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_target.dart' as target;
import 'package:intl/intl.dart';

class BodyTargetsLogScreen extends ConsumerStatefulWidget {
  const BodyTargetsLogScreen({super.key});

  @override
  ConsumerState<BodyTargetsLogScreen> createState() => _BodyTargetsLogScreenState();
}

class _BodyTargetsLogScreenState extends ConsumerState<BodyTargetsLogScreen> {
  String _selectedMetric = 'weight';
  final _targetController = TextEditingController();
  DateTime _deadline = DateTime.now().add(const Duration(days: 30));

  void _onSave() async {
    final value = double.tryParse(_targetController.text);
    if (value == null) return;

    final tb = target.BodyTarget(
      id: 0,
      metric: _selectedMetric,
      targetValue: value,
      deadline: _deadline,
      createdAt: DateTime.now(),
    );

    await ref.read(bodyTargetsListProvider.notifier).addTarget(tb);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Set Goal', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: _onSave,
            child: Text('Save', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Metric', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedMetric,
                  isExpanded: true,
                  items: standardMetrics.map((m) => DropdownMenuItem(
                    value: m.id,
                    child: Text(m.label),
                  )).toList(),
                  onChanged: (v) => setState(() => _selectedMetric = v!),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Target Value', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _targetController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: GoogleFonts.robotoMono(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: '0.0',
                suffixText: standardMetrics.firstWhere((m) => m.id == _selectedMetric).unit,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            Text('Deadline', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(LucideIcons.calendar),
              title: Text(DateFormat('MMMM d, yyyy').format(_deadline)),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _deadline,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                );
                if (d != null) setState(() => _deadline = d);
              },
              trailing: const Icon(LucideIcons.chevronRight),
            ),
          ],
        ),
      ),
    );
  }
}
