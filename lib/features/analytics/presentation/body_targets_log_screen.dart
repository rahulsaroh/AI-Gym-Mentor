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
  final Map<String, TextEditingController> _controllers = {};
  DateTime _deadline = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    super.initState();
    // Pre-populate with existing targets if any
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final targets = ref.read(bodyTargetsListProvider).value ?? [];
      for (var m in standardMetrics) {
        final t = targets.where((target) => target.metric == m.id).firstOrNull;
        _controllers[m.id] = TextEditingController(text: t?.targetValue.toString() ?? '');
      }
      setState(() {});
    });
    // Fallback if provider is not ready
    for (var m in standardMetrics) {
      if (!_controllers.containsKey(m.id)) {
        _controllers[m.id] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _onSave() async {
    final List<target.BodyTarget> newTargets = [];
    _controllers.forEach((metric, controller) {
      final value = double.tryParse(controller.text);
      if (value != null) {
        newTargets.add(target.BodyTarget(
          id: 0,
          metric: metric,
          targetValue: value,
          deadline: _deadline,
          createdAt: DateTime.now(),
        ));
      }
    });

    if (newTargets.isEmpty) return;

    final provider = ref.read(bodyTargetsListProvider.notifier);
    for (var t in newTargets) {
      await provider.addTarget(t);
    }
    
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Body Targets', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: _onSave,
            child: Text('Save', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildDeadlinePicker(),
            const Divider(height: 1),
            ...standardMetrics.map((m) => _buildTargetRow(m)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDeadlinePicker() {
    return ListTile(
      leading: const Icon(LucideIcons.calendar, size: 20),
      title: Text('Goal Deadline', style: GoogleFonts.outfit(fontSize: 16)),
      trailing: TextButton(
        onPressed: () async {
          final d = await showDatePicker(
            context: context,
            initialDate: _deadline,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
          );
          if (d != null) setState(() => _deadline = d);
        },
        child: Text(
          DateFormat('MMM d, yyyy').format(_deadline),
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTargetRow(MetricConfig config) {
    final controller = _controllers[config.id]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      constraints: const BoxConstraints(minWidth: 110),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.05)),
        ),
      ),
      child: Row(
        children: [
          config.assetPath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    config.assetPath!,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(config.icon, size: 22, color: Colors.grey[600]),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              config.label,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    textAlign: TextAlign.end,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: GoogleFonts.robotoMono(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: '--',
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  config.unit,
                  style: GoogleFonts.outfit(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
