import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/services/export_service.dart';
import 'package:ai_gym_mentor/services/import_service.dart';
import 'package:ai_gym_mentor/features/settings/import_mapping_screen.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class ExcelSyncScreen extends ConsumerStatefulWidget {
  const ExcelSyncScreen({super.key});

  @override
  ConsumerState<ExcelSyncScreen> createState() => _ExcelSyncScreenState();
}

class _ExcelSyncScreenState extends ConsumerState<ExcelSyncScreen> {
  bool _isProcessing = false;

  Future<void> _handleExport() async {
    setState(() => _isProcessing = true);
    try {
      final result = await ref.read(exportServiceProvider).exportToXlsx();
      if (mounted && result != null) {
        _showExportResultSheet(result);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _handleImport() async {
    setState(() => _isProcessing = true);
    try {
      final schema = await ref.read(importServiceProvider).getExcelSchema();
      if (mounted) {
        setState(() => _isProcessing = false);
        if (schema == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Import cancelled or failed.')),
          );
        } else {
          // Navigate to mapping screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImportMappingScreen(schema: schema),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isProcessing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Import failed: $e')),
        );
      }
    }
  }

  Future<void> _handleQuickSave() async {
    setState(() => _isProcessing = true);
    try {
      final result = await ref.read(exportServiceProvider).saveExcelToDownloads();
      if (mounted && result != null) {
        _showExportResultSheet(result, isQuickSave: true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Quick save failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excel Data Sync'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSyncCard(
                  title: 'Export to Excel (.xlsx)',
                  subtitle: 'Includes Exercise Log + Body Measurements in 2 sheets',
                  icon: LucideIcons.fileSpreadsheet,
                  iconColor: Colors.green,
                  onTap: _isProcessing ? null : _handleExport,
                ),
                const SizedBox(height: 20),
                _buildSyncCard(
                  title: 'Import from Excel (.xlsx)',
                  subtitle: 'Merge workout and measurement history from a spreadsheet',
                  icon: LucideIcons.fileDown,
                  iconColor: Colors.green,
                  onTap: _isProcessing ? null : _handleImport,
                ),
                const SizedBox(height: 20),
                _buildSyncCard(
                  title: 'Save excel file',
                  subtitle: 'Auto-save to /Download/GymLog/gym_log.xlsx',
                  icon: LucideIcons.save,
                  iconColor: Colors.blue,
                  onTap: _isProcessing ? null : _handleQuickSave,
                ),
                const Spacer(),
                const Center(
                  child: Text(
                    'Tip: Use Excel for bulk logging or moving data between devices.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          if (_isProcessing)
            Container(
              color: Colors.black26,
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Syncing data...', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSyncCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  void _showExportResultSheet(Map<String, dynamic> result, {bool isQuickSave = false}) {
    final double sizeInKb = (result['fileSize'] as int) / 1024;
    final String sizeStr = sizeInKb > 1024 
        ? '${(sizeInKb / 1024).toStringAsFixed(1)} MB'
        : '${sizeInKb.toStringAsFixed(1)} KB';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.check, color: Colors.green, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              isQuickSave ? 'Data Saved Successfully' : 'Data Export Ready',
              style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              isQuickSave 
                ? 'Your logs have been saved to /Download/GymLog/gym_log.xlsx'
                : 'Your training and physique logs have been compiled.',
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildResultRow('Exercise Log', '${result['exerciseRows']} rows', LucideIcons.dumbbell),
            const Divider(height: 32),
            _buildResultRow('Body Measurements', '${result['measurementRows']} rows', LucideIcons.ruler),
            const Divider(height: 32),
            _buildResultRow('File Size', sizeStr, LucideIcons.fileBox),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(LucideIcons.x, size: 18),
                    label: const Text('Close'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () async {
                      Navigator.pop(context);
                      if (isQuickSave) {
                        // Already saved, maybe offer to share anyway?
                        Share.shareXFiles([XFile(result['path'])], text: 'My Gym Log Export');
                      } else {
                        // For manual export, save it first then share or just share
                        // User specifically asked for "save option" instead of "share option"
                        await ref.read(exportServiceProvider).saveExcelToDownloads();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('File saved to Downloads/GymLog')),
                        );
                      }
                    },
                    icon: Icon(isQuickSave ? LucideIcons.share2 : LucideIcons.save, size: 18),
                    label: Text(isQuickSave ? 'Share Anyway' : 'Save File'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade400),
        const SizedBox(width: 16),
        Expanded(
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
