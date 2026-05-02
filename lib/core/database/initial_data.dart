import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';

final initialExercises = [
  const ExercisesCompanion(
    name: Value('Barbell Bench Press'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(90),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Bench Press'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Incline Barbell Bench Press'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(90),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Incline Dumbbell Bench Press'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Decline Barbell Bench Press'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(90),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Decline Dumbbell Bench Press'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Push-ups'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Cable Crossover'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Pec Deck Machine'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Flyes'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Deadlift'),
    primaryMuscle: Value('Back'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(120),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Pull-ups'),
    primaryMuscle: Value('Back'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(90),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Lat Pulldown'),
    primaryMuscle: Value('Back'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(90),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Barbell Row'),
    primaryMuscle: Value('Back'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(90),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Squat'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(120),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Leg Press'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(120),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Overhead Press'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(90),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Lateral Raises'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Barbell Curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(60),
    isCustom: Value(false),
  ),
  const ExercisesCompanion(
    name: Value('Triceps Pushdown'),
    primaryMuscle: Value('Triceps'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
    isCustom: Value(false),
  ),

  // Warmups & Mobility
  const ExercisesCompanion(
    name: Value('Arm circles + shoulder rolls'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Band pull-apart'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Band'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Wall shoulder CARs'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Scapular wall slides'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Hip circles + leg swings'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Band lateral walks'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Band'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),

  // Chest
  const ExercisesCompanion(
    name: Value('Dumbbell flat bench press'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell incline press'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell decline press'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Cable/Band Chest Fly'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Incline Push-ups'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),

  // Back
  const ExercisesCompanion(
    name: Value('Pull-ups / assisted pull-ups (wide Grip)'),
    primaryMuscle: Value('Back'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Bent-Over Row'),
    primaryMuscle: Value('Back'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Cable/Pulley Lat Pulldown'),
    primaryMuscle: Value('Back'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Reverse Fly'),
    primaryMuscle: Value('Back'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Face Pull (bent over)'),
    primaryMuscle: Value('Back'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Single-arm dumbbell row'),
    primaryMuscle: Value('Back'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Cable/pulley seated row'),
    primaryMuscle: Value('Back'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),

  // Shoulders
  const ExercisesCompanion(
    name: Value('Dumbbell lateral raise'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Standing dumbbell OHP'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Arnold Press'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell front raise'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell shrug'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),

  // Legs & Core
  const ExercisesCompanion(
    name: Value('Dumbbell Goblet Squat'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Romanian Deadlift'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Reverse Lunge'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Sumo Squat'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Ab Wheel Rollout'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Hanging Knee Raises'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Plank Variations'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(60),
  ),

  // Arms
  const ExercisesCompanion(
    name: Value('Tricep Cable/Band Pushdown'),
    primaryMuscle: Value('Triceps'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Overhead DB Tricep Extension'),
    primaryMuscle: Value('Triceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Hammer Curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Barbell-style curl (DB)'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Incline dumbbell curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Concentration curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Shoulder PullUps'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),

  // Stretches
  const ExercisesCompanion(
    name: Value('Door-frame chest stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Across-body shoulder stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Tricep Overhead Stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Child\'s Pose'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Doorway lat stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Cat-cow spinal decompression'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Glute figure-4 stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),

  // Finishers
  const ExercisesCompanion(
    name: Value('BAG: Straight Punch Rounds'),
    primaryMuscle: Value('Cardio'),
    equipment: Value('Bag'),
    setType: Value('Timed'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('BAG: Hooks + Uppercuts'),
    primaryMuscle: Value('Cardio'),
    equipment: Value('Bag'),
    setType: Value('Timed'),
    restTime: Value(60),
  ),

  // 6-Weeks to Six-Pack Abs
  const ExercisesCompanion(
    name: Value('Weighted Crunch'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Barbell Ab Rollout (Kneeling)'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Hanging Leg Raise'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Decline Crunch'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Cable Kneeling Crunch'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Side Bend'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Cable Side Bend'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Weighted Hanging Knee Raise'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Bench Weighted Decline Crunch'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Cable Kneeling Crunch (Rope)'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),

  // Additional exercises from 6-Day PPL file
  const ExercisesCompanion(
    name: Value('Resistance Band Walk (Lateral + Fwd)'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Band'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Hip Thrust Hold (Bodyweight)'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Inchworm Walk-outs'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Ankle Circles + Calf Raises'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Stiff-Leg Deadlift'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Hip Thrust (Bench)'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Bulgarian Split Squat (DB)'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Resistance Band Glute Kickback'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Band'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Calf Raise (Standing)'),
    primaryMuscle: Value('Calves'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Ab Wheel Rollout (Advanced)'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Decline Sit-up / Russian Twist'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Leg Raise (Hanging or Floor)'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('90-90 Hip Stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Lying Hamstring Stretch (Band)'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Band'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Calf Doorway Stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Supine Spinal Twist'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Standing quad stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Pigeon pose (hip flexor)'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Seated hamstring stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Dead hang passive stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Bicep wall stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Pec minor stretch (doorway)'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Overhead shoulder stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Wrist flexor/extensor stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Thoracic spine foam roll / floor'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Cat-cow thoracic rotation'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Scapular pull-ups (just scaps)'),
    primaryMuscle: Value('Back'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Wide-grip pull-ups'),
    primaryMuscle: Value('Back'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Resistance band pull-aparts'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Band'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Resistance band pull-apart (supinated)'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Band'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Neck side stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Lat stretch in doorway'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Child\'s pose with arm reach'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Supinator/pronator forearm stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Resistance Band Squat'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Band'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Light lateral raise'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Push-ups (feet elevated)'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Lateral Raise (drop set)'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Cable/Band overhead tricep'),
    primaryMuscle: Value('Triceps'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Diamond push-ups'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell decline press'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Arnold Press'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell front raise'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Reverse Grip Dumbell curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Hanging Knee Raises (Pull-up Bar)'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Plank Variations'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Glute bridges'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Bodyweight squat (slow)'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dead hang on pull-up bar'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Band pull apart with external rotation'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Band'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Light Dumbbell Lateral Raise'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbell Shoulder PullUps'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Push-up burpee'),
    primaryMuscle: Value('Cardio'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(20),
  ),
  const ExercisesCompanion(
    name: Value('Mountain climbers'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(20),
  ),
  const ExercisesCompanion(
    name: Value('High knees'),
    primaryMuscle: Value('Cardio'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(20),
  ),
  const ExercisesCompanion(
    name: Value('Lateral skater jumps'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(20),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell thruster'),
    primaryMuscle: Value('Full Body'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell swing'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell renegade row'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Farmer\'s carry'),
    primaryMuscle: Value('Full Body'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell clean and press'),
    primaryMuscle: Value('Full Body'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dead bug'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(15),
  ),
  const ExercisesCompanion(
    name: Value('Bicycle crunch'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(15),
  ),
  const ExercisesCompanion(
    name: Value('Leg raise (lying flat)'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(15),
  ),
  const ExercisesCompanion(
    name: Value('Pulley rope crunch'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(15),
  ),
  const ExercisesCompanion(
    name: Value('Russian twist (DB)'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(15),
  ),
  const ExercisesCompanion(
    name: Value('Side plank'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(15),
  ),
  const ExercisesCompanion(
    name: Value('Brisk walk'),
    primaryMuscle: Value('Cardio'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Step-ups on bench'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Bench'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Shadow boxing / dance'),
    primaryMuscle: Value('Cardio'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Scapular squeeze holds'),
    primaryMuscle: Value('Warmup'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Jump squats'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Alternating Preacher Curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Seated Bicep Curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Zottman Curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Cable Shoulder Extension'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Barbell Seated Tricep Extension'),
    primaryMuscle: Value('Triceps'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Smith Machine Shrug'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Seated Shoulder Press'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Barbell Military Press (Seated)'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('T Bar Row'),
    primaryMuscle: Value('Back'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Bench Push-Up'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Elliptical Training'),
    primaryMuscle: Value('Cardio'),
    equipment: Value('Machine'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Bodyweight Rear Lunge'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Incline Fly'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('EZ Bar Preacher Curl (Close Grip)'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('EZ Bar'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Reverse Crunch'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Rowing'),
    primaryMuscle: Value('Cardio'),
    equipment: Value('Machine'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Stability Ball Crunch'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Stability Ball'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Decline Bench Leg Raise'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bench'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Decline Bench Weighted Twist'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bench'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Assisted Hyperextension'),
    primaryMuscle: Value('Back'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Tate Press'),
    primaryMuscle: Value('Triceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Step-Up'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Decline Bench Lunge'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Bent-Over Row (Palm in)'),
    primaryMuscle: Value('Back'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Bench Press (Palms in)'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Spider Curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Cable Rope Face Pull'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Cable Tricep Pushdown (Rope)'),
    primaryMuscle: Value('Triceps'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Cable Rope Overhead Tricep Extension'),
    primaryMuscle: Value('Triceps'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Machine Calf Raise'),
    primaryMuscle: Value('Calves'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Calf Press On Leg Press'),
    primaryMuscle: Value('Calves'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Machine Shoulder Press'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Machine Tricep Extension'),
    primaryMuscle: Value('Triceps'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Machine Ab Crunch'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Machine Incline Chest Press'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Preacher Curl Machine'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Machine Seated Leg Curl'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Smith Machine Reverse Calf Raise'),
    primaryMuscle: Value('Calves'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Machine Fly'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Machine Assisted Pull-Up'),
    primaryMuscle: Value('Back'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Cable Front Lat Pulldown (Close Grip)'),
    primaryMuscle: Value('Back'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell One-Arm Front Raise'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Barbell Wrist Curl (Posterior)'),
    primaryMuscle: Value('Forearms'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Wrist Curl (Palms Down)'),
    primaryMuscle: Value('Forearms'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Wrist Curl (Palms Up)'),
    primaryMuscle: Value('Forearms'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Decline Bench Ab Reach'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bench'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Barbell Shoulder Press'),
    primaryMuscle: Value('Shoulders'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('EZ Bar Curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('EZ Bar'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Air Bike'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Neck Stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Iron Cross Stretch'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Downward Facing Dog'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Cobra'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Prisoner Squat'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Hip Abduction'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Hip Adduction'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Hack Squat'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Machine'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('V-Up'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Jackknife Sit-Up'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Good Mornings'),
    primaryMuscle: Value('Back'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Deep Squat'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Barbell Pullover'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Cable Tricep Pushdown (V-Bar)'),
    primaryMuscle: Value('Triceps'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Alternating Bicep Curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Alternating Hammer Curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Alternating Incline Curl'),
    primaryMuscle: Value('Biceps'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Barbell Tricep Extension (Supine)'),
    primaryMuscle: Value('Triceps'),
    equipment: Value('Barbell'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Bodyweight Lunge'),
    primaryMuscle: Value('Legs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Bodyweight Calf Raise'),
    primaryMuscle: Value('Calves'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(60),
  ),
  const ExercisesCompanion(
    name: Value('Cable Wood Chop'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Cable'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Dumbbell Pullover'),
    primaryMuscle: Value('Chest'),
    equipment: Value('Dumbbell'),
    setType: Value('Straight'),
    restTime: Value(90),
  ),
  const ExercisesCompanion(
    name: Value('Leg Pull-In'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Alternating Heel Touch'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Knee to Chest'),
    primaryMuscle: Value('Stretch'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Bridge'),
    primaryMuscle: Value('Abs'),
    equipment: Value('Bodyweight'),
    setType: Value('Straight'),
    restTime: Value(30),
  ),
  const ExercisesCompanion(
    name: Value('Treadmill Running'),
    primaryMuscle: Value('Cardio'),
    equipment: Value('Machine'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Walking'),
    primaryMuscle: Value('Cardio'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
  const ExercisesCompanion(
    name: Value('Running'),
    primaryMuscle: Value('Cardio'),
    equipment: Value('Bodyweight'),
    setType: Value('Timed'),
    restTime: Value(0),
  ),
];

class SampleProgramExercise {
  final String name;
  final String? notes;
  final String setsJson; // '[{"reps":10, "weight": 60.0}, ...]'
  final String setType;
  SampleProgramExercise({
    required this.name,
    this.notes,
    this.setsJson = '[]',
    this.setType = 'straight',
  });
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
          .map(
            (d) => {
              'name': d.name,
              'order': days.indexOf(d),
              'exercises': d.exercises
                  .map(
                    (e) => {
                      'exerciseName': e.name,
                      'order': d.exercises.indexOf(e),
                      'setType': e.setType,
                      'setsJson': e.setsJson,
                      'restTime': 90,
                      'notes': e.notes,
                    },
                  )
                  .toList(),
            },
          )
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
          setType: 'warmup',
          notes: '60 sec each direction',
        ),
        SampleProgramExercise(
          name: 'Band pull-apart',
          setType: 'warmup',
          notes: '2x15 reps',
        ),
        SampleProgramExercise(
          name: 'Incline Push-ups',
          setType: 'warmup',
          notes: 'slow 2x10 reps',
        ),
        SampleProgramExercise(
          name: 'Light lateral raise',
          notes: '1x15 reps',
          setsJson: '[{"reps": 15, "weight": 2.5}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell flat bench press',
          notes: 'Bench. Full ROM, elbows 45°. Primary chest builder.',
          setsJson:
              '[{"reps": 15, "weight": 7.5}, {"reps": 16, "weight": 7.5}, {"reps": 20, "weight": 7.5}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell incline press',
          notes: '45° bench angle. Hits upper chest for V-taper.',
          setsJson:
              '[{"reps": 20, "weight": 7.5}, {"reps": 20, "weight": 7.5}, {"reps": 15, "weight": 7.5}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell lateral raise',
          notes: 'Slow eccentric 3 sec. KEY for shoulder width.',
          setsJson:
              '[{"reps": 15, "weight": 5.0}, {"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 7.5}]',
        ),
        SampleProgramExercise(
          name: 'Standing dumbbell OHP',
          notes: 'Core braced. Don\'t flare elbows excessively.',
          setsJson:
              '[{"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 10.0}, {"reps": 7, "weight": 15.0}]',
        ),
        SampleProgramExercise(
          name: 'Cable/Band Chest Fly',
          notes: 'Deep stretch. Peak chest contraction.',
          setsJson:
              '[{"reps": 10, "weight": 15.0}, {"reps": 13, "weight": 15.0}, {"reps": 17, "weight": 15.0}]',
        ),
        SampleProgramExercise(
          name: 'Tricep Cable/Band Pushdown',
          notes: 'Elbows fixed. Full extension. Triceps = 2/3 of arm.',
          setsJson:
              '[{"reps": 12, "weight": 15.0}, {"reps": 9, "weight": 15.0}, {"reps": 6, "weight": 15.0}]',
        ),
        SampleProgramExercise(
          name: 'Overhead DB Tricep Extension',
          notes: 'Long head stretch. Arms bigger from behind.',
          setsJson:
              '[{"reps": 14, "weight": 7.5}, {"reps": 11, "weight": 7.5}, {"reps": 11, "weight": 7.5}]',
        ),
        SampleProgramExercise(
          name: 'BAG: Straight Punch Rounds',
          notes: '3x1 min. Hands up. Exhale each punch.',
        ),
        SampleProgramExercise(
          name: 'Door-frame chest stretch',
          setType: 'cooldown',
        ),
        SampleProgramExercise(
          name: 'Across-body shoulder stretch',
          setType: 'cooldown',
        ),
        SampleProgramExercise(
          name: 'Tricep Overhead Stretch',
          setType: 'cooldown',
        ),
        SampleProgramExercise(
          name: 'Child\'s Pose',
          setType: 'cooldown',
        ),
      ],
    ),
    SampleProgramDay(
      name: 'Pull A - Back, Biceps Focus',
      exercises: [
        SampleProgramExercise(
          name: 'Scapular wall slides',
          setType: 'warmup',
          notes: 'back on wall and slide hands on wall 2x10 reps',
        ),
        SampleProgramExercise(
          name: 'Band pull-apart',
          setType: 'warmup',
          notes: '2x15 reps',
        ),
        SampleProgramExercise(
          name: 'Dead hang on pull-up bar',
          setType: 'warmup',
          notes: '2x20 sec',
        ),
        SampleProgramExercise(
          name: 'Band pull apart with external rotation',
          setType: 'warmup',
          notes: '2x12 reps',
        ),
        SampleProgramExercise(
          name: 'Pull-ups / assisted pull-ups (wide Grip)',
          notes: 'V-taper KING. Band assist if needed.',
          setsJson:
              '[{"reps": 2, "weight": 78.0}, {"reps": 2, "weight": 78.0}, {"reps": 2, "weight": 78.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Bent-Over Row',
          notes: 'Elbows back, not flared. Squeeze at top. Mid-back thickness.',
          setsJson:
              '[{"reps": 30, "weight": 5.0}, {"reps": 20, "weight": 7.5}, {"reps": 10, "weight": 10.0}, {"reps": 14, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Cable/Pulley Lat Pulldown',
          notes: 'Wide grip. Pull to upper chest. Stretch at top.',
          setsJson:
              '[{"reps": 20, "weight": 15.0}, {"reps": 11, "weight": 25.0}, {"reps": 13, "weight": 27.5}, {"reps": 10, "weight": 27.5}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Reverse Fly',
          notes: 'Rear delts. Slow arc. 3D shoulder look.',
          setsJson:
              '[{"reps": 12, "weight": 7.5}, {"reps": 8, "weight": 10.0}, {"reps": 6, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Face Pull (bent over)',
          notes: 'Elbows high. Rotator cuff + posture.',
          setsJson:
              '[{"reps": 10, "weight": 7.5}, {"reps": 8, "weight": 10.0}, {"reps": 8, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Hammer Curl',
          notes: '60° bench. Long head bicep peak.',
          setsJson:
              '[{"reps": 11, "weight": 7.5}, {"reps": 11, "weight": 7.5}, {"reps": 6, "weight": 7.5}]',
        ),
        SampleProgramExercise(
          name: 'Barbell-style curl (DB)',
          notes: 'Supinated grip. Full ROM, no swinging.',
          setsJson:
              '[{"reps": 10, "weight": 7.5}, {"reps": 4, "weight": 10.0}, {"reps": 3, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'BAG: Hooks + Uppercuts',
          notes: '3x1 min. Rotate hips.',
        ),
        SampleProgramExercise(
          name: 'Doorway lat stretch',
          setType: 'cooldown',
          notes: '30 sec each side',
        ),
        SampleProgramExercise(
          name: 'Cat-cow spinal decompression',
          setType: 'cooldown',
          notes: '60 sec',
        ),
      ],
    ),
    SampleProgramDay(
      name: 'Legs + Abs A - Quads, Glutes, Core',
      exercises: [
        SampleProgramExercise(
          name: 'Hip circles + leg swings',
          notes: '60 sec each direction',
        ),
        SampleProgramExercise(
          name: 'Bodyweight squat (slow)',
          notes: '2x12 reps',
        ),
        SampleProgramExercise(name: 'Glute bridges', notes: '2x15 reps'),
        SampleProgramExercise(name: 'Band lateral walks', notes: '2x15 steps'),
        SampleProgramExercise(
          name: 'Dumbbell Goblet Squat',
          notes: 'Hold DB at chest. Full depth. Knees track toes.',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Romanian Deadlift',
          notes: 'Hinge at hips. Hamstring stretch. HUGE for glutes.',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Reverse Lunge',
          notes: 'Stepping back. Less knee stress than forward lunge.',
        ),
        SampleProgramExercise(
          name: 'Resistance Band Squat',
          notes: 'Band above knees. Activates glute med for width.',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Sumo Squat',
          notes: 'Wide stance. Inner quad and adductor focus.',
        ),
        SampleProgramExercise(
          name: 'Ab Wheel Rollout',
          notes: 'Slow controlled. BEST core exercise you own.',
        ),
        SampleProgramExercise(
          name: 'Hanging Knee Raises',
          notes: 'Don\'t swing. Lower slowly.',
        ),
        SampleProgramExercise(
          name: 'Plank Variations',
          notes: 'Side plank alternating. Oblique definition.',
        ),
        SampleProgramExercise(
          name: 'Glute figure-4 stretch',
          notes: '30 sec each',
        ),
      ],
    ),
    SampleProgramDay(
      name: 'Push B - Shoulder Focus',
      exercises: [
        SampleProgramExercise(name: 'Band pull-apart', notes: '2x15 reps'),
        SampleProgramExercise(
          name: 'Wall shoulder CARs',
          notes: 'each 2x12 reps',
        ),
        SampleProgramExercise(
          name: 'Wall shoulder CARs',
          notes: '5 slow circles each arm',
        ),
        SampleProgramExercise(
          name: 'Light lateral raise',
          notes: '1x20 reps',
          setsJson: '[{"reps": 20, "weight": 2.5}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Arnold Press',
          notes: 'Rotation hits all 3 delt heads. V-taper essential.',
          setsJson:
              '[{"reps": 15, "weight": 5.0}, {"reps": 12, "weight": 7.5}, {"reps": 9, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell front raise',
          notes: 'Combined arms. Controlled, no swinging.',
          setsJson:
              '[{"reps": 10, "weight": 7.5}, {"reps": 7, "weight": 10.0}, {"reps": 8, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Lateral Raise (drop set)',
          notes: '4 sec negative. KEY for widths.',
          setsJson:
              '[{"reps": 7, "weight": 7.5}, {"reps": 7, "weight": 7.5}, {"reps": 6, "weight": 7.5}]',
        ),
        SampleProgramExercise(
          name: 'Incline Push-ups',
          notes: 'Elevated feet shift load to upper chest.',
          setsJson:
              '[{"reps": 4, "weight": 0.0}, {"reps": 3, "weight": 0.0}, {"reps": 3, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell decline press',
          notes: 'Lower chest definition. Decline on bench.',
          setsJson:
              '[{"reps": 20, "weight": 7.5}, {"reps": 17, "weight": 10.0}, {"reps": 20, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Cable/Band overhead tricep',
          notes: 'Long head stretch. Width to arms.',
          setsJson:
              '[{"reps": 10, "weight": 15.0}, {"reps": 10, "weight": 15.0}, {"reps": 6, "weight": 15.0}]',
        ),
        SampleProgramExercise(
          name: 'Push-ups',
          notes: 'Diamond push-ups bodyweight finisher.',
          setsJson: '[{"reps": 4, "weight": 0.0}, {"reps": 2, "weight": 0.0}]',
        ),
      ],
    ),
    SampleProgramDay(
      name: 'Pull B - Width & Back Thickness',
      exercises: [
        SampleProgramExercise(name: 'Band pull-apart', notes: '3x15 reps'),
        SampleProgramExercise(
          name: 'Cat-cow spinal decompression',
          notes: '2x10 reps',
        ),
        SampleProgramExercise(name: 'Scapular wall slides', notes: '2x8 reps'),
        SampleProgramExercise(
          name: 'Pull-ups / assisted pull-ups (wide Grip)',
          notes: 'Widest grip comfortable.',
          setsJson:
              '[{"reps": 2, "weight": 0.0}, {"reps": 2, "weight": 0.0}, {"reps": 2, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Cable/pulley seated row',
          notes: 'Neutral grip. Retract scapula.',
        ),
        SampleProgramExercise(
          name: 'Single-arm dumbbell row',
          notes: 'Knee on bench. Heavy is okay here.',
          setsJson:
              '[{"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell shrug',
          notes: 'Traps for that athletic look. Hold at top 1 sec.',
          setsJson:
              '[{"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Incline dumbbell curl',
          notes: 'On bench 60. Long head bicep. Peak builder.',
          setsJson:
              '[{"reps": 6, "weight": 10.0}, {"reps": 4, "weight": 10.0}, {"reps": 3, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Concentration curl',
          notes: 'Elbow on inner thigh. Mind-muscle max.',
          setsJson:
              '[{"reps": 9, "weight": 10.0}, {"reps": 6, "weight": 10.0}, {"reps": 6, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Shoulder PullUps',
          notes: 'Pull dumbbell till face height.',
          setsJson:
              '[{"reps": 10, "weight": 10.0}, {"reps": 10, "weight": 10.0}, {"reps": 10, "weight": 10.0}, {"reps": 10, "weight": 10.0}]',
        ),
        SampleProgramExercise(name: 'Doorway lat stretch'),
      ],
    ),
    SampleProgramDay(
      name: 'Legs + Abs B — Posterior Chain, Calves, Obliques',
      exercises: [
        SampleProgramExercise(
          name: 'Resistance Band Walk (Lateral + Fwd)',
          notes: '15 steps each direction',
        ),
        SampleProgramExercise(
          name: 'Hip Thrust Hold (Bodyweight)',
          notes: '3x30 sec',
        ),
        SampleProgramExercise(name: 'Inchworm Walk-outs', notes: '2x8 reps'),
        SampleProgramExercise(
          name: 'Ankle Circles + Calf Raises',
          notes: '2x10 each',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Stiff-Leg Deadlift',
          notes: 'Hinge pattern. Keep back flat.',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Hip Thrust (Bench)',
          notes: 'Upper glute focus. Chin tucked.',
        ),
        SampleProgramExercise(
          name: 'Bulgarian Split Squat (DB)',
          notes: 'Rear foot elevated. Full depth.',
        ),
        SampleProgramExercise(
          name: 'Resistance Band Glute Kickback',
          notes: '3x15 each leg',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Calf Raise (Standing)',
          notes: 'Full stretch at bottom.',
        ),
        SampleProgramExercise(
          name: 'Ab Wheel Rollout (Advanced)',
          notes: 'Control the negative.',
        ),
        SampleProgramExercise(
          name: 'Decline Sit-up / Russian Twist',
          notes: 'Oblique burn.',
        ),
        SampleProgramExercise(
          name: 'Leg Raise (Hanging or Floor)',
          notes: 'No swinging.',
        ),
        SampleProgramExercise(name: '90-90 Hip Stretch', notes: '30 sec each'),
        SampleProgramExercise(
          name: 'Lying Hamstring Stretch (Band)',
          notes: '30 sec each',
        ),
        SampleProgramExercise(
          name: 'Calf Doorway Stretch',
          notes: '30 sec each',
        ),
        SampleProgramExercise(
          name: 'Supine Spinal Twist',
          notes: '30 sec each side',
        ),
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
          name: 'Arm circles + shoulder rolls',
          setType: 'warmup',
          notes: 'Warmup: 30 sec each',
        ),
        SampleProgramExercise(
          name: 'Push-ups',
          setType: 'warmup',
          notes: 'Warmup: Wall push-ups x15',
        ),
        SampleProgramExercise(
          name: 'Band pull-apart',
          setType: 'warmup',
          notes: 'Warmup: 15 reps',
        ),
        SampleProgramExercise(
          name: 'Dumbbell flat bench press',
          notes: 'BLOCK A: Barbell bench press. Control descent (2 sec).',
          setsJson:
              '[{"reps": 10, "weight": 20.0}, {"reps": 10, "weight": 20.0}, {"reps": 10, "weight": 20.0}, {"reps": 10, "weight": 20.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell incline press',
          notes: 'BLOCK A: Incline press 30-45°. Go heavier weekly.',
          setsJson:
              '[{"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Flyes',
          notes: 'BLOCK A: DB chest fly. Light weight, focus on stretch.',
          setsJson:
              '[{"reps": 15, "weight": 5.0}, {"reps": 15, "weight": 5.0}, {"reps": 15, "weight": 5.0}]',
        ),
        SampleProgramExercise(
          name: 'Standing dumbbell OHP',
          notes: 'BLOCK B: Shoulders. Core tight, no back arch.',
          setsJson:
              '[{"reps": 12, "weight": 7.5}, {"reps": 12, "weight": 7.5}, {"reps": 12, "weight": 7.5}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell lateral raise',
          notes: 'BLOCK B: Lead with elbows, not wrists.',
          setsJson:
              '[{"reps": 15, "weight": 2.5}, {"reps": 15, "weight": 2.5}, {"reps": 15, "weight": 2.5}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell front raise',
          notes: 'BLOCK B: Pulley/DB front raise. Slow and controlled.',
          setsJson:
              '[{"reps": 12, "weight": 5.0}, {"reps": 12, "weight": 5.0}, {"reps": 12, "weight": 5.0}]',
        ),
        SampleProgramExercise(
          name: 'Overhead DB Tricep Extension',
          notes: 'BLOCK C: Triceps. Long head stretch.',
          setsJson:
              '[{"reps": 15, "weight": 7.5}, {"reps": 15, "weight": 7.5}, {"reps": 15, "weight": 7.5}]',
        ),
        SampleProgramExercise(
          name: 'Triceps Pushdown',
          notes: 'BLOCK C: Elbows fixed to sides.',
          setsJson:
              '[{"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Push-ups',
          notes: 'FINISHER: Push-ups to failure x2 sets',
        ),
        SampleProgramExercise(
          name: 'Side plank',
          notes: 'FINISHER: 30 sec plank after each set',
        ),
        SampleProgramExercise(
          name: 'Door-frame chest stretch',
          setType: 'cooldown',
          notes: 'Cooldown: 45 sec',
        ),
        SampleProgramExercise(
          name: 'Across-body shoulder stretch',
          setType: 'cooldown',
          notes: 'Cooldown: 30 sec',
        ),
        SampleProgramExercise(
          name: 'Tricep Overhead Stretch',
          setType: 'cooldown',
          notes: 'Cooldown: 30 sec',
        ),
        SampleProgramExercise(
          name: 'Child\'s Pose',
          setType: 'cooldown',
          notes: 'Cooldown: 1 min',
        ),
      ],
    ),
    SampleProgramDay(
      name: 'Day 2: Pull Day (Back, Biceps)',
      exercises: [
        SampleProgramExercise(
          name: 'Cat-cow spinal decompression',
          notes: 'Warmup: x10 reps',
        ),
        SampleProgramExercise(
          name: 'Band pull-apart',
          notes: 'Warmup: Towel row x15',
        ),
        SampleProgramExercise(
          name: 'Single-arm dumbbell row',
          notes: 'Warmup: x12 each side',
        ),
        SampleProgramExercise(
          name: 'Scapular squeeze holds',
          notes: 'Warmup: x10 holds',
        ),
        SampleProgramExercise(
          name: 'Barbell Row',
          notes: 'BLOCK A: Bent-over row. Pull bar to belly button.',
          setsJson:
              '[{"reps": 10, "weight": 20.0}, {"reps": 10, "weight": 22.5}, {"reps": 10, "weight": 25.0}, {"reps": 10, "weight": 25.0}]',
        ),
        SampleProgramExercise(
          name: 'Single-arm dumbbell row',
          notes: 'BLOCK A: Brace against bench. drive elbow back.',
          setsJson:
              '[{"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Cable/pulley seated row',
          notes: 'BLOCK A: Pull to sternum. Squeeze for 1 sec.',
          setsJson:
              '[{"reps": 12, "weight": 15.0}, {"reps": 12, "weight": 15.0}, {"reps": 12, "weight": 15.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Reverse Fly',
          notes: 'BLOCK B: Rear delts. Hinge 45, arms wide.',
          setsJson:
              '[{"reps": 15, "weight": 2.5}, {"reps": 15, "weight": 2.5}, {"reps": 15, "weight": 2.5}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Face Pull (bent over)',
          notes: 'BLOCK B: Pulley face pull. High attachment.',
          setsJson:
              '[{"reps": 20, "weight": 10.0}, {"reps": 20, "weight": 10.0}, {"reps": 20, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Barbell Curl',
          notes: 'BLOCK C: Biceps. Full peak focus.',
          setsJson:
              '[{"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Hammer Curl',
          notes: 'BLOCK C: Brachialis focus.',
          setsJson:
              '[{"reps": 12, "weight": 5.0}, {"reps": 12, "weight": 5.0}, {"reps": 12, "weight": 5.0}]',
        ),
        SampleProgramExercise(
          name: 'Cable/pulley seated row',
          notes: 'BLOCK C: Standing low curl. Elbows forward.',
          setsJson:
              '[{"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Band pull-apart',
          notes: 'FINISHER: Posture circuit x2 rounds',
        ),
        SampleProgramExercise(
          name: 'Plank Variations',
          notes: 'FINISHER: Superman hold x10 sec',
        ),
        SampleProgramExercise(
          name: 'Door-frame chest stretch',
          notes: 'FINISHER: Stretch 45 sec',
        ),
        SampleProgramExercise(
          name: 'Doorway lat stretch',
          notes: 'Cooldown: 45 sec each',
        ),
        SampleProgramExercise(name: 'Child\'s Pose', notes: 'Cooldown: 1 min'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 3: Lower Body Day',
      exercises: [
        SampleProgramExercise(
          name: 'Hip circles + leg swings',
          notes: 'Warmup: 30 sec each',
        ),
        SampleProgramExercise(
          name: 'Bodyweight squat (slow)',
          notes: 'Warmup: x15 slow',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Reverse Lunge',
          notes: 'Warmup: x10 each leg',
        ),
        SampleProgramExercise(name: 'Glute bridges', notes: 'Warmup: x15'),
        SampleProgramExercise(
          name: 'Squat',
          notes: 'BLOCK A: Barbell back squat. Fat-burning powerhouse.',
          setsJson:
              '[{"reps": 10, "weight": 20.0}, {"reps": 10, "weight": 25.0}, {"reps": 10, "weight": 30.0}, {"reps": 10, "weight": 30.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Goblet Squat',
          notes: 'BLOCK A: One heavy DB at chest. Sit back.',
          setsJson:
              '[{"reps": 15, "weight": 15.0}, {"reps": 15, "weight": 15.0}, {"reps": 15, "weight": 15.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Reverse Lunge',
          notes: 'BLOCK A: step back, knee hovers 1in off floor.',
          setsJson:
              '[{"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Hip Thrust (Bench)',
          notes: 'BLOCK B: Glute max. Squeeze at top 1s.',
          setsJson:
              '[{"reps": 15, "weight": 15.0}, {"reps": 15, "weight": 20.0}, {"reps": 15, "weight": 20.0}, {"reps": 15, "weight": 20.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Romanian Deadlift',
          notes: 'BLOCK B: Soft knees, hinge at hips.',
          setsJson:
              '[{"reps": 12, "weight": 20.0}, {"reps": 12, "weight": 20.0}, {"reps": 12, "weight": 20.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Sumo Squat',
          notes: 'BLOCK B: Wide stance, toes out 45°. Targets inner thigh.',
          setsJson:
              '[{"reps": 15, "weight": 15.0}, {"reps": 15, "weight": 15.0}, {"reps": 15, "weight": 15.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Calf Raise (Standing)',
          notes: 'BLOCK C: Pause at bottom for stretch.',
          setsJson:
              '[{"reps": 20, "weight": 10.0}, {"reps": 20, "weight": 10.0}, {"reps": 20, "weight": 10.0}, {"reps": 20, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Jump squats',
          notes: 'FINISHER: Leg burnout - Jump squats x15',
        ),
        SampleProgramExercise(
          name: 'Glute bridges',
          notes: 'FINISHER: Glute bridge hold 30s',
        ),
        SampleProgramExercise(
          name: 'Standing quad stretch',
          notes: 'Cooldown: 45 sec each',
        ),
        SampleProgramExercise(
          name: 'Seated hamstring stretch',
          notes: 'Cooldown: 1 min',
        ),
        SampleProgramExercise(
          name: 'Pigeon pose (hip flexor)',
          notes: 'Cooldown: 1 min each side',
        ),
      ],
    ),
    SampleProgramDay(
      name: 'Day 4: HIIT & Metabolic Circuit',
      exercises: [
        SampleProgramExercise(
          name: 'Shadow boxing / dance',
          notes: 'Warmup: 3 min gradually increasing',
        ),
        SampleProgramExercise(
          name: 'High knees',
          notes: 'Warmup: 30 sec moderate pace',
        ),
        SampleProgramExercise(
          name: 'Jump squats',
          notes: 'HIIT BLOCK: 40s ON / 20s OFF. 4 rounds.',
          setsJson:
              '[{"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Push-up burpee',
          notes: 'HIIT BLOCK: 40s ON / 20s OFF. 4 rounds. Do full push-up.',
          setsJson:
              '[{"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Mountain climbers',
          notes: 'HIIT BLOCK: 40s ON / 20s OFF. 4 rounds. Fast pace.',
          setsJson:
              '[{"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'High knees',
          notes: 'HIIT BLOCK: 40s ON / 20s OFF. 4 rounds. Sprint intensity.',
          setsJson:
              '[{"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Lateral skater jumps',
          notes: 'HIIT BLOCK: 40s ON / 20s OFF. 4 rounds. Land on one foot.',
          setsJson:
              '[{"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}, {"reps": 40, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell thruster',
          notes: 'METABOLIC: Squat to press. 3 rounds 45s each.',
          setsJson:
              '[{"reps": 45, "weight": 5.0}, {"reps": 45, "weight": 5.0}, {"reps": 45, "weight": 5.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell swing',
          notes: 'METABOLIC: Hinge and drive. 3 rounds 45s each.',
          setsJson:
              '[{"reps": 45, "weight": 7.5}, {"reps": 45, "weight": 7.5}, {"reps": 45, "weight": 7.5}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell renegade row',
          notes: 'METABOLIC: Plank rows. 3 rounds 45s each.',
          setsJson:
              '[{"reps": 45, "weight": 5.0}, {"reps": 45, "weight": 5.0}, {"reps": 45, "weight": 5.0}]',
        ),
        SampleProgramExercise(
          name: 'Brisk walk',
          notes: 'Cooldown: Walk in place 2 min',
        ),
        SampleProgramExercise(
          name: 'Seated hamstring stretch',
          notes: 'Cooldown: Forward fold 1 min',
        ),
      ],
    ),
    SampleProgramDay(
      name: 'Day 5: Full Body Strength',
      exercises: [
        SampleProgramExercise(
          name: 'Inchworm Walk-outs',
          notes: 'Warmup: x8 reps',
        ),
        SampleProgramExercise(
          name: 'Bodyweight squat (slow)',
          notes: 'Warmup: x15 reps',
        ),
        SampleProgramExercise(
          name: 'Deadlift',
          notes: 'BLOCK A: Barbell deadlift. Neutral back. Fat loss KING.',
          setsJson:
              '[{"reps": 8, "weight": 20.0}, {"reps": 8, "weight": 30.0}, {"reps": 8, "weight": 40.0}, {"reps": 8, "weight": 40.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Romanian Deadlift',
          notes: 'BLOCK A: Hamstrings focus.',
          setsJson:
              '[{"reps": 10, "weight": 15.0}, {"reps": 10, "weight": 15.0}, {"reps": 10, "weight": 15.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell flat bench press',
          notes: 'BLOCK B: SUPERSET A (Push).',
          setsJson:
              '[{"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}, {"reps": 12, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Lat Pulldown',
          notes: 'BLOCK B: SUPERSET B (Pull). 60s rest after this.',
          setsJson:
              '[{"reps": 12, "weight": 15.0}, {"reps": 12, "weight": 15.0}, {"reps": 12, "weight": 15.0}]',
        ),
        SampleProgramExercise(
          name: 'Standing dumbbell OHP',
          notes: 'BLOCK B: SUPERSET A (Push - Shoulders).',
          setsJson:
              '[{"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 7.5}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell Face Pull (bent over)',
          notes: 'BLOCK B: SUPERSET B (Pull - Posture).',
          setsJson:
              '[{"reps": 15, "weight": 5.0}, {"reps": 15, "weight": 5.0}, {"reps": 15, "weight": 5.0}]',
        ),
        SampleProgramExercise(
          name: 'Farmer\'s carry',
          notes: 'BLOCK C: heavy DBs, walk 20m. Core stability.',
          setsJson:
              '[{"reps": 1, "weight": 15.0}, {"reps": 1, "weight": 15.0}, {"reps": 1, "weight": 15.0}]',
        ),
        SampleProgramExercise(
          name: 'Dumbbell clean and press',
          notes: 'BLOCK C: explosive movement. Swing to shoulder then press.',
          setsJson:
              '[{"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 7.5}, {"reps": 10, "weight": 7.5}]',
        ),
        SampleProgramExercise(
          name: 'Push-ups',
          notes:
              'FINISHER: 5-min AMRAP of Push-up(10), JumpSquat(10), Plank(20s)',
        ),
        SampleProgramExercise(
          name: 'Cat-cow thoracic rotation',
          notes: 'Cooldown: 1 min each side',
        ),
        SampleProgramExercise(
          name: 'Supine Spinal Twist',
          notes: 'Cooldown: 1 min each side',
        ),
      ],
    ),
    SampleProgramDay(
      name: 'Day 6: Core, Abs & LISS',
      exercises: [
        SampleProgramExercise(name: 'Dead bug', notes: 'Warmup: x10 reps'),
        SampleProgramExercise(name: 'Glute bridges', notes: 'Warmup: x15 reps'),
        SampleProgramExercise(
          name: 'Mountain climbers',
          notes: 'Warmup: slow x20 reps',
        ),
        SampleProgramExercise(
          name: 'Plank Variations',
          notes: 'CORE: Forearm plank. 3 rounds 45s.',
          setsJson:
              '[{"reps": 45, "weight": 0.0}, {"reps": 45, "weight": 0.0}, {"reps": 45, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Dead bug',
          notes: 'CORE: Lower abs. Alternate slow. 12 each.',
          setsJson:
              '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Bicycle crunch',
          notes: 'CORE: Obliques. 20 each side.',
          setsJson:
              '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Leg raise (lying flat)',
          notes: 'CORE: Lower belly fat focus. 15 reps.',
          setsJson:
              '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Pulley rope crunch',
          notes: 'CORE: Kneeling rope crunch. Round spine.',
          setsJson:
              '[{"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}, {"reps": 15, "weight": 10.0}]',
        ),
        SampleProgramExercise(
          name: 'Russian twist (DB)',
          notes: 'CORE: Love handles focus. 20 each side.',
          setsJson:
              '[{"reps": 20, "weight": 5.0}, {"reps": 20, "weight": 5.0}, {"reps": 20, "weight": 5.0}]',
        ),
        SampleProgramExercise(
          name: 'Side plank',
          notes: 'CORE: Sculpts the waist. 30s each.',
          setsJson:
              '[{"reps": 30, "weight": 0.0}, {"reps": 30, "weight": 0.0}, {"reps": 30, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Brisk walk',
          notes: 'LISS: Steady state fat burning. 30 min.',
        ),
        SampleProgramExercise(
          name: 'Step-ups on bench',
          notes: 'LISS OPTION: 30 min continuous.',
        ),
        SampleProgramExercise(
          name: 'Child\'s Pose',
          notes: 'Cooldown: 2 min with deep breathing',
        ),
      ],
    ),
  ],
);



final sixWeeksToSixPackAbsProgram = SampleProgram(
  name: '6-Weeks to Six-Pack Abs',
  description:
      'The 6-Weeks to Six-Pack Abs routine by JefitTeam is a 2 day workout plan. It is an intermediate level plan to achieve cutting fitness goals.',
  goal: 'Cutting',
  duration: '6 Weeks',
  days: [
    SampleProgramDay(
      name: 'Week 1 - 3',
      exercises: [
        SampleProgramExercise(
          name: 'Weighted Crunch',
          notes: '3 Sets x 30 Reps',
          setsJson: '[{"reps": 30, "weight": 0.0}, {"reps": 30, "weight": 0.0}, {"reps": 30, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Barbell Ab Rollout (Kneeling)',
          notes: '3 Sets x 20 Reps',
          setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Hanging Leg Raise',
          notes: '3 Sets x 25 Reps',
          setsJson: '[{"reps": 25, "weight": 0.0}, {"reps": 25, "weight": 0.0}, {"reps": 25, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Decline Crunch',
          notes: '3 Sets x 20 Reps',
          setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Cable Kneeling Crunch',
          notes: '3 Sets x 30 Reps',
          setsJson: '[{"reps": 30, "weight": 0.0}, {"reps": 30, "weight": 0.0}, {"reps": 30, "weight": 0.0}]',
        ),
      ],
    ),
    SampleProgramDay(
      name: 'Week 4 - 6',
      exercises: [
        SampleProgramExercise(
          name: 'Dumbbell Side Bend',
          notes: '4 Sets x 12 Reps',
          setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Cable Side Bend',
          notes: '4 Sets x 12 Reps',
          setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Weighted Hanging Knee Raise',
          notes: '4 Sets x 20 Reps',
          setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Bench Weighted Decline Crunch',
          notes: '4 Sets x 12 Reps',
          setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]',
        ),
        SampleProgramExercise(
          name: 'Cable Kneeling Crunch (Rope)',
          notes: '4 Sets x 12 Reps',
          setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]',
        ),
      ],
    ),
  ],
);

final fiveDayMuscleMassSplitProgram = SampleProgram(
  name: '5 Day Muscle Mass Split',
  description:
      'Intermediate level plan to achieve bulking goals by performing explosive movements and heavy weight.',
  goal: 'Bulking',
  duration: '7 Days',
  days: [
    SampleProgramDay(
      name: 'Mon: Chest and Back',
      exercises: [
        SampleProgramExercise(name: 'Barbell Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Incline Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Incline Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Pull-Up', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Lat Pulldown (Wide Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell One-Arm Row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Deadlift', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Tue: Legs and Abs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Curl (Prone)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Lunge', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Standing Calf Raise', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Seated Calf Raise', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Crunch', setsJson: '[{"reps": 30, "weight": 0.0}, {"reps": 30, "weight": 0.0}, {"reps": 30, "weight": 0.0}, {"reps": 30, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Side Bend', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Weighted Hanging Knee Raise', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Bench Weighted Decline Crunch', setsJson: '[{"reps": 25, "weight": 0.0}, {"reps": 25, "weight": 0.0}, {"reps": 25, "weight": 0.0}, {"reps": 25, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Wed: Arms',
      exercises: [
        SampleProgramExercise(name: 'Barbell Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Preacher Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Seated Bicep Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Zottman Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Concentration Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Tricep Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bench Press (Close Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Shoulder Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Seated Tricep Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Tricep Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Fri: Shoulders and Back',
      exercises: [
        SampleProgramExercise(name: 'Dumbbell Arnold Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell shrug', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Smith Machine Shrug', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Lateral Raise', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Seated Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Military Press (Seated)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Deadlift', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Lat Pulldown (Wide Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'T Bar Row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell One-Arm Row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Weighted Pull-Up', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Sat: Chest and Legs',
      exercises: [
        SampleProgramExercise(name: 'Machine Leg Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Curl (Prone)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bench Press', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}, {"reps": 4, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dip', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 30, "weight": 0.0}, {"reps": 40, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Push-ups', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Push-ups (Close Hand)', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Bench Push-Up', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
      ],
    ),
  ],
);

final fromFatToFitProgram = SampleProgram(
  name: 'From Fat to Fit (3-Month Plan)',
  description:
      'Advanced cutting routine designed to increase heart rate intensity and metabolic rate for stimulated fat loss.',
  goal: 'Cutting',
  duration: '3 Months',
  days: [
    SampleProgramDay(
      name: 'Mon: Legs and Abs',
      exercises: [
        SampleProgramExercise(name: 'Elliptical Training', setsJson: '[]'),
        SampleProgramExercise(name: 'Bodyweight Lunge', setsJson: '[{"reps": 6, "weight": 0.0}, {"reps": 6, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Bodyweight Rear Lunge', setsJson: '[{"reps": 6, "weight": 0.0}, {"reps": 6, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Jump squats', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Bodyweight Calf Raise', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Prisoner Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Crunch', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Wood Chop', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Hanging Leg Raise', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Elliptical Training', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Tue: Cardio & Chest',
      exercises: [
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Dumbbell Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Incline Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Flyes', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Incline Fly', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Walking', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Wed: Arms and Abs',
      exercises: [
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Dumbbell Goblet Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Seated Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Tricep Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Lateral Raise', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'EZ Bar Preacher Curl (Close Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dip', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Oblique Crunch', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Reverse Crunch', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Plank Variations', setsJson: '[]'),
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Thu: Cardio & Back',
      exercises: [
        SampleProgramExercise(name: 'Rowing', setsJson: '[]'),
        SampleProgramExercise(name: 'Cable Lat Pulldown (Wide Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable/pulley seated row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Assisted Hyperextension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Pull-ups / assisted pull-ups (wide Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Hanging Leg Raise', setsJson: '[{"reps": 18, "weight": 0.0}, {"reps": 18, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Crunch', setsJson: '[{"reps": 18, "weight": 0.0}, {"reps": 18, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Wood Chop', setsJson: '[{"reps": 18, "weight": 0.0}, {"reps": 18, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Rowing', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Fri: Legs and Abs',
      exercises: [
        SampleProgramExercise(name: 'Elliptical Training', setsJson: '[]'),
        SampleProgramExercise(name: 'Bodyweight Rear Lunge', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Jump squats', setsJson: '[{"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Bodyweight Calf Raise', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Prisoner Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Bench Weighted Decline Crunch', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Crunch', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Wood Chop', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Elliptical Training', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Sat: Chest and Abs',
      exercises: [
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Dumbbell Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Incline Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Flyes', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Incline Fly', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Push-ups', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Stability Ball Crunch', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Decline Bench Leg Raise', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Decline Bench Weighted Twist', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Walking', setsJson: '[]'),
        SampleProgramExercise(name: 'Assisted Hyperextension', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Sun: Full Body',
      exercises: [
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Dumbbell Goblet Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Seated Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Tricep Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Lateral Raise', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'EZ Bar Preacher Curl (Close Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dip', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Oblique Crunch', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Reverse Crunch', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
      ],
    ),
  ],
);

final fullBodyHomeWorkoutDumbbellOnlyProgram = SampleProgram(
  name: 'Full Body Home Workout: Dumbbell Only',
  description:
      'Beginner level plan meant for those who do not go to a gym or looking for a full body routine with dumbbells only.',
  goal: 'General Fitness',
  duration: '7 Days',
  days: [
    SampleProgramDay(
      name: 'Day 1',
      exercises: [
        SampleProgramExercise(name: 'Dumbbell Stiff-Leg Deadlift', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Reverse Lunge', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Bench Press', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Incline Bench Press', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell One-Arm Row', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Bicep Curl', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Incline Curl', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Kickback', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Tricep Extension', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Seated Shoulder Press', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 2',
      exercises: [
        SampleProgramExercise(name: 'Dumbbell Goblet Squat', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Reverse Lunge', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Deadlift', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Flyes', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Incline Fly', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Hammer Curl', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Tricep Extension (Supine)', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Tate Press', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Arnold Press', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell lateral raise', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 3',
      exercises: [
        SampleProgramExercise(name: 'Dumbbell Step-Up', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Decline Bench Lunge', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Bent-Over Row (Palm in)', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Bent-Over Row', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Bench Press (Palms in)', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Pullover', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Spider Curl', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Concentration Curl', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Kickback', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell One-Arm Tricep Extension', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Upright Row', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell shrug', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
      ],
    ),
  ],
);

final redditPPLProgram = SampleProgram(
  name: "Reddit Metallicadpa's Beginner PPL",
  description:
      'A Linear Progression Based PPL Program for Beginners. Focuses on heavy compound lifts with AMRAP sets.',
  goal: 'General Fitness',
  duration: '6 Days',
  days: [
    SampleProgramDay(
      name: 'Day 1: Pull',
      exercises: [
        SampleProgramExercise(name: 'Barbell Deadlift', setsJson: '[{"reps": 5, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Pull-Up', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable/pulley seated row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Rope Face Pull', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Hammer Curls', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Seated Bicep Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 2: Push',
      exercises: [
        SampleProgramExercise(name: 'Barbell Bench Press', setsJson: '[{"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Incline Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Tricep Pushdown (Rope)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Lateral Raise', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Rope Overhead Tricep Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 3: Legs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Squat', setsJson: '[{"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Romanian Deadlift', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Curl (Prone)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Calf Raise', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 5: Pull 2',
      exercises: [
        SampleProgramExercise(name: 'Barbell Bent-Over Row', setsJson: '[{"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Pull-Up', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable/pulley seated row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Rope Face Pull', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Hammer Curls', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Seated Bicep Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 6: Push 2',
      exercises: [
        SampleProgramExercise(name: 'Barbell Shoulder Press', setsJson: '[{"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Incline Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Tricep Pushdown (Rope)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Lateral Raise', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Rope Overhead Tricep Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 7: Legs 2',
      exercises: [
        SampleProgramExercise(name: 'Barbell Squat', setsJson: '[{"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}, {"reps": 5, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Romanian Deadlift', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Curl (Prone)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Calf Raise', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
      ],
    ),
  ],
);

final machineOnlyBeginnerWorkoutProgram = SampleProgram(
  name: 'Machine-Only Beginner Workout',
  description:
      'Effective routine designed for beginners to build confidence and strength using exercise machines for isolation.',
  goal: 'General Fitness',
  duration: '3 Days',
  days: [
    SampleProgramDay(
      name: 'Day 1: Workout A',
      exercises: [
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Calf Press On Leg Press', setsJson: '[{"reps": 14, "weight": 0.0}, {"reps": 14, "weight": 0.0}, {"reps": 14, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Bench Press - smith machine', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Shoulder Press', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable/pulley seated row', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Tricep Extension', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Ab Crunch', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 2: Workout B',
      exercises: [
        SampleProgramExercise(name: 'Machine Leg Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Calf Raise', setsJson: '[{"reps": 14, "weight": 0.0}, {"reps": 14, "weight": 0.0}, {"reps": 14, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Incline Chest Press', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Lat Pulldown (Wide Grip)', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Shoulder press - smith machine', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Preacher Curl Machine', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Kneeling Crunch (Rope)', setsJson: '[{"reps": 14, "weight": 0.0}, {"reps": 14, "weight": 0.0}, {"reps": 14, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 3: Workout C',
      exercises: [
        SampleProgramExercise(name: 'Machine Seated Leg Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Smith Machine Reverse Calf Raise', setsJson: '[{"reps": 14, "weight": 0.0}, {"reps": 14, "weight": 0.0}, {"reps": 14, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Fly', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Assisted Pull-Up', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Smith Machine Shrug', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Bicep Curl (Close Grip)', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Shoulder Extension', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Side Bend', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
      ],
    ),
  ],
);

final beginnerRoutineProgram = SampleProgram(
  name: 'Beginner Routine',
  description:
      'Designed for bodybuilding beginners who want to gain muscle. CONSISTS OF CHEST, SHOULDERS, BACK, ARMS AND LEGS TRAINING.',
  goal: 'Bulking',
  duration: '7 Days',
  days: [
    SampleProgramDay(
      name: 'Mon: Chest and Triceps',
      exercises: [
        SampleProgramExercise(name: 'Barbell Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Incline Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dip', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Fly', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Tricep Extension (Supine)', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Tricep Pushdown (Rope)', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Wed: Back and Biceps',
      exercises: [
        SampleProgramExercise(name: 'Cable Lat Pulldown (Wide Grip)', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bent-Over Row', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Hammer Curl', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Deadlift', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Incline Curl', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Pull-Up', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'EZ Bar Curl', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Fri: Shoulders and Legs',
      exercises: [
        SampleProgramExercise(name: 'Dumbbell Lateral Raise', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Lunge', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Seated Shoulder Press', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Shoulder Press', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell shrug', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Curl (Prone)', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Sat: Abs',
      exercises: [
        SampleProgramExercise(name: 'Air Bike', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Decline Crunch', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Ab Crunch', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Leg Pull-In', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
      ],
    ),
  ],
);

final getRippedProgram = SampleProgram(
  name: 'Get Ripped',
  description:
      '5 day workout routine to help build muscle while also shedding off unwanted poundage to get ripped. Uses supersets and high intensity.',
  goal: 'General Fitness',
  duration: '5 Days',
  days: [
    SampleProgramDay(
      name: 'Mon: Chest and Arms',
      exercises: [
        SampleProgramExercise(name: 'Barbell Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Flyes', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Seated Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dip', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Tricep Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Bicep Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Walking', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Tue: Back and Legs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Lunge', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Deadlift', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bent-Over Row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Calf Press On Leg Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Lat Pulldown (Wide Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable/pulley seated row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Jackknife Sit-Up', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Stability Ball Crunch', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Rowing', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Wed: Chest and Arms',
      exercises: [
        SampleProgramExercise(name: 'Barbell Incline Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Incline Fly', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Seated Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dip', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Tricep Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Shoulder Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Bicep Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Walking', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Thu: Back and Legs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Lunge', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Deadlift', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bent-Over Row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Calf Press On Leg Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Lat Pulldown (Wide Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell One-Arm Row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Pull-Up', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Jackknife Sit-Up', setsJson: '[{"reps": 13, "weight": 0.0}, {"reps": 13, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Stability Ball Crunch', setsJson: '[{"reps": 22, "weight": 0.0}, {"reps": 22, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Rowing', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Fri: Chest and Arms',
      exercises: [
        SampleProgramExercise(name: 'Barbell Decline Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Decline Fly', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Seated Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dip', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Tricep Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Tricep Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Shoulder Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Bicep Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'EZ Bar Preacher Curl (Close Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell One-Arm Preacher Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Walking', setsJson: '[]'),
      ],
    ),
  ],
);

final advancedRoutineProgram = SampleProgram(
  name: 'Advanced Routine',
  description:
      '5 day split routine focusing on building muscle and targeting each muscle group separately. Uses isolation and slow movements.',
  goal: 'Bulking',
  duration: '8 Days',
  days: [
    SampleProgramDay(
      name: 'Mon: Chest and Abs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Bench Press', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Incline Bench Press', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Flyes', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Incline Fly', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Cross-Over', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dip', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Crunch', setsJson: '[]'),
        SampleProgramExercise(name: 'Stability Ball Crunch', setsJson: '[]'),
        SampleProgramExercise(name: 'Plank Variations', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Tue: Shoulders and Abs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Shoulder Press', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Arnold Press', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Shrug', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Upright Row', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Lateral Raise', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell One-Arm Front Raise', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Parallel Bar Hip Raise', setsJson: '[]'),
        SampleProgramExercise(name: 'Hanging Leg Raise', setsJson: '[]'),
        SampleProgramExercise(name: 'Reverse Crunch', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Wed: Legs and Abs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Squat', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Extension', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Seated Leg Curl', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Calf Press On Leg Press', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Standing Calf Raise', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Decline Crunch', setsJson: '[]'),
        SampleProgramExercise(name: 'Leg Pull-In', setsJson: '[]'),
        SampleProgramExercise(name: 'Alternating Heel Touch', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Thu: Arms and Abs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Curl', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Bicep Curl (Close Grip)', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Bicep Curl', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Concentration Curl', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bench Press (Close Grip)', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Tricep Extension (Supine)', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Shoulder Extension', setsJson: '[{"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Wrist Curl (Posterior)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Wrist Curl (Palms Down)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Wrist Curl (Palms Up)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Crunch', setsJson: '[]'),
        SampleProgramExercise(name: 'Stability Ball Crunch', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Fri: Back and Abs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Deadlift', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bent-Over Row', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Lat Pulldown (Wide Grip)', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Front Lat Pulldown (Close Grip)', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable/pulley seated row', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell One-Arm Row', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Pull-Up', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Decline Bench Ab Reach', setsJson: '[]'),
        SampleProgramExercise(name: 'Plank Variations', setsJson: '[]'),
      ],
    ),
  ],
);

final intermediateRoutineProgram = SampleProgram(
  name: 'Intermediate Routine',
  description:
      '4-day split for those stepping up from beginner routines. Focuses on heavier weights and muscle growth.',
  goal: 'General Fitness',
  duration: '7 Days',
  days: [
    SampleProgramDay(
      name: 'Mon: Chest and Triceps',
      exercises: [
        SampleProgramExercise(name: 'Barbell Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Incline Bench Press', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Bench Press', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Incline Bench Press', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Flyes', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bench Press (Close Grip)', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Tricep Extension', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Tricep Extension', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Tricep Pushdown (V-Bar)', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Walking', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Wed: Legs and Abs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Squat', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Deadlift', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Extension', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Seated Leg Curl', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Standing Calf Raise', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Calf Press On Leg Press', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Kneeling Crunch (Rope)', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Crunch', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Plank Variations', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Fri: Back and Abs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Deadlift', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bent-Over Row', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Lat Pulldown (Wide Grip)', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Front Lat Pulldown (Close Grip)', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable/pulley seated row', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell One-Arm Row', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Pull-Up', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Decline Crunch', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Hanging Leg Raise', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Air Bike', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Sat: Biceps and Shoulders',
      exercises: [
        SampleProgramExercise(name: 'Dumbbell Arnold Press', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Shoulder Press', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Lateral Raise', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell One-Arm Front Raise', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Shrug', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Curl', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Bicep Curl', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Hammer Curl', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Concentration Curl', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Incline Curl', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Walking', setsJson: '[]'),
      ],
    ),
  ],
);

final noEquipmentAtHomeWorkoutProgram = SampleProgram(
  name: 'No Equipment At Home Workout',
  description:
      '3-day plan (can be done up to 5 days) using only bodyweight. Designed for limited space and circuit training.',
  goal: 'General Fitness',
  duration: '7 Days',
  days: [
    SampleProgramDay(
      name: 'Workout Day (Repeat 3-5x/week)',
      exercises: [
        SampleProgramExercise(name: 'Neck Stretch', setsJson: '[]'),
        SampleProgramExercise(name: '90/90 Hamstring Stretch', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cobra', setsJson: '[]'),
        SampleProgramExercise(name: 'Push-ups', setsJson: '[{"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Bridge', setsJson: '[]'),
        SampleProgramExercise(name: 'Prisoner Squat', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Walking Lunge', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Air Bike', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Crunch', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Plank Variations', setsJson: '[]'),
        SampleProgramExercise(name: 'Side Bridge', setsJson: '[]'),
        SampleProgramExercise(name: 'Knee to Chest', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Iron Cross Stretch', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Downward Facing Dog', setsJson: '[{"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 8, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cobra', setsJson: '[]'),
      ],
    ),
  ],
);

final jumpIntoSummerProgram = SampleProgram(
  name: 'Jump Into Summer',
  description:
      '5-day advanced cutting plan to maximize fat loss and muscle definition with high intensity and short rest periods.',
  goal: 'Cutting',
  duration: '7 Days',
  days: [
    SampleProgramDay(
      name: 'Day 1: Upper Body & Abs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bent-Over Row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Shrug', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Leg Raise', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 2: Lower Body & Abs',
      exercises: [
        SampleProgramExercise(name: 'Barbell Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Lunge', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Calf Raise', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Seated Leg Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'V-Up', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 3: Upper Body 2',
      exercises: [
        SampleProgramExercise(name: 'Barbell Incline Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Lat Pulldown (Wide Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Lateral Raise', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Bicep Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Smith Machine Shrug', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Hanging Leg Raise', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Rowing', setsJson: '[]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 4: Lower Body 2',
      exercises: [
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Hack Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Extension', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Calf Press On Leg Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Hip Abduction', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Hip Adduction', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Stability Ball Crunch', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 5: Abs & Cardio',
      exercises: [
        SampleProgramExercise(name: 'Air Bike', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Jackknife Sit-Up', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'V-Up', setsJson: '[{"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}, {"reps": 20, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Treadmill Running', setsJson: '[]'),
        SampleProgramExercise(name: 'Walking', setsJson: '[]'),
      ],
    ),
  ],
);

final sixDayBulkingSplitProgram = SampleProgram(
  name: '6 Day Bulking Split',
  description:
      'High-volume advanced routine focusing on compound movements to stimulate growth hormone. Rep ranges typically scale down.',
  goal: 'Bulking',
  duration: '7 Days',
  days: [
    SampleProgramDay(
      name: 'Day 1: Chest/Back (Focus: Power)',
      exercises: [
        SampleProgramExercise(name: 'Barbell Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Incline Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Deadlift', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bent-Over Row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Pull-Up', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Crunch', setsJson: '[{"reps": 25, "weight": 0.0}, {"reps": 25, "weight": 0.0}, {"reps": 25, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 2: Arms/Shoulders (Focus: Power)',
      exercises: [
        SampleProgramExercise(name: 'Barbell Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Shrug', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Bench Press (Close Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Wrist Curl (Posterior)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 3: Legs/Lower Back (Focus: Power)',
      exercises: [
        SampleProgramExercise(name: 'Deep Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Hack Squat', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Lunge', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Stiff-Leg Deadlift', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 8, "weight": 0.0}, {"reps": 6, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Barbell Standing Calf Raise', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Good Mornings', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 10, "weight": 0.0}, {"reps": 10, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 4: Chest/Back (Focus: Hypertrophy)',
      exercises: [
        SampleProgramExercise(name: 'Dumbbell Bench Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Fly', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Cable Lat Pulldown (Wide Grip)', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Seated Cable Row', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Shrug', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 5: Arms/Shoulders (Focus: Hypertrophy)',
      exercises: [
        SampleProgramExercise(name: 'Dumbbell Shoulder Press', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Lateral Raise', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Alternating Bicep Curl', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Dumbbell Tricep Kickback', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Hammer Curls', setsJson: '[{"reps": 12, "weight": 0.0}, {"reps": 12, "weight": 0.0}]'),
      ],
    ),
    SampleProgramDay(
      name: 'Day 6: Legs/Lower Back (Focus: Hypertrophy)',
      exercises: [
        SampleProgramExercise(name: 'Machine Leg Press', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Leg Extension', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Seated Leg Curl', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Machine Calf Raise', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
        SampleProgramExercise(name: 'Back Extension', setsJson: '[{"reps": 15, "weight": 0.0}, {"reps": 15, "weight": 0.0}]'),
      ],
    ),
  ],
);

final allSamplePrograms = [
  womenFatLossProgram,
  elitePPLProgram,
  sixWeeksToSixPackAbsProgram,
  fiveDayMuscleMassSplitProgram,
  fromFatToFitProgram,
  fullBodyHomeWorkoutDumbbellOnlyProgram,
  redditPPLProgram,
  machineOnlyBeginnerWorkoutProgram,
  beginnerRoutineProgram,
  getRippedProgram,
  advancedRoutineProgram,
  intermediateRoutineProgram,
  noEquipmentAtHomeWorkoutProgram,
  jumpIntoSummerProgram,
  sixDayBulkingSplitProgram,
];
