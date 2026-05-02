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

// ─── Design tokens ────────────────────────────────────────────────────────────
const _kBg      = Color(0xFFF6F6F4);
const _kSurface = Colors.white;
const _kText    = Color(0xFF111111);
const _kMuted   = Color(0xFF8A8A8E);
const _kBorder  = Color(0xFFE5E5EA);
const _kPrimary = Color(0xFF141414);
// ─────────────────────────────────────────────────────────────────────────────

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
      length: 3,
      child: Scaffold(
        backgroundColor: _kBg,
        appBar: AppBar(
          backgroundColor: _kBg,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleSpacing: 20,
          title: Text(
            'Training Programs',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w800,
              fontSize: 26,
              color: _kText,
              letterSpacing: -0.7,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.rotateCcw, size: 20),
              color: _kText,
              tooltip: 'Reset to Sample',
              onPressed: () => _showResetConfirm(context),
            ),
            IconButton(
              icon: const Icon(LucideIcons.download, size: 20),
              color: _kText,
              tooltip: 'Import JSON',
              onPressed: () => _showImportOptions(context, ref),
            ),
            const SizedBox(width: 6),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: _kBorder)),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: _kPrimary,
                indicatorWeight: 2,
                labelColor: _kText,
                unselectedLabelColor: _kMuted,
                labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 15),
                unselectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15),
                tabs: const [
                  Tab(text: 'Exercise Plans'),
                  Tab(text: 'Selected'),
                  Tab(text: 'Mesocycles'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildPlansList(stateAsync),
            _buildSelectedPlansList(stateAsync),
            const MesocycleListView(),
          ],
        ),
        floatingActionButton: Builder(
          builder: (context) {
            final tabController = DefaultTabController.of(context);
            return ListenableBuilder(
              listenable: tabController,
              builder: (context, _) {
                final isMesocycleTab = tabController.index == 2;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FloatingActionButton.extended(
                      elevation: 0,
                      highlightElevation: 0,
                      backgroundColor: _kPrimary,
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
                      icon: const Icon(LucideIcons.plus, color: Colors.white, size: 19),
                      label: Text(
                        isMesocycleTab ? 'Create Mesocycle' : 'New Plan',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
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
                      final haystack =
                          '${t.name} ${t.description ?? ''}'.toLowerCase();
                      return haystack.contains(_selectedGoal.toLowerCase());
                    }).toList();

              if (state.templates.isEmpty) {
                return _buildEmptyState(context, ref);
              }

              return RefreshIndicator(
                onRefresh: () => ref.read(programsProvider.notifier).refresh(),
                color: _kPrimary,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 110),
                  itemCount: filteredTemplates.length,
                  itemBuilder: (context, index) {
                    return _ProgramCard(
                      template: filteredTemplates[index],
                      selectedGoal: _selectedGoal,
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text('Error: \$e')),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedPlansList(AsyncValue<ProgramsState> stateAsync) {
    return stateAsync.when(
      data: (state) {
        final selectedTemplates = state.templates.where((t) => t.isSelected).toList();

        if (selectedTemplates.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: _kBorder.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(LucideIcons.dumbbell, size: 48, color: _kMuted),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No plans selected yet',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _kText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Browse the Plans tab to get started!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      color: _kMuted,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => ref.read(programsProvider.notifier).refresh(),
          color: _kPrimary,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
            itemCount: selectedTemplates.length,
            itemBuilder: (context, index) {
              return _ProgramCard(
                template: selectedTemplates[index],
                selectedGoal: 'All Goals',
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 54,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          final isSelected = _selectedGoal == goal;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedGoal = goal),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? _kPrimary : _kSurface,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: isSelected ? _kPrimary : _kBorder,
                  ),
                ),
                child: Text(
                  goal,
                  style: GoogleFonts.outfit(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : _kText,
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
        backgroundColor: _kSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Reset All Plans?',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w800)),
        content: const Text(
          'This will delete all current programs and restore the professional '
          'sample plan. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.outfit(color: _kMuted)),
          ),
          TextButton(
            onPressed: () {
              ref.read(programsProvider.notifier).resetPrograms();
              Navigator.pop(context);
            },
            child: Text('Reset Now',
                style: GoogleFonts.outfit(
                    color: Colors.red, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showImportOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _kSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: _kBorder,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Import Plan',
                style: GoogleFonts.outfit(
                    fontSize: 20, fontWeight: FontWeight.w800, color: _kText),
              ),
              const SizedBox(height: 14),
              _importTile(
                context: context,
                ref: ref,
                icon: LucideIcons.file,
                title: 'Choose JSON File',
                subtitle: 'Import from a .json plan or exercise list',
                onTap: () {
                  Navigator.pop(context);
                  ref.read(programsProvider.notifier).importTemplate();
                },
              ),
              _importTile(
                context: context,
                ref: ref,
                icon: LucideIcons.clipboard,
                title: 'Paste JSON Data',
                subtitle: 'Paste copied JSON content',
                onTap: () {
                  Navigator.pop(context);
                  _showPasteJsonDialog(context, ref);
                },
              ),
              const Divider(height: 24, color: _kBorder),
              _importTile(
                context: context,
                ref: ref,
                icon: LucideIcons.trophy,
                title: '6-Day PPL Elite',
                subtitle: 'Push/Pull/Legs split with GitHub exercises',
                onTap: () {
                  Navigator.pop(context);
                  ref.read(programsProvider.notifier).importPplEliteProgram();
                },
              ),
              _importTile(
                context: context,
                ref: ref,
                icon: LucideIcons.zap,
                title: '6 Weeks to Six-Pack Abs',
                subtitle: 'Jefit 2-phase abs cutting program',
                onTap: () {
                  Navigator.pop(context);
                  ref.read(programsProvider.notifier).importSixPackAbsProgram();
                },
              ),
              const Divider(height: 24, color: _kBorder),
              _importTile(
                context: context,
                ref: ref,
                icon: LucideIcons.code,
                title: 'View Sample JSON Template',
                subtitle: 'Copy format to use for custom imports',
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

  Widget _importTile({
    required BuildContext context,
    required WidgetRef ref,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      leading: Icon(icon, color: _kText, size: 22),
      title: Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle,
          style: GoogleFonts.outfit(fontSize: 13, color: _kMuted)),
      onTap: onTap,
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
        backgroundColor: _kSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Paste JSON',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w800)),
            TextButton.icon(
              onPressed: () async {
                final data = await Clipboard.getData(Clipboard.kTextPlain);
                if (data?.text != null) controller.text = data!.text!;
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
              hintText: 'Paste your JSON here…',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: GoogleFonts.outfit(color: _kMuted)),
          ),
          TextButton(
            onPressed: () async {
              final jsonStr = controller.text.trim();
              if (jsonStr.isEmpty) return;
              Navigator.pop(dialogContext);
              try {
                await ref
                    .read(programsProvider.notifier)
                    .importTemplateFromString(jsonStr);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Plan imported successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error importing plan: \$e')),
                  );
                }
              }
            },
            child: Text('Import',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showSampleJsonDialog(BuildContext context, WidgetRef ref) {
    final repo = ref.read(workoutRepositoryProvider);
    final rawJson = repo.getSampleJson();
    final decoded = jsonDecode(rawJson);
    final prettyJson = const JsonEncoder.withIndent('  ').convert(decoded);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _kSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sample JSON',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w800)),
            IconButton(
              icon: const Icon(LucideIcons.copy, size: 20),
              tooltip: 'Copy',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: prettyJson));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard')),
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
              Text(
                'Use this format for custom plan imports.',
                style: GoogleFonts.outfit(fontSize: 13, color: _kMuted),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kBorder),
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      prettyJson,
                      style: GoogleFonts.firaCode(
                          fontSize: 11, color: const Color(0xFF37474F)),
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
            child: Text('Close',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.dumbbell, size: 56, color: _kBorder),
            const SizedBox(height: 20),
            Text(
              'No plans yet',
              style: GoogleFonts.outfit(
                  fontSize: 20, fontWeight: FontWeight.w800, color: _kText),
            ),
            const SizedBox(height: 8),
            Text(
              'Import an existing plan or create your first one.',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(fontSize: 14, color: _kMuted),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _showImportOptions(context, ref),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _kText,
                    side: const BorderSide(color: _kBorder),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  icon: const Icon(LucideIcons.download, size: 18),
                  label: Text('Import',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => context.push('/programs/create'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  icon: const Icon(LucideIcons.plus, size: 18),
                  label: Text('Create',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Program Card
// ─────────────────────────────────────────────────────────────────────────────

class _ProgramCard extends ConsumerWidget {
  final ent.WorkoutProgram template;
  final String selectedGoal;

  const _ProgramCard({required this.template, required this.selectedGoal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = _resolveTags(template, selectedGoal);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kBorder),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => context.push('/programs/details/${template.id}'),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        template.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          height: 1.1,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.6,
                          color: _kText,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      icon: const Icon(LucideIcons.ellipsisVertical,
                          size: 19, color: _kMuted),
                      elevation: 1,
                      color: _kSurface,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit Plan', style: GoogleFonts.outfit())),
                        PopupMenuItem(
                            value: 'export',
                            child: Text('Export JSON', style: GoogleFonts.outfit())),
                        PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete',
                                style: GoogleFonts.outfit(color: Colors.red))),
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
                const SizedBox(height: 6),
                Text(
                  '${template.days.length} Days • ${template.days.fold(0, (sum, day) => sum + day.exercises.length)} Exercises',
                  style: GoogleFonts.outfit(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: _kMuted,
                  ),
                ),
                if (tags.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: tags.take(2).map((t) => _minimalTag(t)).toList(),
                  ),
                ],
                if ((template.description ?? '').trim().isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    template.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      height: 1.45,
                      color: _kMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                const Divider(height: 1, color: _kBorder),
                const SizedBox(height: 14),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await ref.read(programsProvider.notifier).toggleSelected(
                          template.id,
                          !template.isSelected,
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                template.isSelected
                                    ? '${template.name} removed from Selected'
                                    : '${template.name} added to Selected',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.star,
                            size: 15,
                            color: template.isSelected ? _kPrimary : _kMuted,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            template.isSelected ? 'Selected' : 'Select plan',
                            style: GoogleFonts.outfit(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: template.isSelected ? _kPrimary : _kMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        context.push('/programs/details/${template.id}');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _kText,
                        side: const BorderSide(color: _kBorder),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text('View',
                          style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 14)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        final repo = ref.read(workoutRepositoryProvider);
                        final days = await repo.getTemplateDays(template.id);
                        if (days.isNotEmpty && context.mounted) {
                          final id = await ref
                              .read(workoutHomeProvider.notifier)
                              .startWorkout(
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
                        backgroundColor: _kPrimary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text('Start',
                          style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 14)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> _resolveTags(ent.WorkoutProgram template, String selectedGoal) {
    if (selectedGoal != 'All Goals') return [selectedGoal];
    final text = '${template.name} ${template.description ?? ''}'.toLowerCase();
    final tags = <String>[];
    if (text.contains('fat loss') || text.contains('fat-loss')) tags.add('Fat Loss');
    if (text.contains('muscle') || text.contains('hypertrophy')) tags.add('Muscle Gain');
    if (text.contains('strength')) tags.add('Strength');
    if (text.contains('aesthetic')) tags.add('Aesthetics');
    if (text.contains('athletic') || text.contains('performance')) tags.add('Performance');
    if (text.contains('ppl') || text.contains('push') || text.contains('pull')) tags.add('PPL');
    if (tags.isEmpty) tags.add('General');
    return tags.toSet().toList();
  }

  Widget _minimalTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F5),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _kBorder),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: _kText,
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _kSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Delete Plan?',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w800)),
        content: Text(
          'Are you sure you want to delete "${template.name}"? '
          'This action cannot be undone.',
          style: GoogleFonts.outfit(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.outfit(color: _kMuted)),
          ),
          TextButton(
            onPressed: () {
              ref.read(programsProvider.notifier).deleteTemplate(template.id);
              Navigator.pop(context);
            },
            child: Text('Delete',
                style: GoogleFonts.outfit(color: Colors.red, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
