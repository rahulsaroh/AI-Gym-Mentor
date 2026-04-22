import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/services/import_service.dart';

class WelcomeBackScreen extends ConsumerStatefulWidget {
  final String filePath;

  const WelcomeBackScreen({super.key, required this.filePath});

  @override
  ConsumerState<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends ConsumerState<WelcomeBackScreen> {
  bool _isImporting = false;
  String? _error;

  Future<void> _handleImport() async {
    setState(() {
      _isImporting = true;
      _error = null;
    });

    try {
      final importService = ref.read(importServiceProvider);
      final results = await importService.importFromXlsx(File(widget.filePath));
      
      if (mounted) {
        final total = results['workouts']! + results['measurements']!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully restored $total records!')),
        );
        context.go('/home');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isImporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.sparkles, size: 64, color: Colors.blue),
            const SizedBox(height: 24),
            Text(
              'Welcome Back!',
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'We found a backup of your workout data on this device. Would you like to restore it now?',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 48),
            if (_isImporting)
              const CircularProgressIndicator()
            else ...[
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: _handleImport,
                  icon: const Icon(LucideIcons.cloudDownload),
                  label: const Text('Restore My Progress'),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go('/home'),
                child: Text(
                  'Start Fresh',
                  style: TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ),
            ],
            if (_error != null) ...[
              const SizedBox(height: 24),
              Text(
                'Error: $_error',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
