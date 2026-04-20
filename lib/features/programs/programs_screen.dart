import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/core/domain/entities/workout_program.dart' as ent;
import 'package:ai_gym_mentor/features/programs/providers/programs_notifier.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';
import 'package:ai_gym_mentor/features/programs/components/mesocycle_list_view.dart';

class ProgramsScreen extends ConsumerStatefulWidget {
  const ProgramsScreen({super.key});

  @override
  ConsumerState<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends ConsumerState<ProgramsScreen> {
  String _selectedGoal = 'All Goals';
  final List<String> _goals = [
    'All Goals',
    'Aesthetics',
    'Athletic Performance',
    'Muscle Gain',
    'Fat Loss',
    'Strength',
  ];

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(programsProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text('Training Programs',
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.rotateCcw),
              tooltip: 'Reset to Sample',
              onPressed: () => _showResetConfirm(context),
            ),
            IconButton(
              icon: const Icon(LucideIcons.download),
              onPressed: () => _showImportOptions(context, ref),
              tooltip: 'Import JSON',
            ),
          ],
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Exercise Plans'),
              Tab(text: 'Mesocycles'),
            ],
            labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            indicatorColor: Colors.orange[700],
            indicatorWeight: 3,
            labelColor: Colors.orange[800],
            unselectedLabelColor: Colors.grey[600],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPlansList(stateAsync),
            const MesocycleListView(),
          ],
        ),
        floatingActionButton: Builder(
          builder: (context) {
            final tabController = DefaultTabController.of(context);
            return ListenableBuilder(
              listenable: tabController,
              builder: (context, _) {
                final isMesocycleTab = tabController.index == 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        if (isMesocycleTab) {
                          context.push('/programs/mesocycle/create');
                        } else {
                          context.push('/programs/create');
                        }
                      },
                      backgroundColor: Colors.orange[700],
                      icon: const Icon(LucideIcons.plus, color: Colors.white),
                      label: Text(
                        isMesocycleTab ? 'Create Mesocycle' : 'New Plan',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildPlansList(AsyncValue<ProgramsState> stateAsync) {
    return Column(
      children: [
        _buildFilters(),
        Expanded(
          child: stateAsync.when(
            data: (state) {
              final filteredTemplates = _selectedGoal == 'All Goals'
                  ? state.templates
                  : state.templates.where((t) {
                      final desc = t.description?.toLowerCase() ?? '';
                      return desc.contains(_selectedGoal.toLowerCase());
                    }).toList();

              if (state.templates.isEmpty) {
                return _buildEmptyState(context, ref);
              }
              return RefreshIndicator(
                onRefresh: () => ref.read(programsProvider.notifier).refresh(),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  itemCount: filteredTemplates.length,
                  itemBuilder: (context, index) {
                    final template = filteredTemplates[index];
                    return _ProgramCard(template: template);
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text('Error: $e')),
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          final isSelected = _selectedGoal == goal;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(goal),
              onSelected: (selected) {
                setState(() => _selectedGoal = goal);
              },
              labelStyle: GoogleFonts.outfit(
                color: isSelected ? Colors.teal[900] : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              backgroundColor: Colors.white,
              selectedColor: Colors.teal[50],
              checkmarkColor: Colors.teal[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: isSelected ? Colors.teal[200]! : Colors.grey[300]!,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showResetConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Plans?'),
        content: const Text(
            'This will delete all current programs and restore the professional sample plan. This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(programsProvider.notifier).resetPrograms();
              Navigator.pop(context);
            },
            child: const Text('Reset Now', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showImportOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Import Plan',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(LucideIcons.file),
                title: const Text('Choose JSON File'),
                subtitle: const Text('Import from a .json plan or exercise list'),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(programsProvider.notifier).importTemplate();
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.clipboard),
                title: const Text('Paste JSON Data'),
                subtitle: const Text('Paste copied JSON content'),
                onTap: () {
                  Navigator.pop(context);
                  _showPasteJsonDialog(context, ref);
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(LucideIcons.trophy, color: Colors.orange[700]),
                title: const Text('6 Day PPL Elite'),
                subtitle: const Text('Push/Pull/Legs split with GitHub exercises'),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(programsProvider.notifier).importPplEliteProgram();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(LucideIcons.code),
                title: const Text('View Sample JSON Template'),
                subtitle: const Text('Copy format to use with your own AI'),
                onTap: () {
                  Navigator.pop(context);
                  _showSampleJsonDialog(context, ref);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPasteJsonDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData?.text != null) {
      controller.text = clipboardData!.text!;
    }
    
    if (!context.mounted) return;
    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Paste JSON Data', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            TextButton.icon(
              onPressed: () async {
                final data = await Clipboard.getData(Clipboard.kTextPlain);
                if (data?.text != null) {
                  controller.text = data!.text!;
                }
              },
              icon: const Icon(LucideIcons.clipboard, size: 16),
              label: const Text('Paste'),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: controller,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Paste your JSON here...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: GoogleFonts.outfit(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              final jsonStr = controller.text.trim();
              if (jsonStr.isEmpty) {
                return;
              }
              Navigator.pop(dialogContext);
              try {
                await ref.read(programsProvider.notifier).importTemplateFromString(jsonStr);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Plan imported successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error importing plan: $e')),
                  );
                }
              }
            },
            child: Text('Import', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showSampleJsonDialog(BuildContext context, WidgetRef ref) {
    final repo = ref.read(workoutRepositoryProvider);
    final rawJson = repo.getSampleJson();
    
    // Pretty-print JSON
    final decoded = jsonDecode(rawJson);
    final prettyJson = const JsonEncoder.withIndent('  ').convert(decoded);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sample JSON Template', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(LucideIcons.copy, size: 20),
              tooltip: 'Copy to Clipboard',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: prettyJson));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('JSON copied to clipboard')),
                );
              },
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Use this format to ask your AI (ChatGPT/Gemini) to generate new plans for you.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      prettyJson,
                      style: GoogleFonts.firaCode(fontSize: 11, color: Colors.blueGrey[900]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.calendar, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No plans found',
            style:
                GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Import a plan or create your first one.',
            style: GoogleFonts.outfit(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => context.push('/programs/create'),
                icon: const Icon(LucideIcons.plus),
                label: const Text('Create New'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => _showImportOptions(context, ref),
                icon: const Icon(LucideIcons.download),
                label: const Text('Import'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgramCard extends ConsumerWidget {
  final ent.WorkoutProgram template;
  const _ProgramCard({required this.template});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine colors based on goal
    final goal = 'Aesthetics'; // Fallback since WorkoutProgram doesn't have a goal property
    final duration = '12 weeks'; // Fallback since WorkoutProgram doesn't have a duration property

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: () => context.push('/programs/details/${template.id}'),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          template.name,
                          style: GoogleFonts.outfit(
                              fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          duration,
                          style: GoogleFonts.outfit(
                              fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(LucideIcons.ellipsisVertical, size: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(children: [
                          Icon(LucideIcons.pencil, size: 18),
                          SizedBox(width: 8),
                          Text('Edit Plan')
                        ]),
                      ),
                      const PopupMenuItem(
                        value: 'export',
                        child: Row(children: [
                          Icon(LucideIcons.share, size: 18),
                          SizedBox(width: 8),
                          Text('Export JSON')
                        ]),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(children: [
                          Icon(LucideIcons.trash, size: 18, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red))
                        ]),
                      ),
                    ],
                    onSelected: (val) {
                      if (val == 'edit') {
                        context.push('/programs/edit/${template.id}');
                      } else if (val == 'export') {
                        ref.read(programsProvider.notifier).exportTemplate(template.id);
                      } else if (val == 'delete') {
                        _showDeleteDialog(context, ref);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  _tag(goal, Colors.teal),
                  _tag('Muscle Gain', Colors.orange),
                  _tag('Fat Loss', Colors.blue),
                ],
              ),
              const SizedBox(height: 16),
              if (template.description != null) ...[
                Text(
                  template.description!,
                  style: GoogleFonts.outfit(
                      fontSize: 14, color: Colors.grey[600], height: 1.4),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
              ],
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () => context.push('/programs/details/${template.id}'),
                    icon: const Icon(LucideIcons.info, size: 18),
                    label: const Text('Details'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.teal[700],
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () async {
                      final repo = ref.read(workoutRepositoryProvider);
                      final days = await repo.getTemplateDays(template.id);
                      if (days.isNotEmpty && context.mounted) {
                        final id = await ref.read(workoutHomeProvider.notifier).startWorkout(
                              templateId: template.id,
                              dayId: days.first.id,
                              name: template.name,
                            );
                        if (context.mounted) {
                          context.push('/app/workout/active?id=$id&dayId=${days.first.id}');
                        }
                      }
                    },
                    icon: const Icon(LucideIcons.play, size: 18),
                    label: const Text('Start'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.orange[700],
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () async {
                      ref.read(programsProvider.notifier).makeDefault(template.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${template.name} set as default')),
                      );
                    },
                    icon: const Icon(LucideIcons.star, size: 16),
                    label: const Text('Set Default'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[900],
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color.withOpacity(0.8), fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStat(BuildContext context, IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Plan?',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: Text(
            'Are you sure you want to delete "${template.name}"? This action cannot be undone.',
            style: GoogleFonts.outfit()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                Text('Cancel', style: GoogleFonts.outfit(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(programsProvider.notifier)
                  .deleteTemplate(template.id);
              Navigator.pop(context);
            },
            child: Text('Delete',
                style: GoogleFonts.outfit(
                    color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
