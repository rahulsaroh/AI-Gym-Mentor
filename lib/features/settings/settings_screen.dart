import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:gym_gemini_pro/features/settings/models/settings_state.dart';
import 'package:gym_gemini_pro/features/settings/settings_provider.dart';
import 'package:gym_gemini_pro/core/auth/auth_provider.dart';
import 'package:gym_gemini_pro/services/backup_service.dart';
import 'package:gym_gemini_pro/features/settings/csv_export_screen.dart';
import 'package:gym_gemini_pro/features/settings/import_wizard_screen.dart';
import 'package:gym_gemini_pro/services/sync_worker.dart';

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
              title: 'Show RPE Field',
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
            _buildSectionHeader(context, 'Google Sheets Sync'),
            _buildSheetsSyncSection(context, ref, settings),
            const Divider(height: 32),
            _buildSectionHeader(context, 'Data Management'),
            _buildTile(
              context,
              title: 'Export JSON Backup',
              subtitle: 'Full snapshot for transfer',
              icon: LucideIcons.fileJson,
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
              title: 'About GYM Kilo',
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

  Widget _buildSheetsSyncSection(
      BuildContext context, WidgetRef ref, SettingsState settings) {
    if (settings.googleDriveEmail == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: FilledButton.icon(
          onPressed: () => context.push('/settings/sheets-setup'),
          icon: const Icon(LucideIcons.cloud),
          label: const Text('Connect Google Account'),
          style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 48)),
        ),
      );
    }

    final syncStatus = ref.watch(syncWorkerProvider);
    final isSyncing = syncStatus == SyncStatus.syncing;

    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(child: Icon(LucideIcons.user, size: 20)),
          title: Text(settings.googleDriveEmail!),
          subtitle: Text(settings.lastSynced != null
              ? 'Last synced: ${DateFormat.yMd().add_jm().format(settings.lastSynced!)}'
              : 'Not synced yet'),
        ),
        _buildSwitchTile(
          context,
          title: 'Auto-Sync Workouts',
          subtitle: 'Syncs automatically after finishing',
          value: settings.autoBackup,
          onChanged: (v) => ref
              .read(settingsProvider.notifier)
              .updateSettings(settings.copyWith(autoBackup: v)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isSyncing
                      ? null
                      : () =>
                          ref.read(syncWorkerProvider.notifier).processQueue(),
                  icon: isSyncing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(LucideIcons.refreshCw, size: 18),
                  label: Text(isSyncing ? 'Syncing...' : 'Sync Now'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showSignOutConfirmation(context, ref),
                  icon: const Icon(LucideIcons.logOut, size: 18),
                  label: const Text('Sign Out'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(LucideIcons.history, size: 20),
          title: const Text('View Sync History'),
          subtitle: const Text('Detailed logs of recent cloud syncs'),
          trailing: const Icon(Icons.chevron_right, size: 20),
          onTap: () => context.push('/settings/sync-log'),
        ),
      ],
    );
  }

  void _showSignOutConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out?'),
        content: const Text(
            'Your local data will remain, but automatic sync to Google Sheets will stop.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              await ref.read(googleSignInProvider).signOut();
              await ref.read(settingsProvider.notifier).updateSettings(
                  (await ref.read(settingsProvider.future))
                      .copyWith(googleDriveEmail: null));
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Sign Out'),
          ),
        ],
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
}
