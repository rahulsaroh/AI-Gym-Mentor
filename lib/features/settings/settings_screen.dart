import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/services/backup_service.dart';
import 'package:ai_gym_mentor/features/settings/csv_export_screen.dart';
import 'package:ai_gym_mentor/features/settings/import_wizard_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: settingsAsync.when(
        data: (settings) => ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            _buildSectionHeader(context, 'Profile'),
            _buildTile(
              context,
              title: 'Name',
              subtitle: settings.userName,
              icon: LucideIcons.user,
              onTap: () => _showEditNameDialog(context, ref, settings.userName),
            ),
            _buildTile(
              context,
              title: 'Experience Level',
              subtitle: _capitalize(settings.experienceLevel.name),
              icon: LucideIcons.graduationCap,
              onTap: () => _showExperienceDialog(context, ref, settings),
            ),
            _buildUnitSegmented(context, ref, settings),
            const Divider(height: 32),
            _buildSectionHeader(context, 'Tools & Library'),
            _buildTile(
              context,
              title: 'Exercise Library',
              subtitle: '1300+ exercises with GIFs from GitHub',
              icon: LucideIcons.dumbbell,
              onTap: () => context.push('/exercise-library'),
            ),
            _buildTile(
              context,
              title: 'Body Measurements',
              subtitle: 'Track physique measurements & targets',
              icon: LucideIcons.ruler,
              onTap: () => context.push('/analytics/measurements'),
            ),
            _buildTile(
              context,
              title: 'Transformation Tracker',
              subtitle: 'Progress photos & timelapse',
              icon: LucideIcons.camera,
              onTap: () => context.push('/analytics/photos'),
            ),
            const Divider(height: 32),
            _buildSectionHeader(context, 'Appearance'),
            _buildThemeSegmented(context, ref, settings),
            _buildAccentColorPicker(context, ref, settings),
            _buildFontSizeSegmented(context, ref, settings),
            const Divider(height: 32),
            _buildSectionHeader(context, 'Rest Timer'),
            _buildRestTimerSection(context, ref, settings),
            _buildSwitchTile(
              context,
              title: 'Timer Sound',
              value: settings.timerSound,
              onChanged: (v) => ref
                  .read(settingsProvider.notifier)
                  .updateSettings(settings.copyWith(timerSound: v)),
            ),
            _buildSwitchTile(
              context,
              title: 'Timer Vibration',
              value: settings.timerVibration,
              onChanged: (v) => ref
                  .read(settingsProvider.notifier)
                  .updateSettings(settings.copyWith(timerVibration: v)),
            ),
            _buildSwitchTile(
              context,
              title: 'Background Notifications',
              value: settings.backgroundNotification,
              onChanged: (v) => ref
                  .read(settingsProvider.notifier)
                  .updateSettings(settings.copyWith(backgroundNotification: v)),
            ),
            const Divider(height: 32),
            _buildSectionHeader(context, 'Plate Calculator'),
            _buildTile(
              context,
              title: 'Configure Available Plates',
              subtitle: '${settings.availablePlates.length} weights defined',
              icon: LucideIcons.dumbbell,
              onTap: () => context.push('/settings/plates'),
            ),
            _buildBarbellWeightInput(context, ref, settings),
            const Divider(height: 32),
            _buildSectionHeader(context, 'Training Preferences'),
            _buildAutoIncrementDropdown(context, ref, settings),
            _buildSwitchTile(
              context,
              title: 'Show 1RM Column',
              value: settings.showRpe,
              onChanged: (v) => ref
                  .read(settingsProvider.notifier)
                  .updateSettings(settings.copyWith(showRpe: v)),
            ),
            _buildSwitchTile(
              context,
              title: 'Show Previous Session Data',
              subtitle: 'Ghost text in input fields',
              value: settings.showPreviousData,
              onChanged: (v) => ref
                  .read(settingsProvider.notifier)
                  .updateSettings(settings.copyWith(showPreviousData: v)),
            ),
            const Divider(height: 32),
            _buildSectionHeader(context, 'Data Management'),
            _buildTile(
              context,
              title: 'Export JSON Backup',
              subtitle: 'Full snapshot for transfer',
              icon: LucideIcons.fileDigit,
              onTap: () =>
                  ref.read(backupServiceProvider.notifier).exportToLocalFile(),
            ),
            _buildTile(
              context,
              title: 'Export Workout Log (CSV)',
              subtitle: 'Excel / Spreadsheet compatible',
              icon: LucideIcons.fileSpreadsheet,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CsvExportScreen())),
            ),
            _buildSwitchTile(
              context,
              title: 'Safe Data Mode',
              subtitle: 'Keeps data safe during updates & backups',
              value: settings.autoBackup,
              onChanged: (v) => ref
                  .read(settingsProvider.notifier)
                  .updateSettings(settings.copyWith(autoBackup: v)),
            ),
            _buildTile(
              context,
              title: 'Import Data from File',
              subtitle: 'Restore from .json backup',
              icon: LucideIcons.upload,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ImportWizardScreen())),
            ),
            const Divider(height: 32),
            _buildSectionHeader(context, 'Privacy & Security'),
            _buildPrivacyCard(context),
            const Divider(height: 32),
            _buildSectionHeader(context, 'Danger Zone', isDanger: true),
            _buildDangerTile(
              context,
              title: 'Clear Workout History',
              onTap: () => _showDeleteConfirmation(context, ref, 'history'),
            ),
            _buildDangerTile(
              context,
              title: 'Factory Reset',
              onTap: () => _showDeleteConfirmation(context, ref, 'reset'),
            ),
            const SizedBox(height: 64),
            _buildTile(
              context,
              title: 'About Gym Mentor',
              icon: LucideIcons.info,
              onTap: () => context.push('/settings/about'),
            ),
            const SizedBox(height: 32),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading settings: $e')),
      ),
    );
  }

  Widget _buildUnitSegmented(
      BuildContext context, WidgetRef ref, SettingsState settings) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: SegmentedButton<WeightUnit>(
          segments: const [
            ButtonSegment(value: WeightUnit.kg, label: Text('KG')),
            ButtonSegment(value: WeightUnit.lbs, label: Text('LBS')),
          ],
          selected: {settings.weightUnit},
          onSelectionChanged: (set) =>
              ref.read(settingsProvider.notifier).updateWeightUnit(set.first),
        ),
      ),
    );
  }

  Widget _buildThemeSegmented(
      BuildContext context, WidgetRef ref, SettingsState settings) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Theme Mode', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                    value: ThemeMode.light,
                    icon: Icon(LucideIcons.sun, size: 16),
                    label: Text('Light')),
                ButtonSegment(
                    value: ThemeMode.dark,
                    icon: Icon(LucideIcons.moon, size: 16),
                    label: Text('Dark')),
                ButtonSegment(
                    value: ThemeMode.system,
                    icon: Icon(LucideIcons.smartphone, size: 16),
                    label: Text('System')),
              ],
              selected: {settings.themeMode},
              onSelectionChanged: (set) =>
                  ref.read(settingsProvider.notifier).updateTheme(set.first),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeSegmented(
      BuildContext context, WidgetRef ref, SettingsState settings) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Font Size', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: SegmentedButton<FontSize>(
              segments: const [
                ButtonSegment(value: FontSize.normal, label: Text('Normal')),
                ButtonSegment(value: FontSize.large, label: Text('Large')),
              ],
              selected: {settings.fontSize},
              onSelectionChanged: (set) => ref
                  .read(settingsProvider.notifier)
                  .updateSettings(settings.copyWith(fontSize: set.first)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccentColorPicker(
      BuildContext context, WidgetRef ref, SettingsState settings) {
    final colors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.red
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Accent Color', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: colors.map((c) {
                final isSelected = settings.accentColor.value == c.value;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () => ref
                        .read(settingsProvider.notifier)
                        .updateAccentColor(c),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 3)
                            : null,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                    color: c.withOpacity(0.4),
                                    blurRadius: 8,
                                    spreadRadius: 2)
                              ]
                            : null,
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestTimerSection(
      BuildContext context, WidgetRef ref, SettingsState settings) {
    return Column(
      children: [
        _buildStepperTile(
            context,
            'Straight Sets',
            settings.restTimeStraight,
            (v) => ref
                .read(settingsProvider.notifier)
                .updateRestTime('straight', v)),
        _buildStepperTile(
            context,
            'Supersets',
            settings.restTimeSuperset,
            (v) => ref
                .read(settingsProvider.notifier)
                .updateRestTime('superset', v)),
        _buildStepperTile(
            context,
            'Dropsets',
            settings.restTimeDropset,
            (v) => ref
                .read(settingsProvider.notifier)
                .updateRestTime('dropset', v)),
      ],
    );
  }

  Widget _buildStepperTile(BuildContext context, String title, int seconds,
      ValueChanged<int> onChanged) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: seconds > 30 ? () => onChanged(seconds - 30) : null,
              icon: const Icon(Icons.remove_circle_outline, size: 20)),
          Container(
            width: 60,
            alignment: Alignment.center,
            child: Text('${seconds}s',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          IconButton(
              onPressed: seconds < 300 ? () => onChanged(seconds + 30) : null,
              icon: const Icon(Icons.add_circle_outline, size: 20)),
        ],
      ),
    );
  }

  Widget _buildBarbellWeightInput(
      BuildContext context, WidgetRef ref, SettingsState settings) {
    return ListTile(
      title: const Text('Barbell Weight'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${settings.barbellWeight}kg',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          const Icon(Icons.edit, size: 16),
        ],
      ),
      onTap: () => _showWeightInputDialog(context, ref, settings),
    );
  }

  Widget _buildAutoIncrementDropdown(
      BuildContext context, WidgetRef ref, SettingsState settings) {
    final options = {0.0: 'Off', 1.0: '+1kg', 2.5: '+2.5kg', 5.0: '+5kg'};
    return ListTile(
      title: const Text('Auto weight increment'),
      subtitle: const Text('Suggests adding weight when targets hit'),
      trailing: DropdownButton<double>(
        value: settings.autoIncrement,
        items: options.entries
            .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
            .toList(),
        onChanged: (v) => ref
            .read(settingsProvider.notifier)
            .updateSettings(settings.copyWith(autoIncrement: v ?? 0.0)),
      ),
    );
  }

  void _showEditNameDialog(
      BuildContext context, WidgetRef ref, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter your name')),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              ref
                  .read(settingsProvider.notifier)
                  .updateName(controller.text.trim());
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showExperienceDialog(
      BuildContext context, WidgetRef ref, SettingsState settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Experience Level'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ExperienceLevel.values
              .map((e) => RadioListTile<ExperienceLevel>(
                    title: Text(_capitalize(e.name)),
                    value: e,
                    groupValue: settings.experienceLevel,
                    onChanged: (val) {
                      ref.read(settingsProvider.notifier).updateSettings(
                          settings.copyWith(experienceLevel: val));
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showWeightInputDialog(
      BuildContext context, WidgetRef ref, SettingsState settings) {
    final controller =
        TextEditingController(text: settings.barbellWeight.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Barbell Weight'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(suffixText: 'kg'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final val = double.tryParse(controller.text) ?? 20.0;
              ref
                  .read(settingsProvider.notifier)
                  .updateSettings(settings.copyWith(barbellWeight: val));
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, String type) {
    final controller = TextEditingController();
    final isReset = type == 'reset';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(isReset ? 'Factory Reset?' : 'Clear History?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isReset
                    ? 'This will wipe ALL data and restart the app setup. This cannot be undone.'
                    : 'This will delete all completed workouts but keep your exercises and programs.',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              const Text('Type DELETE to confirm:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 8),
              TextField(
                controller: controller,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'DELETE'),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            FilledButton(
              onPressed: controller.text == 'DELETE'
                  ? () async {
                      final backupNotifier =
                          ref.read(backupServiceProvider.notifier);
                      if (isReset) {
                        await backupNotifier.factoryReset();
                        if (context.mounted) context.go('/');
                      } else {
                        await backupNotifier.clearWorkoutHistory();
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('History cleared successfully')));
                        }
                      }
                    }
                  : null,
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('CONFIRM DELETE'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(LucideIcons.shieldCheck, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                const Text('Privacy First Architecture',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Your workout data is stored exclusively on your device. We use no cloud sync, no tracking, and no external servers. You own your data 100%.',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDangerTile(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title,
          style:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      trailing:
          const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
      onTap: onTap,
    );
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget _buildSectionHeader(BuildContext context, String title,
      {bool isDanger = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color:
                  isDanger ? Colors.red : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
      ),
    );
  }

  Widget _buildTile(BuildContext context,
      {required String title,
      String? subtitle,
      required IconData icon,
      VoidCallback? onTap}) {
    return ListTile(
      leading:
          Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: TextStyle(color: Theme.of(context).colorScheme.primary))
          : null,
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(BuildContext context,
      {required String title,
      String? subtitle,
      required bool value,
      required ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      value: value,
      onChanged: onChanged,
    );
  }
}
