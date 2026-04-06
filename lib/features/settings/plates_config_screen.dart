import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:gym_gemini_pro/features/settings/settings_provider.dart';

class PlatesConfigScreen extends ConsumerWidget {
  const PlatesConfigScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Plates'),
        actions: [
          TextButton(
            onPressed: () => _showPresetsDialog(context, ref),
            child: const Text('Presets'),
          ),
        ],
      ),
      body: settingsAsync.when(
        data: (settings) {
          final sortedKeys = settings.availablePlates.keys.toList()
            ..sort((a, b) => double.parse(b).compareTo(double.parse(a)));
          
          if (sortedKeys.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.dumbbell, size: 64, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  const Text('No plates configured', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  const Text('Add some manually or use presets'),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: sortedKeys.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final weight = sortedKeys[index];
              final count = settings.availablePlates[weight]!;
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text('$weight kg', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text('$count available'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _updateQuantity(ref, settings, weight, count - 1),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('$count', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () => _updateQuantity(ref, settings, weight, count + 1),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => _updateQuantity(ref, settings, weight, 0),
                        icon: const Icon(LucideIcons.trash2, color: Colors.red, size: 20),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPlateDialog(context, ref),
        child: const Icon(LucideIcons.plus),
      ),
    );
  }

  void _updateQuantity(WidgetRef ref, dynamic settings, String weight, int newCount) {
    final updatedPlates = Map<String, int>.from(settings.availablePlates);
    if (newCount <= 0) {
      updatedPlates.remove(weight);
    } else {
      updatedPlates[weight] = newCount;
    }
    ref.read(settingsProvider.notifier).updateSettings(settings.copyWith(availablePlates: updatedPlates));
  }

  void _showAddPlateDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Plate Weight'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'e.g. 1.25', suffixText: 'kg'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final weight = controller.text.trim();
              if (weight.isNotEmpty) {
                final settings = ref.read(settingsProvider).value!;
                final updated = Map<String, int>.from(settings.availablePlates);
                updated[weight] = updated[weight] ?? 2;
                ref.read(settingsProvider.notifier).updateSettings(settings.copyWith(availablePlates: updated));
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showPresetsDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Load Standard Presets?'),
        content: const Text('This will add a standard gym set (1.25, 2.5, 5, 10, 15, 20, 25 kg) to your inventory.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final presets = {'1.25': 4, '2.5': 4, '5.0': 4, '10.0': 4, '15.0': 2, '20.0': 4, '25.0': 2};
              final settings = ref.read(settingsProvider).value!;
              ref.read(settingsProvider.notifier).updateSettings(settings.copyWith(availablePlates: presets));
              Navigator.pop(context);
            },
            child: const Text('Load'),
          ),
        ],
      ),
    );
  }
}
