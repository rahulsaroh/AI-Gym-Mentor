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
  const ExercisesCompanion(
      name: Value('Push-up burpee'),
      primaryMuscle: Value('Cardio'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(20)),
  const ExercisesCompanion(
      name: Value('Mountain climbers'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(20)),
  const ExercisesCompanion(
      name: Value('High knees'),
      primaryMuscle: Value('Cardio'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(20)),
  const ExercisesCompanion(
      name: Value('Lateral skater jumps'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(20)),
  const ExercisesCompanion(
      name: Value('Dumbbell thruster'),
      primaryMuscle: Value('Full Body'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dumbbell swing'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dumbbell renegade row'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Farmer\'s carry'),
      primaryMuscle: Value('Full Body'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dumbbell clean and press'),
      primaryMuscle: Value('Full Body'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(60)),
  const ExercisesCompanion(
      name: Value('Dead bug'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(15)),
  const ExercisesCompanion(
      name: Value('Bicycle crunch'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(15)),
  const ExercisesCompanion(
      name: Value('Leg raise (lying flat)'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(15)),
  const ExercisesCompanion(
      name: Value('Pulley rope crunch'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Cable'),
      setType: Value('Straight'),
      restTime: Value(15)),
  const ExercisesCompanion(
      name: Value('Russian twist (DB)'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Dumbbell'),
      setType: Value('Straight'),
      restTime: Value(15)),
  const ExercisesCompanion(
      name: Value('Side plank'),
      primaryMuscle: Value('Abs'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(15)),
  const ExercisesCompanion(
      name: Value('Brisk walk'),
      primaryMuscle: Value('Cardio'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Step-ups on bench'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Bench'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Shadow boxing / dance'),
      primaryMuscle: Value('Cardio'),
      equipment: Value('Bodyweight'),
      setType: Value('Timed'),
      restTime: Value(0)),
  const ExercisesCompanion(
      name: Value('Scapular squeeze holds'),
      primaryMuscle: Value('Warmup'),
      equipment: Value('Bodyweight'),
      setType: Value('Straight'),
      restTime: Value(30)),
  const ExercisesCompanion(
      name: Value('Jump squats'),
      primaryMuscle: Value('Legs'),
      equipment: Value('Bodyweight'),
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
  final String? goal;
  final String? duration;
  final List<SampleProgramDay> days;
  SampleProgram({
    required this.name,
    required this.description,
    this.goal,
    this.duration,
    required this.days,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'goal': goal,
      'duration': duration,
      'days': days
          .map((d) => {
                'name': d.name,
                'order': days.indexOf(d),
                'exercises': d.exercises
                    .map((e) => {
                          'exerciseName': e.name,
                          'order': d.exercises.indexOf(e),
                          'setType': 'straight',
                          'setsJson': e.setsJson,
                          'restTime': 90,
                          'notes': e.notes,
                        })
                    .toList(),
              })
          .toList(),
    };
  }
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

final womenFatLossProgram = SampleProgram(
  name: 'Women 6 days fat loss program',
  description:
      'A professional 24-week metabolic rebuilding plan. Focused on fat loss while protecting lean muscle via Push-Pull-Legs and HIIT. Designed for home setups with dumbbells and cables.',
  goal: 'Fat Loss',
  duration: '24 Weeks',
  days: [
    SampleProgramDay(
      name: 'Day 1: Push Day (Chest, Shoulders, Triceps)',
      exercises: [
        SampleProgramExercise(
            name: 'Arm circles + shoulder rolls', notes: 'Warmup: 30 sec each'),
        SampleProgramExercise(name: 'Push-ups', notes: 'Warmup: Wall push-ups x15'),
        SampleProgramExercise(
            name: 'Band pull-apart', notes: 'Warmup: 15 reps'),
        SampleProgramExercise(
            name: 'Dumbbell flat bench press',
            notes: 'BLOCK A: Barbell bench press. Control descent (2 sec).',
            setsJson: '[{"reps": 10, "weight": 20.0}, {"reps": 10, "weight": 20.0}, {"reps": 10, "weight": 20.0}, {"reps": 10, "weight": 20.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell incline press',
            notes: 'BLOCK A: Incline press 30-45°. Go heavier weekly.',
            setsJson: '[{"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Flyes',
            notes: 'BLOCK A: DB chest fly. Light weight, focus on stretch.',
            setsJson: '[{"reps": 15, "weight": 5.0}, {"reps": 15, "weight": 5.0}, {"reps": 15, "weight": 5.0}]'),
        SampleProgramExercise(
            name: 'Standing dumbbell OHP',
            notes: 'BLOCK B: Shoulders. Core tight, no back arch.',
            setsJson: '[{"reps": 12, "weight": 7.5}, {"reps": 12, "weight": 7.5}, {"reps": 12, "weight": 7.5}]'),
        SampleProgramExercise(
            name: 'Dumbbell lateral raise',
            notes: 'BLOCK B: Lead with elbows, not wrists.',
            setsJson: '[{"reps": 15, "weight": 2.5}, {"reps": 15, "weight": 2.5}, {"reps": 15, "weight": 2.5}]'),
        SampleProgramExercise(
            name: 'Dumbbell front raise',
            notes: 'BLOCK B: Pulley/DB front raise. Slow and controlled.',
            setsJson: '[{"reps": 12, "weight": 5.0}, {"reps": 12, "weight": 5.0}, {"reps": 12, "weight": 5.0}]'),
        SampleProgramExercise(
            name: 'Overhead DB Tricep Extension',
            notes: 'BLOCK C: Triceps. Long head stretch.',
            setsJson: '[{"reps": 15, "weight": 7.5}, {"reps": 15, "weight": 7.5}, {"reps": 15, "weight": 7.5}]'),
        SampleProgramExercise(
            name: 'Triceps Pushdown',
            notes: 'BLOCK C: Elbows fixed to sides.',
            setsJson: '[{"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Push-ups', notes: 'FINISHER: Push-ups to failure x2 sets'),
        SampleProgramExercise(
            name: 'Side plank', notes: 'FINISHER: 30 sec plank after each set'),
        SampleProgramExercise(
            name: 'Door-frame chest stretch', notes: 'Cooldown: 45 sec'),
        SampleProgramExercise(
            name: 'Across-body shoulder stretch', notes: 'Cooldown: 30 sec'),
        SampleProgramExercise(
            name: 'Tricep Overhead Stretch', notes: 'Cooldown: 30 sec'),
        SampleProgramExercise(name: 'Child\'s Pose', notes: 'Cooldown: 1 min'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 2: Pull Day (Back, Biceps)',
      exercises: [
        SampleProgramExercise(
            name: 'Cat-cow spinal decompression', notes: 'Warmup: x10 reps'),
        SampleProgramExercise(
            name: 'Band pull-apart', notes: 'Warmup: Towel row x15'),
        SampleProgramExercise(
            name: 'Single-arm dumbbell row', notes: 'Warmup: x12 each side'),
        SampleProgramExercise(
            name: 'Scapular squeeze holds', notes: 'Warmup: x10 holds'),
        SampleProgramExercise(
            name: 'Barbell Row',
            notes: 'BLOCK A: Bent-over row. Pull bar to belly button.',
            setsJson: '[{"reps": 10, "weight": 20.0}, {"reps": 10, "weight": 22.5}, {"reps": 10, "weight": 25.0}, {"reps": 10, "weight": 25.0}]'),
        SampleProgramExercise(
            name: 'Single-arm dumbbell row',
            notes: 'BLOCK A: Brace against bench. drive elbow back.',
            setsJson: '[{"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Cable/pulley seated row',
            notes: 'BLOCK A: Pull to sternum. Squeeze for 1 sec.',
            setsJson: '[{"reps": 12, "weight": 15.0}, {"reps": 12, "weight": 15.0}, {"reps": 12, "weight": 15.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Reverse Fly',
            notes: 'BLOCK B: Rear delts. Hinge 45, arms wide.',
            setsJson: '[{"reps": 15, "weight": 2.5}, {"reps": 15, "weight": 2.5}, {"reps": 15, "weight": 2.5}]'),
        SampleProgramExercise(
            name: 'Dumbbell Face Pull (bent over)',
            notes: 'BLOCK B: Pulley face pull. High attachment.',
            setsJson: '[{"reps": 20, "weight": 10.0}, {"reps": 20, "weight": 10.0}, {"reps": 20, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Barbell Curl',
            notes: 'BLOCK C: Biceps. Full peak focus.',
            setsJson: '[{"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Hammer Curl',
            notes: 'BLOCK C: Brachialis focus.',
            setsJson: '[{"reps": 12, "weight": 5.0}, {"reps": 12, "weight": 5.0}, {"reps": 12, "weight": 5.0}]'),
        SampleProgramExercise(
            name: 'Cable/pulley seated row',
            notes: 'BLOCK C: Standing low curl. Elbows forward.',
            setsJson: '[{"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Band pull-apart', notes: 'FINISHER: Posture circuit x2 rounds'),
        SampleProgramExercise(
            name: 'Plank Variations', notes: 'FINISHER: Superman hold x10 sec'),
        SampleProgramExercise(
            name: 'Door-frame chest stretch', notes: 'FINISHER: Stretch 45 sec'),
        SampleProgramExercise(
            name: 'Doorway lat stretch', notes: 'Cooldown: 45 sec each'),
        SampleProgramExercise(
            name: 'Child\'s Pose', notes: 'Cooldown: 1 min'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 3: Lower Body Day',
      exercises: [
        SampleProgramExercise(
            name: 'Hip circles + leg swings', notes: 'Warmup: 30 sec each'),
        SampleProgramExercise(
            name: 'Bodyweight squat (slow)', notes: 'Warmup: x15 slow'),
        SampleProgramExercise(
            name: 'Dumbbell Reverse Lunge', notes: 'Warmup: x10 each leg'),
        SampleProgramExercise(name: 'Glute bridges', notes: 'Warmup: x15'),
        SampleProgramExercise(
            name: 'Squat',
            notes: 'BLOCK A: Barbell back squat. Fat-burning powerhouse.',
            setsJson: '[{"reps": 10, "weight": 20.0}, {"reps": 10, "weight": 25.0}, {"reps": 10, "weight": 30.0}, {"reps": 10, "weight": 30.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Goblet Squat',
            notes: 'BLOCK A: One heavy DB at chest. Sit back.',
            setsJson: '[{"reps": 15, "weight": 15.0}, {"reps": 15, "weight": 15.0}, {"reps": 15, "weight": 15.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Reverse Lunge',
            notes: 'BLOCK A: step back, knee hovers 1in off floor.',
            setsJson: '[{"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Hip Thrust (Bench)',
            notes: 'BLOCK B: Glute max. Squeeze at top 1s.',
            setsJson: '[{"reps": 15, "weight": 15.0}, {"reps": 15, "weight": 20.0}, {"reps": 15, "weight": 20.0}, {"reps": 15, "weight": 20.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Romanian Deadlift',
            notes: 'BLOCK B: Soft knees, hinge at hips.',
            setsJson: '[{"reps": 12, "weight": 20.0}, {"reps": 12, "weight": 20.0}, {"reps": 12, "weight": 20.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Sumo Squat',
            notes: 'BLOCK B: Wide stance, toes out 45°. Targets inner thigh.',
            setsJson: '[{"reps": 15, "weight": 15.0}, {"reps": 15, "weight": 15.0}, {"reps": 15, "weight": 15.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Calf Raise (Standing)',
            notes: 'BLOCK C: Pause at bottom for stretch.',
            setsJson: '[{"reps": 20, "weight": 10.0}, {"reps": 20, "weight": 10.0}, {"reps": 20, "weight": 10.0}, {"reps": 20, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Jump squats', notes: 'FINISHER: Leg burnout - Jump squats x15'),
        SampleProgramExercise(
            name: 'Glute bridges', notes: 'FINISHER: Glute bridge hold 30s'),
        SampleProgramExercise(
            name: 'Standing quad stretch', notes: 'Cooldown: 45 sec each'),
        SampleProgramExercise(
            name: 'Seated hamstring stretch', notes: 'Cooldown: 1 min'),
        SampleProgramExercise(
            name: 'Pigeon pose (hip flexor)', notes: 'Cooldown: 1 min each side'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 4: HIIT & Metabolic Circuit',
      exercises: [
        SampleProgramExercise(
            name: 'Shadow boxing / dance', notes: 'Warmup: 3 min gradually increasing'),
        SampleProgramExercise(
            name: 'High knees', notes: 'Warmup: 30 sec moderate pace'),
        SampleProgramExercise(
            name: 'Jump squats',
            notes: 'HIIT BLOCK: 40s ON / 20s OFF. 4 rounds.',
            setsJson: '[{"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'Push-up burpee',
            notes: 'HIIT BLOCK: 40s ON / 20s OFF. 4 rounds. Do full push-up.',
            setsJson: '[{"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'Mountain climbers',
            notes: 'HIIT BLOCK: 40s ON / 20s OFF. 4 rounds. Fast pace.',
            setsJson: '[{"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'High knees',
            notes: 'HIIT BLOCK: 40s ON / 20s OFF. 4 rounds. Sprint intensity.',
            setsJson: '[{"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'Lateral skater jumps',
            notes: 'HIIT BLOCK: 40s ON / 20s OFF. 4 rounds. Land on one foot.',
            setsJson: '[{"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell thruster',
            notes: 'METABOLIC: Squat to press. 3 rounds 45s each.',
            setsJson: '[{"reps": 45, "weight": 5.0}, {"reps": 45, "weight": 5.0}, {"reps": 45, "weight": 5.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell swing',
            notes: 'METABOLIC: Hinge and drive. 3 rounds 45s each.',
            setsJson: '[{"reps": 45, "weight": 7.5}, {"reps": 45, "weight": 7.5}, {"reps": 45, "weight": 7.5}]'),
        SampleProgramExercise(
            name: 'Dumbbell renegade row',
            notes: 'METABOLIC: Plank rows. 3 rounds 45s each.',
            setsJson: '[{"reps": 45, "weight": 5.0}, {"reps": 45, "weight": 5.0}, {"reps": 45, "weight": 5.0}]'),
        SampleProgramExercise(
            name: 'Brisk walk', notes: 'Cooldown: Walk in place 2 min'),
        SampleProgramExercise(
            name: 'Seated hamstring stretch', notes: 'Cooldown: Forward fold 1 min'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 5: Full Body Strength',
      exercises: [
        SampleProgramExercise(
            name: 'Inchworm Walk-outs', notes: 'Warmup: x8 reps'),
        SampleProgramExercise(
            name: 'Bodyweight squat (slow)', notes: 'Warmup: x15 reps'),
        SampleProgramExercise(
            name: 'Deadlift',
            notes: 'BLOCK A: Barbell deadlift. Neutral back. Fat loss KING.',
            setsJson: '[{"reps": 8, "weight": 20.0}, {"reps": 8, "weight": 30.0}, {"reps": 8, "weight": 40.0}, {"reps": 8, "weight": 40.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell Romanian Deadlift',
            notes: 'BLOCK A: Hamstrings focus.',
            setsJson: '[{"reps": 10, "weight": 15.0}, {"reps": 10, "weight": 15.0}, {"reps": 10, "weight": 15.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell flat bench press',
            notes: 'BLOCK B: SUPERSET A (Push).',
            setsJson: '[{"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Lat Pulldown',
            notes: 'BLOCK B: SUPERSET B (Pull). 60s rest after this.',
            setsJson: '[{"reps": 12, "weight": 15.0}, {"reps": 12, "weight": 15.0}, {"reps": 12, "weight": 15.0}]'),
        SampleProgramExercise(
            name: 'Standing dumbbell OHP',
            notes: 'BLOCK B: SUPERSET A (Push - Shoulders).',
            setsJson: '[{"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 7.5}]'),
        SampleProgramExercise(
            name: 'Dumbbell Face Pull (bent over)',
            notes: 'BLOCK B: SUPERSET B (Pull - Posture).',
            setsJson: '[{"reps": 15, "weight": 5.0}, {"reps": 15, "weight": 5.0}, {"reps": 15, "weight": 5.0}]'),
        SampleProgramExercise(
            name: 'Farmer\'s carry',
            notes: 'BLOCK C: heavy DBs, walk 20m. Core stability.',
            setsJson: '[{"reps": 1, "weight": 15.0}, {"reps": 1, "weight": 15.0}, {"reps": 1, "weight": 15.0}]'),
        SampleProgramExercise(
            name: 'Dumbbell clean and press',
            notes: 'BLOCK C: explosive movement. Swing to shoulder then press.',
            setsJson: '[{"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 7.5}]'),
        SampleProgramExercise(
            name: 'Push-ups', notes: 'FINISHER: 5-min AMRAP of Push-up(10), JumpSquat(10), Plank(20s)'),
        SampleProgramExercise(
            name: 'Cat-cow thoracic rotation', notes: 'Cooldown: 1 min each side'),
        SampleProgramExercise(
            name: 'Supine Spinal Twist', notes: 'Cooldown: 1 min each side'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 6: Core, Abs & LISS',
      exercises: [
        SampleProgramExercise(name: 'Dead bug', notes: 'Warmup: x10 reps'),
        SampleProgramExercise(name: 'Glute bridges', notes: 'Warmup: x15 reps'),
        SampleProgramExercise(name: 'Mountain climbers', notes: 'Warmup: slow x20 reps'),
        SampleProgramExercise(
            name: 'Plank Variations',
            notes: 'CORE: Forearm plank. 3 rounds 45s.',
            setsJson: '[{"reps": 45, "weight": 0.0}, {"reps": 45, "weight": 0.0}, {"reps": 45, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'Dead bug',
            notes: 'CORE: Lower abs. Alternate slow. 12 each.',
            setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'Bicycle crunch',
            notes: 'CORE: Obliques. 20 each side.',
            setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'Leg raise (lying flat)',
            notes: 'CORE: Lower belly fat focus. 15 reps.',
            setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'Pulley rope crunch',
            notes: 'CORE: Kneeling rope crunch. Round spine.',
            setsJson: '[{"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}]'),
        SampleProgramExercise(
            name: 'Russian twist (DB)',
            notes: 'CORE: Love handles focus. 20 each side.',
            setsJson: '[{"reps": 20, "weight": 5.0}, {"reps": 20, "weight": 5.0}, {"reps": 20, "weight": 5.0}]'),
        SampleProgramExercise(
            name: 'Side plank',
            notes: 'CORE: Sculpts the waist. 30s each.',
            setsJson: '[{"reps": 30, "weight": 0.0}, {"reps": 30, "weight": 0.0}, {"reps": 30, "weight": 0.0}]'),
        SampleProgramExercise(
            name: 'Brisk walk', notes: 'LISS: Steady state fat burning. 30 min.'),
        SampleProgramExercise(
            name: 'Step-ups on bench', notes: 'LISS OPTION: 30 min continuous.'),
        SampleProgramExercise(
            name: 'Child\'s Pose', notes: 'Cooldown: 2 min with deep breathing'),
      ],
    ),
  ],
);

final allSamplePrograms = [
  womenFatLossProgram,
  elitePPLProgram,
];
