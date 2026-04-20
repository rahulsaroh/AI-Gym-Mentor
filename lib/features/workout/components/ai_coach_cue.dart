import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/datasources/gemini_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/workout/models/workout_models.dart';

class AICoachCue extends ConsumerStatefulWidget {
  final ExerciseBlock block;
  final String exerciseName;

  const AICoachCue({
    super.key,
    required this.block,
    required this.exerciseName,
  });

  @override
  ConsumerState<AICoachCue> createState() => _AICoachCueState();
}

class _AICoachCueState extends ConsumerState<AICoachCue> {
  String? _cue;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchCue();
  }

  @override
  void didUpdateWidget(AICoachCue oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Refresh cue if the block session changes significantly (e.g. more sets completed)
    final completedCount = widget.block.sets.where((s) => s.completed).length;
    final oldCompletedCount = oldWidget.block.sets.where((s) => s.completed).length;
    
    if (completedCount != oldCompletedCount && completedCount > 0) {
      _fetchCue();
    }
  }

  Future<void> _fetchCue() async {
    if (_loading) return;
    
    final completedSets = widget.block.sets.where((s) => s.completed).toList();
    if (completedSets.isEmpty) return;

    setState(() => _loading = true);

    try {
      final context = completedSets.map((s) => {
        'reps': s.reps,
        'weight': s.weight,
        'rpe': s.rpe,
      }).toList();

      final gemini = ref.read(geminiServiceProvider.notifier);
      final cue = await gemini.getCoachCue(widget.exerciseName, context);
      
      if (mounted) {
        setState(() {
          _cue = cue;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cue == null && !_loading) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.secondary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              LucideIcons.sparkles,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _loading 
              ? _buildSkeletonText()
              : Text(
                  _cue!,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
          ),
          if (!_loading)
            IconButton(
              icon: const Icon(LucideIcons.refreshCw, size: 14),
              onPressed: _fetchCue,
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }

  Widget _buildSkeletonText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 8,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
