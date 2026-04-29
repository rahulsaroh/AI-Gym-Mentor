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

  static const _bg = Color(0xFFF7F7F5);
  static const _surface = Colors.white;
  static const _text = Color(0xFF111111);
  static const _muted = Color(0xFF6F6F73);
  static const _border = Color(0xFFE8E8EA);
  static const _primary = Color(0xFF161616);

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(programsProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: _bg,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 20,
          title: Text(
            'Training Programs',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w800,
              fontSize: 28,
              color: _text,
              letterSpacing: -0.8,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.rotateCcw, size: 21),
              color: _text,
              tooltip: 'Reset to Sample',
              onPressed: () => _showResetConfirm(context),
            ),
            IconButton(
              icon: const Icon(LucideIcons.download, size: 21),
              color: _text,
              tooltip: 'Import JSON',
              onPressed: () => _showImportOptions(context, ref),
            ),
            const SizedBox(width: 8),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: TabBar(
              dividerColor: _border,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: _text,
              indicatorWeight: 2.2,
              labelColor: _text,
              unselectedLabelColor: _muted,
              labelStyle: GoogleFonts.outfit(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              unselectedLabelStyle: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              tabs: const [
                Tab(text: 'Exercise Plans'),
                Tab(text: 'Mesocycles'),
              ],
            ),
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
                      elevation: 0,
                      highlightElevation: 0,
                      backgroundColor: _primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      onPressed: () {
                        if (isMesocycleTab) {
                          context.push('/programs/mesocycle/create');
                        } else {
                          context.push('/programs/create');
                        }
                      },
                      icon: const Icon(LucideIcons.plus, color: Colors.white, size: 20),
                      label: Text(
                        isMesocycleTab ? 'Create Mesocycle' : 'New Plan',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
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
                      final name = t.name.toLowerCase();
                      final goal = _selectedGoal.toLowerCase();
                      return desc.contains(goal) || name.contains(goal);
                    }).toList();

              if (state.templates.isEmpty) {
                return _buildEmptyState(context, ref);
              }

              return RefreshIndicator(
                onRefresh: () => ref.read(programsProvider.notifier).refresh(),
                color: _primary,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 110),
                  itemCount: filteredTemplates.length,
                  itemBuilder: (context, index) {
                    final template = filteredTemplates[index];
                    return _ProgramCard(
                      template: template,
                      selectedGoal: _selectedGoal,
                    );
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
      height: 56,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          final isSelected = _selectedGoal == goal;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedGoal = goal),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? _primary : _surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? _primary : _border,
                  ),
                ),
                child: Center(
                  child: Text(
                    goal,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : _text,
                    ),
                  ),
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
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset All Plans?'),
        content: const Text(
          'This will delete all current programs and restore the professional sample plan. This cannot be undone.',
        ),
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
      backgroundColor: _surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Import Plan',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _text,
                ),
              ),
              const SizedBox(height: 18),
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                leading: const Icon(LucideIcons.file),
                title: const Text('Choose JSON File'),
                subtitle: const Text('Import from a .json plan or exercise list'),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(programsProvider.notifier).importTemplate();
                },
              ),
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                leading: const Icon(LucideIcons.clipboard),
                title: const Text('Paste JSON Data'),
                subtitle: const Text('Paste copied JSON content'),
                onTap: () {
                  Navigator.pop(context);
                  _showPasteJsonDialog(context, ref);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgramCard extends ConsumerWidget {
  final ent.WorkoutProgram template;
  final String selectedGoal;

  const _ProgramCard({
    required this.template,
    required this.selectedGoal,
  });

  static const _surface = Colors.white;
  static const _text = Color(0xFF111111);
  static const _muted = Color(0xFF6F6F73);
  static const _border = Color(0xFFE8E8EA);
  static const _primary = Color(0xFF161616);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = '12 weeks';
    final tags = _resolveTags(template, selectedGoal);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _border),
      ),
      child: InkWell(
        onTap: () => context.push('/programs/details/${template.id}'),
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      template.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        height: 1.05,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                        color: _text,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(LucideIcons.ellipsisVertical, size: 19, color: _muted),
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit Plan')),
                      const PopupMenuItem(value: 'export', child: Text('Export JSON')),
                      const PopupMenuItem(value: 'delete', child: Text('Delete')),
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
              const SizedBox(height: 8),
              Text(
                duration,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _muted,
                ),
              ),
              if (tags.isNotEmpty) ...[
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.take(2).map((tag) => _minimalTag(tag)).toList(),
                ),
              ],
              if ((template.description ?? '').trim().isNotEmpty) ...[
                const SizedBox(height: 14),
                Text(
                  template.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 14.5,
                    height: 1.45,
                    color: _muted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const SizedBox(height: 18),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () => context.push('/programs/details/${template.id}'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _text,
                      side: const BorderSide(color: _border),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: Text(
                      'View',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Start',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () async {
                    ref.read(programsProvider.notifier).makeDefault(template.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${template.name} set as default')),
                    );
                  },
                  icon: const Icon(LucideIcons.star, size: 16),
                  label: Text(
                    'Set as default',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: _muted,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _resolveTags(ent.WorkoutProgram template, String selectedGoal) {
    final text = '${template.name} ${template.description ?? ''}'.toLowerCase();
    final tags = <String>[];

    if (selectedGoal != 'All Goals') {
      tags.add(selectedGoal);
    } else {
      if (text.contains('fat loss')) tags.add('Fat Loss');
      if (text.contains('muscle')) tags.add('Muscle Gain');
      if (text.contains('strength')) tags.add('Strength');
      if (text.contains('aesthetic')) tags.add('Aesthetics');
      if (text.contains('athletic')) tags.add('Performance');
    }

    if (tags.isEmpty) tags.add('General');
    return tags.toSet().toList();
  }

  Widget _minimalTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F5),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _border),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: _text,
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Delete Plan?',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w800),
        ),
        content: Text(
          'Are you sure you want to delete "${template.name}"? This action cannot be undone.',
          style: GoogleFonts.outfit(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.outfit(color: _muted),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(programsProvider.notifier).deleteTemplate(template.id);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: GoogleFonts.outfit(
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
