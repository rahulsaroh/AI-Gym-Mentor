import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';

final initialExercises = [
  const ExercisesCompanion(
      name: Value('Barbell Bench Press'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Barbell'),
      setType: Value('Straight'),
      restTime: Value(90),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Dumbbell Bench Press'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Incline Barbell Bench Press'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Barbell'),
      setType: Value('Straight'),
      restTime: Value(90),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Incline Dumbbell Bench Press'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Decline Barbell Bench Press'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Barbell'),
      setType: Value('Straight'),
      restTime: Value(90),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Decline Dumbbell Bench Press'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Push-ups'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Cable Crossover'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Cable'),
      setType: Value('Straight'),
      restTime: Value(60),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Pec Deck Machine'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Machine'),
      setType: Value('Straight'),
      restTime: Value(60),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Dumbbell Flyes'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Deadlift'),
      primaryMuscle: Value('Back'),
      equipment: Value('Barbell'),
      setType: Value('Straight'),
      restTime: Value(120),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Pull-ups'),
      primaryMuscle: Value('Back'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(90),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Lat Pulldown'),
      primaryMuscle: Value('Back'),
      equipment: Value('Cable'),
      setType: Value('Straight'),
      restTime: Value(90),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Barbell Row'),
      primaryMuscle: Value('Back'),
      equipment: Value('Barbell'),
      setType: Value('Straight'),
      restTime: Value(90),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Squat'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Barbell'),
      setType: Value('Straight'),
      restTime: Value(120),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Leg Press'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Machine'),
      setType: Value('Straight'),
      restTime: Value(120),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Overhead Press'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Barbell'),
      setType: Value('Straight'),
      restTime: Value(90),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Lateral Raises'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Barbell Curl'),
      primaryMuscle: Value('Biceps'),
      equipment: Value('Barbell'),
      setType: Value('Straight'),
      restTime: Value(60),
      isCustom: Value(false)),
  const ExercisesCompanion(
      name: Value('Triceps Pushdown'),
      primaryMuscle: Value('Triceps'),
      equipment: Value('Cable'),
      setType: Value('Straight'),
      restTime: Value(60),
      isCustom: Value(false)),

  // Warmups & Mobility
  const ExercisesCompanion(
      name: Value('Arm circles + shoulder rolls'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Band pull-apart'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Band'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Wall shoulder CARs'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Scapular wall slides'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Hip circles + leg swings'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Band lateral walks'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Band'),
      setType: Value('Straight'),
      restTime: Value(30)),

  // Chest
  const ExercisesCompanion(
      name: Value('Dumbbell flat bench press'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell incline press'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell decline press'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Cable/Band Chest Fly'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Cable'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Incline Push-ups'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60)),

  // Back
  const ExercisesCompanion(
      name: Value('Pull-ups / assisted pull-ups (wide Grip)'),
      primaryMuscle: Value('Back'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell Bent-Over Row'),
      primaryMuscle: Value('Back'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Cable/Pulley Lat Pulldown'),
      primaryMuscle: Value('Back'),
      equipment: Value('Cable'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell Reverse Fly'),
      primaryMuscle: Value('Back'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dumbbell Face Pull (bent over)'),
      primaryMuscle: Value('Back'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Single-arm dumbbell row'),
      primaryMuscle: Value('Back'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Cable/pulley seated row'),
      primaryMuscle: Value('Back'),
      equipment: Value('Cable'),
      setType: Value('Straight'),
      restTime: Value(90)),

  // Shoulders
  const ExercisesCompanion(
      name: Value('Dumbbell lateral raise'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Standing dumbbell OHP'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell Arnold Press'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell front raise'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dumbbell shrug'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),

  // Legs & Core
  const ExercisesCompanion(
      name: Value('Dumbbell Goblet Squat'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell Romanian Deadlift'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell Reverse Lunge'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell Sumo Squat'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Ab Wheel Rollout'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Hanging Knee Raises'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Plank Variations'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(60)),

  // Arms
  const ExercisesCompanion(
      name: Value('Tricep Cable/Band Pushdown'),
      primaryMuscle: Value('Triceps'),
      equipment: Value('Cable'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Overhead DB Tricep Extension'),
      primaryMuscle: Value('Triceps'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dumbbell Hammer Curl'),
      primaryMuscle: Value('Biceps'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Barbell-style curl (DB)'),
      primaryMuscle: Value('Biceps'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Incline dumbbell curl'),
      primaryMuscle: Value('Biceps'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Concentration curl'),
      primaryMuscle: Value('Biceps'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dumbbell Shoulder PullUps'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),

  // Stretches
  const ExercisesCompanion(
      name: Value('Door-frame chest stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Across-body shoulder stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Tricep Overhead Stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Child\'s Pose'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Doorway lat stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Cat-cow spinal decompression'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Glute figure-4 stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),

  // Finishers
  const ExercisesCompanion(
      name: Value('BAG: Straight Punch Rounds'),
      primaryMuscle: Value('Cardio'),
      equipment: Value('Bag'),
      setType: Value('Timed'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('BAG: Hooks + Uppercuts'),
      primaryMuscle: Value('Cardio'),
      equipment: Value('Bag'),
      setType: Value('Timed'),
      restTime: Value(60)),

  // Additional exercises from 6-Day PPL file
  const ExercisesCompanion(
      name: Value('Resistance Band Walk (Lateral + Fwd)'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Band'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Hip Thrust Hold (Bodyweight)'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Inchworm Walk-outs'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Ankle Circles + Calf Raises'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Dumbbell Stiff-Leg Deadlift'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell Hip Thrust (Bench)'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Bulgarian Split Squat (DB)'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Resistance Band Glute Kickback'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Band'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Dumbbell Calf Raise (Standing)'),
      primaryMuscle: Value('Calves'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Ab Wheel Rollout (Advanced)'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Decline Sit-up / Russian Twist'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Leg Raise (Hanging or Floor)'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('90-90 Hip Stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Lying Hamstring Stretch (Band)'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Band'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Calf Doorway Stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Supine Spinal Twist'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Standing quad stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Pigeon pose (hip flexor)'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Seated hamstring stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Dead hang passive stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Bicep wall stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Pec minor stretch (doorway)'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Overhead shoulder stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Wrist flexor/extensor stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Thoracic spine foam roll / floor'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Cat-cow thoracic rotation'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Scapular pull-ups (just scaps)'),
      primaryMuscle: Value('Back'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Wide-grip pull-ups'),
      primaryMuscle: Value('Back'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Resistance band pull-aparts'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Band'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Resistance band pull-apart (supinated)'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Band'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Neck side stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Lat stretch in doorway'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Child\'s pose with arm reach'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Supinator/pronator forearm stretch'),
      primaryMuscle: Value('Stretch'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Resistance Band Squat'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Band'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Light lateral raise'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Push-ups (feet elevated)'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dumbbell Lateral Raise (drop set)'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Cable/Band overhead tricep'),
      primaryMuscle: Value('Triceps'),
      equipment: Value('Cable'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Diamond push-ups'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dumbbell decline press'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell Arnold Press'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(90)),
  const ExercisesCompanion(
      name: Value('Dumbbell front raise'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Reverse Grip Dumbell curl'),
      primaryMuscle: Value('Biceps'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Hanging Knee Raises (Pull-up Bar)'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Plank Variations'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Glute bridges'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Bodyweight squat (slow)'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dead hang on pull-up bar'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Band pull apart with external rotation'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Band'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Light Dumbbell Lateral Raise'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dumbell Shoulder PullUps'),
      primaryMuscle: Value('Shoulders'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
];

class SampleProgramExercise {
  final String name;
  final String? notes;
  final String setsJson; // '[{"reps":10, "weight": 60.0}, ...]'
  SampleProgramExercise({required this.name, this.notes, this.setsJson = '[]'});
}

class SampleProgramDay {
  final String name;
  final List<SampleProgramExercise> exercises;
  SampleProgramDay({required this.name, required this.exercises});
}

class SampleProgram {
  final String name;
  final String description;
  final List<SampleProgramDay> days;
  SampleProgram(
      {required this.name, required this.description, required this.days});
}

final samplePPLProgram = SampleProgram(
  name: '3-Day Split (PPL)',
  description:
      'A classic muscle-building split focusing on Push, Pull, and Leg movements.',
  days: [
    SampleProgramDay(
      name: 'Push Day (Chest, Shoulders, Triceps)',
      exercises: [
        SampleProgramExercise(name: 'Barbell Bench Press'),
        SampleProgramExercise(name: 'Overhead Press'),
        SampleProgramExercise(name: 'Lateral Raises'),
        SampleProgramExercise(name: 'Triceps Pushdown'),
      ],
    ),
    SampleProgramDay(
      name: 'Pull Day (Back, Biceps)',
      exercises: [
        SampleProgramExercise(name: 'Deadlift'),
        SampleProgramExercise(name: 'Lat Pulldown'),
        SampleProgramExercise(name: 'Barbell Row'),
        SampleProgramExercise(name: 'Barbell Curl'),
      ],
    ),
    SampleProgramDay(
      name: 'Leg Day',
      exercises: [
        SampleProgramExercise(name: 'Squat'),
        SampleProgramExercise(name: 'Leg Press'),
      ],
    ),
  ],
);

final elitePPLProgram = SampleProgram(
  name: '6-Day Elite PPL',
  description:
      'A comprehensive Push-Pull-Legs program for advanced hypertrophy and strength. Focuses on proper form, cues, and heavy accessories.',
  days: [
    SampleProgramDay(
      name: 'Push A - Chest, Shoulders, Triceps',
      exercises: [
        SampleProgramExercise(
            name: 'Arm circles + shoulder rolls',
            notes: '60 sec each direction'),
        SampleProgramExercise(name: 'Band pull-apart', notes: '2x15 reps'),
        SampleProgramExercise(
            name: 'Incline Push-ups', notes: 'slow 2x10 reps'),
        SampleProgramExercise(
            name: 'Light Dumbbell Lateral Raise',
            notes: '1x15 reps',
            setsJson: '[{"reps": 15, "weight": 2.5}]'),
        SampleProgramExercise(
            name: 'Dumbbell flat bench press',
            notes: 'Bench. Full ROM, elbows 45°. Primary chest builder.',
            setsJson:
                '[{"reps": 15, "weight": 7.5}, {"reps": 16, "weight": 7.5}, {"reps": 20, "weight": 7.5}]'),
        SampleProgramExercise(
            name: 'Dumbbell incline press',
            notes: '45° bench angle. Hits upper chest for V-taper.',
            setsJson:
                '[{"reps": 20, "weight": 7.5}, {"reps": 20, "weight": 7.5}, {"reps": 15, "weight": 7.5}]'),
        SampleProgramExercise(
            name: 'Dumbbell lateral raise',
            notes: 'Slow eccentric 3 sec. KEY for shoulder width.',
            setsJson:
                '[{"reps": 15, "weight": 5.0}, {"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 7.5}]'),
        SampleProgramExercise(
            name: 'Standing dumbbell OHP',
            notes: 'Core braced. Don\'t flare elbows excessively.',
            setsJson:
                '[{"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 10.0}, {"reps": 7, "weight": 15.0}]'),
        SampleProgramExercise(
            name: 'Cable/Band Chest Fly',
            notes: 'Deep stretch. Peak chest contraction.',
            setsJson:
                '[{"reps": 10, "weight": 15.0}, {"reps": 13, "weight": 15.0}, {"reps": 17, "weight": 15.0}]'),
        SampleProgramExercise(
            name: 'Tricep Cable/Band Pushdown',
            notes: 'Elbows fixed. Full extension. Triceps = 2/3 of arm.',
            setsJson:
                '[{"reps": 12, "weight": 15.0}, {"reps": 9, "weight": 15.0}, {"reps": 6, "weight": 15.0}]'),
        SampleProgramExercise(
            name: 'Overhead DB Tricep Extension',
            notes: 'Long head stretch. Arms bigger from behind.',
            setsJson:
                '[{"reps": 14, "weight": 7.5}, {"reps": 11, "weight": 7.5}, {"reps": 11, "weight": 7.5}]'),
        SampleProgramExercise(
            name: 'BAG: Straight Punch Rounds',
            notes: '3x1 min. Hands up. Exhale each punch.'),
        SampleProgramExercise(name: 'Door-frame chest stretch'),
        SampleProgramExercise(name: 'Across-body shoulder stretch'),
        SampleProgramExercise(name: 'Tricep Overhead Stretch'),
        SampleProgramExercise(name: 'Child\'s Pose'),
      ],
    ),
    SampleProgramDay(
      name: 'Pull A - Back, Biceps Focus',
      exercises: [
        SampleProgramExercise(
            name: 'Scapular wall slides',
            notes: 'back on wall and slide hands on wall 2x10 reps'),
        SampleProgramExercise(name: 'Band face pull', notes: '2x15 reps'),
        SampleProgramExercise(
            name: 'Dead hang on pull-up bar', notes: '2x20 sec'),
        SampleProgramExercise(
            name: 'Band pull apart with external rotation', notes: '2x12 reps'),
        SampleProgramExercise(
            name: 'Pull-ups / assisted pull-ups (wide Grip)',
            notes: 'V-taper KING. Band assist if needed.',
            setsJson:
                '[{"reps": 2, "weight": 78.0}, {"reps": 2, "weight": 78.0}, {"reps": 2, "weight": 78.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Bent-Over Row',
            notes:
                'Elbows back, not flared. Squeeze at top. Mid-back thickness.',
            setsJson:
                '[{"reps": 30, "weight": 5.0}, {"reps": 20, "weight": 7.5}, {"reps": 10, "weight": 10.0}, {"reps": 14, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Cable/Pulley Lat Pulldown',
            notes: 'Wide grip. Pull to upper chest. Stretch at top.',
            setsJson:
                '[{"reps": 20, "weight": 15.0}, {"reps": 11, "weight": 25.0}, {"reps": 13, "weight": 27.5}, {"reps": 10, "weight": 27.5}]'),
        SampleProgramExercise(
            name: 'Dumbbell Reverse Fly',
            notes: 'Rear delts. Slow arc. 3D shoulder look.',
            setsJson:
                '[{"reps": 12, "weight": 7.5}, {"reps": 8, "weight": 10.0}, {"reps": 6, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Face Pull (bent over)',
            notes: 'Elbows high. Rotator cuff + posture.',
            setsJson:
                '[{"reps": 10, "weight": 7.5}, {"reps": 8, "weight": 10.0}, {"reps": 8, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Hammer Curl',
            notes: '60° bench. Long head bicep peak.',
            setsJson:
                '[{"reps": 11, "weight": 7.5}, {"reps": 11, "weight": 7.5}, {"reps": 6, "weight": 7.5}]'),
        SampleProgramExercise(
            name: 'Barbell-style curl (DB)',
            notes: 'Supinated grip. Full ROM, no swinging.',
            setsJson:
                '[{"reps": 10, "weight": 7.5}, {"reps": 4, "weight": 10.0}, {"reps": 3, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'BAG: Hooks + Uppercuts', notes: '3x1 min. Rotate hips.'),
        SampleProgramExercise(
            name: 'Doorway lat stretch', notes: '30 sec each side'),
        SampleProgramExercise(
            name: 'Cat-cow spinal decompression', notes: '60 sec'),
      ],
    ),
    SampleProgramDay(
      name: 'Legs + Abs A - Quads, Glutes, Core',
      exercises: [
        SampleProgramExercise(
            name: 'Hip circles + leg swings', notes: '60 sec each direction'),
        SampleProgramExercise(
            name: 'Bodyweight squat (slow)', notes: '2x12 reps'),
        SampleProgramExercise(name: 'Glute bridges', notes: '2x15 reps'),
        SampleProgramExercise(name: 'Band lateral walks', notes: '2x15 steps'),
        SampleProgramExercise(
            name: 'Dumbbell Goblet Squat',
            notes: 'Hold DB at chest. Full depth. Knees track toes.'),
        SampleProgramExercise(
            name: 'Dumbbell Romanian Deadlift',
            notes: 'Hinge at hips. Hamstring stretch. HUGE for glutes.'),
        SampleProgramExercise(
            name: 'Dumbbell Reverse Lunge',
            notes: 'Stepping back. Less knee stress than forward lunge.'),
        SampleProgramExercise(
            name: 'Resistance Band Squat',
            notes: 'Band above knees. Activates glute med for width.'),
        SampleProgramExercise(
            name: 'Dumbbell Sumo Squat',
            notes: 'Wide stance. Inner quad and adductor focus.'),
        SampleProgramExercise(
            name: 'Ab Wheel Rollout',
            notes: 'Slow controlled. BEST core exercise you own.'),
        SampleProgramExercise(
            name: 'Hanging Knee Raises', notes: 'Don\'t swing. Lower slowly.'),
        SampleProgramExercise(
            name: 'Plank Variations',
            notes: 'Side plank alternating. Oblique definition.'),
        SampleProgramExercise(
            name: 'Glute figure-4 stretch', notes: '30 sec each'),
      ],
    ),
    SampleProgramDay(
      name: 'Push B - Shoulder Focus',
      exercises: [
        SampleProgramExercise(name: 'Band pull-apart', notes: '2x15 reps'),
        SampleProgramExercise(
            name: 'Rotator cuff internal/external rotation',
            notes: 'each 2x12 reps'),
        SampleProgramExercise(
            name: 'Wall shoulder CARs', notes: '5 slow circles each arm'),
        SampleProgramExercise(
            name: 'Light lateral raise',
            notes: '1x20 reps',
            setsJson: '[{"reps": 20, "weight": 2.5}]'),
        SampleProgramExercise(
            name: 'Dumbbell Arnold Press',
            notes: 'Rotation hits all 3 delt heads. V-taper essential.',
            setsJson:
                '[{"reps": 15, "weight": 5.0}, {"reps": 12, "weight": 7.5}, {"reps": 9, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell front raise',
            notes: 'Combined arms. Controlled, no swinging.',
            setsJson:
                '[{"reps": 10, "weight": 7.5}, {"reps": 7, "weight": 10.0}, {"reps": 8, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Lateral Raise (drop set)',
            notes: '4 sec negative. KEY for widths.',
            setsJson:
                '[{"reps": 7, "weight": 7.5}, {"reps": 7, "weight": 7.5}, {"reps": 6, "weight": 7.5}]'),
        SampleProgramExercise(
            name: 'Incline Push-ups',
            notes: 'Elevated feet shift load to upper chest.',
            setsJson:
                '[{"reps": 4, "weight": 0.0}, {"reps": 3, "weight": 0.0}, {"reps": 3, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell decline press',
            notes: 'Lower chest definition. Decline on bench.',
            setsJson:
                '[{"reps": 20, "weight": 7.5}, {"reps": 17, "weight": 10.0}, {"reps": 20, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Cable/Band overhead tricep',
            notes: 'Long head stretch. Width to arms.',
            setsJson:
                '[{"reps": 10, "weight": 15.0}, {"reps": 10, "weight": 15.0}, {"reps": 6, "weight": 15.0}]'),
        SampleProgramExercise(
            name: 'Push-ups',
            notes: 'Diamond push-ups bodyweight finisher.',
            setsJson:
                '[{"reps": 4, "weight": 0.0}, {"reps": 2, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Pull B - Width & Back Thickness',
      exercises: [
        SampleProgramExercise(name: 'Band pull-apart', notes: '3x15 reps'),
        SampleProgramExercise(
            name: 'Cat-cow spinal decompression', notes: '2x10 reps'),
        SampleProgramExercise(name: 'Scapular wall slides', notes: '2x8 reps'),
        SampleProgramExercise(
            name: 'Pull-ups / assisted pull-ups (wide Grip)',
            notes: 'Widest grip comfortable.',
            setsJson:
                '[{"reps": 2, "weight": 0.0}, {"reps": 2, "weight": 0.0}, {"reps": 2, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'Cable/pulley seated row',
            notes: 'Neutral grip. Retract scapula.'),
        SampleProgramExercise(
            name: 'Single-arm dumbbell row',
            notes: 'Knee on bench. Heavy is okay here.',
            setsJson:
                '[{"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell shrug',
            notes: 'Traps for that athletic look. Hold at top 1 sec.',
            setsJson:
                '[{"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Incline dumbbell curl',
            notes: 'On bench 60. Long head bicep. Peak builder.',
            setsJson:
                '[{"reps": 6, "weight": 10.0}, {"reps": 4, "weight": 10.0}, {"reps": 3, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Concentration curl',
            notes: 'Elbow on inner thigh. Mind-muscle max.',
            setsJson:
                '[{"reps": 9, "weight": 10.0}, {"reps": 6, "weight": 10.0}, {"reps": 6, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Shoulder PullUps',
            notes: 'Pull dumbbell till face height.',
            setsJson:
                '[{"reps": 10, "weight": 10.0}, {"reps": 10, "weight": 10.0}, {"reps": 10, "weight": 10.0}, {"reps": 10, "weight": 10.0}]'),
        SampleProgramExercise(name: 'Doorway lat stretch'),
      ],
    ),
    SampleProgramDay(
      name: 'Legs + Abs B — Posterior Chain, Calves, Obliques',
      exercises: [
        SampleProgramExercise(
            name: 'Resistance Band Walk (Lateral + Fwd)',
            notes: '15 steps each direction'),
        SampleProgramExercise(
            name: 'Hip Thrust Hold (Bodyweight)', notes: '3x30 sec'),
        SampleProgramExercise(name: 'Inchworm Walk-outs', notes: '2x8 reps'),
        SampleProgramExercise(
            name: 'Ankle Circles + Calf Raises', notes: '2x10 each'),
        SampleProgramExercise(
            name: 'Dumbbell Stiff-Leg Deadlift',
            notes: 'Hinge pattern. Keep back flat.'),
        SampleProgramExercise(
            name: 'Dumbbell Hip Thrust (Bench)',
            notes: 'Upper glute focus. Chin tucked.'),
        SampleProgramExercise(
            name: 'Bulgarian Split Squat (DB)',
            notes: 'Rear foot elevated. Full depth.'),
        SampleProgramExercise(
            name: 'Resistance Band Glute Kickback', notes: '3x15 each leg'),
        SampleProgramExercise(
            name: 'Dumbbell Calf Raise (Standing)',
            notes: 'Full stretch at bottom.'),
        SampleProgramExercise(
            name: 'Ab Wheel Rollout (Advanced)',
            notes: 'Control the negative.'),
        SampleProgramExercise(
            name: 'Decline Sit-up / Russian Twist', notes: 'Oblique burn.'),
        SampleProgramExercise(
            name: 'Leg Raise (Hanging or Floor)', notes: 'No swinging.'),
        SampleProgramExercise(name: '90-90 Hip Stretch', notes: '30 sec each'),
        SampleProgramExercise(
            name: 'Lying Hamstring Stretch (Band)', notes: '30 sec each'),
        SampleProgramExercise(
            name: 'Calf Doorway Stretch', notes: '30 sec each'),
        SampleProgramExercise(
            name: 'Supine Spinal Twist', notes: '30 sec each side'),
      ],
    ),
  ],
);
