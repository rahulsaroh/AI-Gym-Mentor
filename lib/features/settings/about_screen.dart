import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text('About GYM Kilo')),
      body: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          final info = snapshot.data;
          
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(LucideIcons.dumbbell, color: Colors.white, size: 48),
                    ),
                    const SizedBox(height: 16),
                    Text('GYM Kilo Pro', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                    Text('Version ${info?.version ?? '1.0.0'} (${info?.buildNumber ?? '1'})', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline)),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              
              const Text("What's New", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 16),
              _buildChangelogItem(
                context, 
                'v1.0.0 - Phase 7 Release', 
                [
                  'Complete Settings & Personalization Hub',
                  'Dynamic Material 3 Thoming & Accent Colors',
                  'Plate inventory & Barbell calculation support',
                  'JSON/CSV Export capabilities',
                  'Analytics Dashboard v1 (Phase 6 features)',
                ]
              ),
              _buildChangelogItem(
                context, 
                'v0.9.0 - Alpha Phase', 
                [
                  'Core Workout Logging Engine',
                  'Advanced Rest Timer',
                  'Muscle Balance Radar Charts',
                ]
              ),
              
              const SizedBox(height: 32),
              const Divider(),
              ListTile(
                title: const Text('Open Source Licenses'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => showLicensePage(
                  context: context,
                  applicationName: 'GYM Kilo Pro',
                  applicationVersion: info?.version,
                ),
              ),
              const SizedBox(height: 64),
              const Center(
                child: Text('Made with ❤️ for the Fitness Community', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChangelogItem(BuildContext context, String version, List<String> changes) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(version, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          ...changes.map((c) => Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text(c, style: const TextStyle(fontSize: 14))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
