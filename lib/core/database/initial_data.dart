import 'package:drift/drift.dart';
import 'package:gym_gemini_pro/core/database/database.dart';

final initialExercises = [
  const ExercisesCompanion(name: Value('Barbell Bench Press'), primaryMuscle: Value('Chest'), equipment: Value('Barbell'), setType: Value('Straight'), restTime: Value(90), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Dumbbell Bench Press'), primaryMuscle: Value('Chest'), equipment: Value('Dumbbell'), setType: Value('Straight'), restTime: Value(90), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Incline Barbell Bench Press'), primaryMuscle: Value('Chest'), equipment: Value('Barbell'), setType: Value('Straight'), restTime: Value(90), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Incline Dumbbell Bench Press'), primaryMuscle: Value('Chest'), equipment: Value('Dumbbell'), setType: Value('Straight'), restTime: Value(90), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Decline Barbell Bench Press'), primaryMuscle: Value('Chest'), equipment: Value('Barbell'), setType: Value('Straight'), restTime: Value(90), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Decline Dumbbell Bench Press'), primaryMuscle: Value('Chest'), equipment: Value('Dumbbell'), setType: Value('Straight'), restTime: Value(90), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Push-ups'), primaryMuscle: Value('Chest'), equipment: Value('Bodyweight'), setType: Value('Straight'), restTime: Value(60), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Cable Crossover'), primaryMuscle: Value('Chest'), equipment: Value('Cable'), setType: Value('Straight'), restTime: Value(60), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Pec Deck Machine'), primaryMuscle: Value('Chest'), equipment: Value('Machine'), setType: Value('Straight'), restTime: Value(60), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Dumbbell Flyes'), primaryMuscle: Value('Chest'), equipment: Value('Dumbbell'), setType: Value('Straight'), restTime: Value(60), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Deadlift'), primaryMuscle: Value('Back'), equipment: Value('Barbell'), setType: Value('Straight'), restTime: Value(120), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Pull-ups'), primaryMuscle: Value('Back'), equipment: Value('Bodyweight'), setType: Value('Straight'), restTime: Value(90), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Lat Pulldown'), primaryMuscle: Value('Back'), equipment: Value('Cable'), setType: Value('Straight'), restTime: Value(90), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Barbell Row'), primaryMuscle: Value('Back'), equipment: Value('Barbell'), setType: Value('Straight'), restTime: Value(90), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Squat'), primaryMuscle: Value('Legs'), equipment: Value('Barbell'), setType: Value('Straight'), restTime: Value(120), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Leg Press'), primaryMuscle: Value('Legs'), equipment: Value('Machine'), setType: Value('Straight'), restTime: Value(120), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Overhead Press'), primaryMuscle: Value('Shoulders'), equipment: Value('Barbell'), setType: Value('Straight'), restTime: Value(90), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Lateral Raises'), primaryMuscle: Value('Shoulders'), equipment: Value('Dumbbell'), setType: Value('Straight'), restTime: Value(60), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Barbell Curl'), primaryMuscle: Value('Biceps'), equipment: Value('Barbell'), setType: Value('Straight'), restTime: Value(60), isCustom: Value(false)),
  const ExercisesCompanion(name: Value('Triceps Pushdown'), primaryMuscle: Value('Triceps'), equipment: Value('Cable'), setType: Value('Straight'), restTime: Value(60), isCustom: Value(false)),
];

class SampleProgramDay {
  final String name;
  final List<String> exerciseNames;
  SampleProgramDay({required this.name, required this.exerciseNames});
}

class SampleProgram {
  final String name;
  final String description;
  final List<SampleProgramDay> days;
  SampleProgram({required this.name, required this.description, required this.days});
}

final samplePPLProgram = SampleProgram(
  name: '3-Day Split (PPL)',
  description: 'A classic muscle-building split focusing on Push, Pull, and Leg movements.',
  days: [
    SampleProgramDay(
      name: 'Push Day (Chest, Shoulders, Triceps)',
      exerciseNames: [
        'Barbell Bench Press',
        'Overhead Press',
        'Lateral Raises',
        'Triceps Pushdown',
      ],
    ),
    SampleProgramDay(
      name: 'Pull Day (Back, Biceps)',
      exerciseNames: [
        'Deadlift',
        'Lat Pulldown',
        'Barbell Row',
        'Barbell Curl',
      ],
    ),
    SampleProgramDay(
      name: 'Leg Day',
      exerciseNames: [
        'Squat',
        'Leg Press',
      ],
    ),
  ],
);
