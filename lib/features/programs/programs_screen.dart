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
const _kBg      = Color(0xFFFBFBF9);
const _kSurface = Colors.white;
const _kText    = Color(0xFF111111);
const _kMuted   = Color(0xFF8A8A8E);
const _kBorder  = Color(0xFFE5E5EA);
const _kPrimary = Colors.orange; // Vibrant orange instead of black
const _kAccent  = Color(0xFFFB923C); // Warm orange for CTA
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
    'Performance',
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
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 120,
              floating: true,
              pinned: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: _kBg,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                title: Text(
                  'Training Programs',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    color: _kText,
                    letterSpacing: -0.8,
                  ),
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
                const SizedBox(width: 8),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                child: Container(
                  color: _kBg,
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _kBorder.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TabBar(
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              color: _kSurface,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            labelColor: _kText,
                            unselectedLabelColor: _kMuted,
                            labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 13.5),
                            unselectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 13.5),
                            tabs: const [
                              Tab(text: 'All Plans'),
                              Tab(text: 'Selected'),
                              Tab(text: 'Cycles'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                maxHeight: 64,
                minHeight: 64,
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildPlansList(stateAsync),
              _buildSelectedPlansList(stateAsync),
              const MesocycleListView(),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            final tabController = DefaultTabController.of(context);
            return ListenableBuilder(
              listenable: tabController,
              builder: (context, _) {
                final isMesocycleTab = tabController.index == 2;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_kAccent, _kAccent.withValues(alpha: 0.8)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: _kAccent.withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: FloatingActionButton.extended(
                      elevation: 0,
                      focusElevation: 0,
                      hoverElevation: 0,
                      highlightElevation: 0,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
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
                        isMesocycleTab ? 'Create Mesocycle' : 'New Training Plan',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
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
                color: _kAccent,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
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
            error: (e, s) => Center(child: Text('Error: $e')),
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
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: _kBorder.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(LucideIcons.dumbbell, size: 64, color: _kMuted),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'No active programs',
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _kText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Select a training plan from the main library to start tracking your progress here.',
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
          color: _kAccent,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
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
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          final isSelected = _selectedGoal == goal;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => setState(() => _selectedGoal = goal),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? _kAccent : _kSurface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: _kAccent.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ] : [],
                  border: Border.all(
                    color: isSelected ? _kAccent : _kBorder,
                  ),
                ),
                child: Center(
                  child: Text(
                    goal,
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : _kText,
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
        backgroundColor: _kSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text('Reset Library?',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w900)),
        content: Text(
          'This will permanently delete your custom programs and restore the original templates.',
          style: GoogleFonts.outfit(height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.outfit(color: _kMuted, fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(programsProvider.notifier).resetPrograms();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Reset', style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showImportOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _kBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Import Program',
                  style: GoogleFonts.outfit(
                      fontSize: 22, fontWeight: FontWeight.w900, color: _kText),
                ),
                const SizedBox(height: 24),
                _importTile(
                  context: context,
                  ref: ref,
                  icon: LucideIcons.file,
                  title: 'Import JSON File',
                  subtitle: 'Load a training plan from local storage',
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(programsProvider.notifier).importTemplate();
                  },
                ),
                _importTile(
                  context: context,
                  ref: ref,
                  icon: LucideIcons.clipboard,
                  title: 'Paste Template',
                  subtitle: 'Import from copied JSON text',
                  onTap: () {
                    Navigator.pop(context);
                    _showPasteJsonDialog(context, ref);
                  },
                ),
                const SizedBox(height: 12),
                const Divider(color: _kBorder),
                const SizedBox(height: 12),
                _importTile(
                  context: context,
                  ref: ref,
                  icon: LucideIcons.flame,
                  title: 'Elite 6-Day PPL',
                  subtitle: 'Professional Push/Pull/Legs splitting',
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(programsProvider.notifier).importPplEliteProgram();
                  },
                ),
              ],
            ),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _kAccent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: _kAccent, size: 22),
      ),
      title: Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 16)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text('Paste JSON',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w900)),
        content: TextField(
          controller: controller,
          maxLines: 8,
          style: GoogleFonts.firaCode(fontSize: 12),
          decoration: InputDecoration(
            hintText: 'Paste template code here...',
            filled: true,
            fillColor: _kBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: GoogleFonts.outfit(color: _kMuted)),
          ),
          ElevatedButton(
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
                    const SnackBar(content: Text('Import successful')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Import failed: $e')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _kAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Import', style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
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
          Icon(LucideIcons.library, size: 80, color: _kBorder),
          const SizedBox(height: 24),
          Text(
            'Library is empty',
            style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => _showImportOptions(context, ref),
            icon: const Icon(LucideIcons.download),
            label: const Text('Import Sample Plan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _kAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
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
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _kBorder.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _kAccent.withValues(alpha: 0.8),
                    _kAccent.withValues(alpha: 0.3),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.push('/programs/details/${template.id}'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 20, 20, 20),
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
                        spacing: 8,
                        runSpacing: 8,
                        children: tags.take(3).map((t) => _colorfulTag(t)).toList(),
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
                                color: template.isSelected ? _kAccent : _kMuted,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                template.isSelected ? 'Selected' : 'Select plan',
                                style: GoogleFonts.outfit(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: template.isSelected ? _kAccent : _kMuted,
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
                            backgroundColor: _kAccent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shadowColor: _kAccent.withValues(alpha: 0.4),
                          ),
                          child: Text('Start', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 15)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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

  Widget _colorfulTag(String text) {
    Color color;
    switch (text.toLowerCase()) {
      case 'fat loss':
        color = const Color(0xFFFF2D55);
        break;
      case 'muscle gain':
        color = const Color(0xFFFF9500);
        break;
      case 'strength':
        color = const Color(0xFF5856D6);
        break;
      case 'aesthetics':
        color = const Color(0xFF007AFF);
        break;
      case 'performance':
        color = const Color(0xFF34C759);
        break;
      default:
        color = _kMuted;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
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
