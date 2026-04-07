// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _primaryMuscleMeta =
      const VerificationMeta('primaryMuscle');
  @override
  late final GeneratedColumn<String> primaryMuscle = GeneratedColumn<String>(
      'primary_muscle', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _secondaryMuscleMeta =
      const VerificationMeta('secondaryMuscle');
  @override
  late final GeneratedColumn<String> secondaryMuscle = GeneratedColumn<String>(
      'secondary_muscle', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _equipmentMeta =
      const VerificationMeta('equipment');
  @override
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
      'equipment', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _setTypeMeta =
      const VerificationMeta('setType');
  @override
  late final GeneratedColumn<String> setType = GeneratedColumn<String>(
      'set_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _restTimeMeta =
      const VerificationMeta('restTime');
  @override
  late final GeneratedColumn<int> restTime = GeneratedColumn<int>(
      'rest_time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(90));
  static const VerificationMeta _instructionsMeta =
      const VerificationMeta('instructions');
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
      'instructions', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isCustomMeta =
      const VerificationMeta('isCustom');
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
      'is_custom', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_custom" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastUsedMeta =
      const VerificationMeta('lastUsed');
  @override
  late final GeneratedColumn<DateTime> lastUsed = GeneratedColumn<DateTime>(
      'last_used', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        primaryMuscle,
        secondaryMuscle,
        equipment,
        setType,
        restTime,
        instructions,
        isCustom,
        lastUsed
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(Insertable<Exercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('primary_muscle')) {
      context.handle(
          _primaryMuscleMeta,
          primaryMuscle.isAcceptableOrUnknown(
              data['primary_muscle']!, _primaryMuscleMeta));
    } else if (isInserting) {
      context.missing(_primaryMuscleMeta);
    }
    if (data.containsKey('secondary_muscle')) {
      context.handle(
          _secondaryMuscleMeta,
          secondaryMuscle.isAcceptableOrUnknown(
              data['secondary_muscle']!, _secondaryMuscleMeta));
    }
    if (data.containsKey('equipment')) {
      context.handle(_equipmentMeta,
          equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta));
    } else if (isInserting) {
      context.missing(_equipmentMeta);
    }
    if (data.containsKey('set_type')) {
      context.handle(_setTypeMeta,
          setType.isAcceptableOrUnknown(data['set_type']!, _setTypeMeta));
    } else if (isInserting) {
      context.missing(_setTypeMeta);
    }
    if (data.containsKey('rest_time')) {
      context.handle(_restTimeMeta,
          restTime.isAcceptableOrUnknown(data['rest_time']!, _restTimeMeta));
    }
    if (data.containsKey('instructions')) {
      context.handle(
          _instructionsMeta,
          instructions.isAcceptableOrUnknown(
              data['instructions']!, _instructionsMeta));
    }
    if (data.containsKey('is_custom')) {
      context.handle(_isCustomMeta,
          isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta));
    }
    if (data.containsKey('last_used')) {
      context.handle(_lastUsedMeta,
          lastUsed.isAcceptableOrUnknown(data['last_used']!, _lastUsedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      primaryMuscle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}primary_muscle'])!,
      secondaryMuscle: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}secondary_muscle']),
      equipment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}equipment'])!,
      setType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}set_type'])!,
      restTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rest_time'])!,
      instructions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instructions']),
      isCustom: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_custom'])!,
      lastUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_used']),
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final int id;
  final String name;
  final String primaryMuscle;
  final String? secondaryMuscle;
  final String equipment;
  final String setType;
  final int restTime;
  final String? instructions;
  final bool isCustom;
  final DateTime? lastUsed;
  const Exercise(
      {required this.id,
      required this.name,
      required this.primaryMuscle,
      this.secondaryMuscle,
      required this.equipment,
      required this.setType,
      required this.restTime,
      this.instructions,
      required this.isCustom,
      this.lastUsed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['primary_muscle'] = Variable<String>(primaryMuscle);
    if (!nullToAbsent || secondaryMuscle != null) {
      map['secondary_muscle'] = Variable<String>(secondaryMuscle);
    }
    map['equipment'] = Variable<String>(equipment);
    map['set_type'] = Variable<String>(setType);
    map['rest_time'] = Variable<int>(restTime);
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    map['is_custom'] = Variable<bool>(isCustom);
    if (!nullToAbsent || lastUsed != null) {
      map['last_used'] = Variable<DateTime>(lastUsed);
    }
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      primaryMuscle: Value(primaryMuscle),
      secondaryMuscle: secondaryMuscle == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryMuscle),
      equipment: Value(equipment),
      setType: Value(setType),
      restTime: Value(restTime),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
      isCustom: Value(isCustom),
      lastUsed: lastUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsed),
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      primaryMuscle: serializer.fromJson<String>(json['primaryMuscle']),
      secondaryMuscle: serializer.fromJson<String?>(json['secondaryMuscle']),
      equipment: serializer.fromJson<String>(json['equipment']),
      setType: serializer.fromJson<String>(json['setType']),
      restTime: serializer.fromJson<int>(json['restTime']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      lastUsed: serializer.fromJson<DateTime?>(json['lastUsed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'primaryMuscle': serializer.toJson<String>(primaryMuscle),
      'secondaryMuscle': serializer.toJson<String?>(secondaryMuscle),
      'equipment': serializer.toJson<String>(equipment),
      'setType': serializer.toJson<String>(setType),
      'restTime': serializer.toJson<int>(restTime),
      'instructions': serializer.toJson<String?>(instructions),
      'isCustom': serializer.toJson<bool>(isCustom),
      'lastUsed': serializer.toJson<DateTime?>(lastUsed),
    };
  }

  Exercise copyWith(
          {int? id,
          String? name,
          String? primaryMuscle,
          Value<String?> secondaryMuscle = const Value.absent(),
          String? equipment,
          String? setType,
          int? restTime,
          Value<String?> instructions = const Value.absent(),
          bool? isCustom,
          Value<DateTime?> lastUsed = const Value.absent()}) =>
      Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        primaryMuscle: primaryMuscle ?? this.primaryMuscle,
        secondaryMuscle: secondaryMuscle.present
            ? secondaryMuscle.value
            : this.secondaryMuscle,
        equipment: equipment ?? this.equipment,
        setType: setType ?? this.setType,
        restTime: restTime ?? this.restTime,
        instructions:
            instructions.present ? instructions.value : this.instructions,
        isCustom: isCustom ?? this.isCustom,
        lastUsed: lastUsed.present ? lastUsed.value : this.lastUsed,
      );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      primaryMuscle: data.primaryMuscle.present
          ? data.primaryMuscle.value
          : this.primaryMuscle,
      secondaryMuscle: data.secondaryMuscle.present
          ? data.secondaryMuscle.value
          : this.secondaryMuscle,
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
      setType: data.setType.present ? data.setType.value : this.setType,
      restTime: data.restTime.present ? data.restTime.value : this.restTime,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primaryMuscle: $primaryMuscle, ')
          ..write('secondaryMuscle: $secondaryMuscle, ')
          ..write('equipment: $equipment, ')
          ..write('setType: $setType, ')
          ..write('restTime: $restTime, ')
          ..write('instructions: $instructions, ')
          ..write('isCustom: $isCustom, ')
          ..write('lastUsed: $lastUsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, primaryMuscle, secondaryMuscle,
      equipment, setType, restTime, instructions, isCustom, lastUsed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.primaryMuscle == this.primaryMuscle &&
          other.secondaryMuscle == this.secondaryMuscle &&
          other.equipment == this.equipment &&
          other.setType == this.setType &&
          other.restTime == this.restTime &&
          other.instructions == this.instructions &&
          other.isCustom == this.isCustom &&
          other.lastUsed == this.lastUsed);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> primaryMuscle;
  final Value<String?> secondaryMuscle;
  final Value<String> equipment;
  final Value<String> setType;
  final Value<int> restTime;
  final Value<String?> instructions;
  final Value<bool> isCustom;
  final Value<DateTime?> lastUsed;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.primaryMuscle = const Value.absent(),
    this.secondaryMuscle = const Value.absent(),
    this.equipment = const Value.absent(),
    this.setType = const Value.absent(),
    this.restTime = const Value.absent(),
    this.instructions = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.lastUsed = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String primaryMuscle,
    this.secondaryMuscle = const Value.absent(),
    required String equipment,
    required String setType,
    this.restTime = const Value.absent(),
    this.instructions = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.lastUsed = const Value.absent(),
  })  : name = Value(name),
        primaryMuscle = Value(primaryMuscle),
        equipment = Value(equipment),
        setType = Value(setType);
  static Insertable<Exercise> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? primaryMuscle,
    Expression<String>? secondaryMuscle,
    Expression<String>? equipment,
    Expression<String>? setType,
    Expression<int>? restTime,
    Expression<String>? instructions,
    Expression<bool>? isCustom,
    Expression<DateTime>? lastUsed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (primaryMuscle != null) 'primary_muscle': primaryMuscle,
      if (secondaryMuscle != null) 'secondary_muscle': secondaryMuscle,
      if (equipment != null) 'equipment': equipment,
      if (setType != null) 'set_type': setType,
      if (restTime != null) 'rest_time': restTime,
      if (instructions != null) 'instructions': instructions,
      if (isCustom != null) 'is_custom': isCustom,
      if (lastUsed != null) 'last_used': lastUsed,
    });
  }

  ExercisesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? primaryMuscle,
      Value<String?>? secondaryMuscle,
      Value<String>? equipment,
      Value<String>? setType,
      Value<int>? restTime,
      Value<String?>? instructions,
      Value<bool>? isCustom,
      Value<DateTime?>? lastUsed}) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      primaryMuscle: primaryMuscle ?? this.primaryMuscle,
      secondaryMuscle: secondaryMuscle ?? this.secondaryMuscle,
      equipment: equipment ?? this.equipment,
      setType: setType ?? this.setType,
      restTime: restTime ?? this.restTime,
      instructions: instructions ?? this.instructions,
      isCustom: isCustom ?? this.isCustom,
      lastUsed: lastUsed ?? this.lastUsed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (primaryMuscle.present) {
      map['primary_muscle'] = Variable<String>(primaryMuscle.value);
    }
    if (secondaryMuscle.present) {
      map['secondary_muscle'] = Variable<String>(secondaryMuscle.value);
    }
    if (equipment.present) {
      map['equipment'] = Variable<String>(equipment.value);
    }
    if (setType.present) {
      map['set_type'] = Variable<String>(setType.value);
    }
    if (restTime.present) {
      map['rest_time'] = Variable<int>(restTime.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (lastUsed.present) {
      map['last_used'] = Variable<DateTime>(lastUsed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primaryMuscle: $primaryMuscle, ')
          ..write('secondaryMuscle: $secondaryMuscle, ')
          ..write('equipment: $equipment, ')
          ..write('setType: $setType, ')
          ..write('restTime: $restTime, ')
          ..write('instructions: $instructions, ')
          ..write('isCustom: $isCustom, ')
          ..write('lastUsed: $lastUsed')
          ..write(')'))
        .toString();
  }
}

class $WorkoutTemplatesTable extends WorkoutTemplates
    with TableInfo<$WorkoutTemplatesTable, WorkoutTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastUsedMeta =
      const VerificationMeta('lastUsed');
  @override
  late final GeneratedColumn<DateTime> lastUsed = GeneratedColumn<DateTime>(
      'last_used', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, description, lastUsed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_templates';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutTemplate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('last_used')) {
      context.handle(_lastUsedMeta,
          lastUsed.isAcceptableOrUnknown(data['last_used']!, _lastUsedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutTemplate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      lastUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_used']),
    );
  }

  @override
  $WorkoutTemplatesTable createAlias(String alias) {
    return $WorkoutTemplatesTable(attachedDatabase, alias);
  }
}

class WorkoutTemplate extends DataClass implements Insertable<WorkoutTemplate> {
  final int id;
  final String name;
  final String? description;
  final DateTime? lastUsed;
  const WorkoutTemplate(
      {required this.id, required this.name, this.description, this.lastUsed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || lastUsed != null) {
      map['last_used'] = Variable<DateTime>(lastUsed);
    }
    return map;
  }

  WorkoutTemplatesCompanion toCompanion(bool nullToAbsent) {
    return WorkoutTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      lastUsed: lastUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsed),
    );
  }

  factory WorkoutTemplate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutTemplate(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      lastUsed: serializer.fromJson<DateTime?>(json['lastUsed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'lastUsed': serializer.toJson<DateTime?>(lastUsed),
    };
  }

  WorkoutTemplate copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<DateTime?> lastUsed = const Value.absent()}) =>
      WorkoutTemplate(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        lastUsed: lastUsed.present ? lastUsed.value : this.lastUsed,
      );
  WorkoutTemplate copyWithCompanion(WorkoutTemplatesCompanion data) {
    return WorkoutTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('lastUsed: $lastUsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, lastUsed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.lastUsed == this.lastUsed);
}

class WorkoutTemplatesCompanion extends UpdateCompanion<WorkoutTemplate> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime?> lastUsed;
  const WorkoutTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.lastUsed = const Value.absent(),
  });
  WorkoutTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.lastUsed = const Value.absent(),
  }) : name = Value(name);
  static Insertable<WorkoutTemplate> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? lastUsed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (lastUsed != null) 'last_used': lastUsed,
    });
  }

  WorkoutTemplatesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime?>? lastUsed}) {
    return WorkoutTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      lastUsed: lastUsed ?? this.lastUsed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lastUsed.present) {
      map['last_used'] = Variable<DateTime>(lastUsed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('lastUsed: $lastUsed')
          ..write(')'))
        .toString();
  }
}

class $TemplateDaysTable extends TemplateDays
    with TableInfo<$TemplateDaysTable, TemplateDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplateDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES workout_templates (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, templateId, name, order];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'template_days';
  @override
  VerificationContext validateIntegrity(Insertable<TemplateDay> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemplateDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemplateDay(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
    );
  }

  @override
  $TemplateDaysTable createAlias(String alias) {
    return $TemplateDaysTable(attachedDatabase, alias);
  }
}

class TemplateDay extends DataClass implements Insertable<TemplateDay> {
  final int id;
  final int templateId;
  final String name;
  final int order;
  const TemplateDay(
      {required this.id,
      required this.templateId,
      required this.name,
      required this.order});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['template_id'] = Variable<int>(templateId);
    map['name'] = Variable<String>(name);
    map['order'] = Variable<int>(order);
    return map;
  }

  TemplateDaysCompanion toCompanion(bool nullToAbsent) {
    return TemplateDaysCompanion(
      id: Value(id),
      templateId: Value(templateId),
      name: Value(name),
      order: Value(order),
    );
  }

  factory TemplateDay.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemplateDay(
      id: serializer.fromJson<int>(json['id']),
      templateId: serializer.fromJson<int>(json['templateId']),
      name: serializer.fromJson<String>(json['name']),
      order: serializer.fromJson<int>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'templateId': serializer.toJson<int>(templateId),
      'name': serializer.toJson<String>(name),
      'order': serializer.toJson<int>(order),
    };
  }

  TemplateDay copyWith({int? id, int? templateId, String? name, int? order}) =>
      TemplateDay(
        id: id ?? this.id,
        templateId: templateId ?? this.templateId,
        name: name ?? this.name,
        order: order ?? this.order,
      );
  TemplateDay copyWithCompanion(TemplateDaysCompanion data) {
    return TemplateDay(
      id: data.id.present ? data.id.value : this.id,
      templateId:
          data.templateId.present ? data.templateId.value : this.templateId,
      name: data.name.present ? data.name.value : this.name,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemplateDay(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('name: $name, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, templateId, name, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemplateDay &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.name == this.name &&
          other.order == this.order);
}

class TemplateDaysCompanion extends UpdateCompanion<TemplateDay> {
  final Value<int> id;
  final Value<int> templateId;
  final Value<String> name;
  final Value<int> order;
  const TemplateDaysCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.name = const Value.absent(),
    this.order = const Value.absent(),
  });
  TemplateDaysCompanion.insert({
    this.id = const Value.absent(),
    required int templateId,
    required String name,
    required int order,
  })  : templateId = Value(templateId),
        name = Value(name),
        order = Value(order);
  static Insertable<TemplateDay> custom({
    Expression<int>? id,
    Expression<int>? templateId,
    Expression<String>? name,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (name != null) 'name': name,
      if (order != null) 'order': order,
    });
  }

  TemplateDaysCompanion copyWith(
      {Value<int>? id,
      Value<int>? templateId,
      Value<String>? name,
      Value<int>? order}) {
    return TemplateDaysCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      name: name ?? this.name,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplateDaysCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('name: $name, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $TemplateExercisesTable extends TemplateExercises
    with TableInfo<$TemplateExercisesTable, TemplateExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplateExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dayIdMeta = const VerificationMeta('dayId');
  @override
  late final GeneratedColumn<int> dayId = GeneratedColumn<int>(
      'day_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES template_days (id)'));
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exercises (id)'));
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<SetType, int> setType =
      GeneratedColumn<int>('set_type', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<SetType>($TemplateExercisesTable.$convertersetType);
  static const VerificationMeta _setsJsonMeta =
      const VerificationMeta('setsJson');
  @override
  late final GeneratedColumn<String> setsJson = GeneratedColumn<String>(
      'sets_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _restTimeMeta =
      const VerificationMeta('restTime');
  @override
  late final GeneratedColumn<int> restTime = GeneratedColumn<int>(
      'rest_time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(90));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _supersetGroupIdMeta =
      const VerificationMeta('supersetGroupId');
  @override
  late final GeneratedColumn<String> supersetGroupId = GeneratedColumn<String>(
      'superset_group_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        dayId,
        exerciseId,
        order,
        setType,
        setsJson,
        restTime,
        notes,
        supersetGroupId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'template_exercises';
  @override
  VerificationContext validateIntegrity(Insertable<TemplateExercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('day_id')) {
      context.handle(
          _dayIdMeta, dayId.isAcceptableOrUnknown(data['day_id']!, _dayIdMeta));
    } else if (isInserting) {
      context.missing(_dayIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('sets_json')) {
      context.handle(_setsJsonMeta,
          setsJson.isAcceptableOrUnknown(data['sets_json']!, _setsJsonMeta));
    } else if (isInserting) {
      context.missing(_setsJsonMeta);
    }
    if (data.containsKey('rest_time')) {
      context.handle(_restTimeMeta,
          restTime.isAcceptableOrUnknown(data['rest_time']!, _restTimeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('superset_group_id')) {
      context.handle(
          _supersetGroupIdMeta,
          supersetGroupId.isAcceptableOrUnknown(
              data['superset_group_id']!, _supersetGroupIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemplateExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemplateExercise(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dayId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_id'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      setType: $TemplateExercisesTable.$convertersetType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}set_type'])!),
      setsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sets_json'])!,
      restTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rest_time'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      supersetGroupId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}superset_group_id']),
    );
  }

  @override
  $TemplateExercisesTable createAlias(String alias) {
    return $TemplateExercisesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SetType, int, int> $convertersetType =
      const EnumIndexConverter<SetType>(SetType.values);
}

class TemplateExercise extends DataClass
    implements Insertable<TemplateExercise> {
  final int id;
  final int dayId;
  final int exerciseId;
  final int order;
  final SetType setType;
  final String setsJson;
  final int restTime;
  final String? notes;
  final String? supersetGroupId;
  const TemplateExercise(
      {required this.id,
      required this.dayId,
      required this.exerciseId,
      required this.order,
      required this.setType,
      required this.setsJson,
      required this.restTime,
      this.notes,
      this.supersetGroupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['day_id'] = Variable<int>(dayId);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['order'] = Variable<int>(order);
    {
      map['set_type'] = Variable<int>(
          $TemplateExercisesTable.$convertersetType.toSql(setType));
    }
    map['sets_json'] = Variable<String>(setsJson);
    map['rest_time'] = Variable<int>(restTime);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || supersetGroupId != null) {
      map['superset_group_id'] = Variable<String>(supersetGroupId);
    }
    return map;
  }

  TemplateExercisesCompanion toCompanion(bool nullToAbsent) {
    return TemplateExercisesCompanion(
      id: Value(id),
      dayId: Value(dayId),
      exerciseId: Value(exerciseId),
      order: Value(order),
      setType: Value(setType),
      setsJson: Value(setsJson),
      restTime: Value(restTime),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      supersetGroupId: supersetGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(supersetGroupId),
    );
  }

  factory TemplateExercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemplateExercise(
      id: serializer.fromJson<int>(json['id']),
      dayId: serializer.fromJson<int>(json['dayId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      order: serializer.fromJson<int>(json['order']),
      setType: $TemplateExercisesTable.$convertersetType
          .fromJson(serializer.fromJson<int>(json['setType'])),
      setsJson: serializer.fromJson<String>(json['setsJson']),
      restTime: serializer.fromJson<int>(json['restTime']),
      notes: serializer.fromJson<String?>(json['notes']),
      supersetGroupId: serializer.fromJson<String?>(json['supersetGroupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dayId': serializer.toJson<int>(dayId),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'order': serializer.toJson<int>(order),
      'setType': serializer.toJson<int>(
          $TemplateExercisesTable.$convertersetType.toJson(setType)),
      'setsJson': serializer.toJson<String>(setsJson),
      'restTime': serializer.toJson<int>(restTime),
      'notes': serializer.toJson<String?>(notes),
      'supersetGroupId': serializer.toJson<String?>(supersetGroupId),
    };
  }

  TemplateExercise copyWith(
          {int? id,
          int? dayId,
          int? exerciseId,
          int? order,
          SetType? setType,
          String? setsJson,
          int? restTime,
          Value<String?> notes = const Value.absent(),
          Value<String?> supersetGroupId = const Value.absent()}) =>
      TemplateExercise(
        id: id ?? this.id,
        dayId: dayId ?? this.dayId,
        exerciseId: exerciseId ?? this.exerciseId,
        order: order ?? this.order,
        setType: setType ?? this.setType,
        setsJson: setsJson ?? this.setsJson,
        restTime: restTime ?? this.restTime,
        notes: notes.present ? notes.value : this.notes,
        supersetGroupId: supersetGroupId.present
            ? supersetGroupId.value
            : this.supersetGroupId,
      );
  TemplateExercise copyWithCompanion(TemplateExercisesCompanion data) {
    return TemplateExercise(
      id: data.id.present ? data.id.value : this.id,
      dayId: data.dayId.present ? data.dayId.value : this.dayId,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      order: data.order.present ? data.order.value : this.order,
      setType: data.setType.present ? data.setType.value : this.setType,
      setsJson: data.setsJson.present ? data.setsJson.value : this.setsJson,
      restTime: data.restTime.present ? data.restTime.value : this.restTime,
      notes: data.notes.present ? data.notes.value : this.notes,
      supersetGroupId: data.supersetGroupId.present
          ? data.supersetGroupId.value
          : this.supersetGroupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemplateExercise(')
          ..write('id: $id, ')
          ..write('dayId: $dayId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('order: $order, ')
          ..write('setType: $setType, ')
          ..write('setsJson: $setsJson, ')
          ..write('restTime: $restTime, ')
          ..write('notes: $notes, ')
          ..write('supersetGroupId: $supersetGroupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dayId, exerciseId, order, setType,
      setsJson, restTime, notes, supersetGroupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemplateExercise &&
          other.id == this.id &&
          other.dayId == this.dayId &&
          other.exerciseId == this.exerciseId &&
          other.order == this.order &&
          other.setType == this.setType &&
          other.setsJson == this.setsJson &&
          other.restTime == this.restTime &&
          other.notes == this.notes &&
          other.supersetGroupId == this.supersetGroupId);
}

class TemplateExercisesCompanion extends UpdateCompanion<TemplateExercise> {
  final Value<int> id;
  final Value<int> dayId;
  final Value<int> exerciseId;
  final Value<int> order;
  final Value<SetType> setType;
  final Value<String> setsJson;
  final Value<int> restTime;
  final Value<String?> notes;
  final Value<String?> supersetGroupId;
  const TemplateExercisesCompanion({
    this.id = const Value.absent(),
    this.dayId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.order = const Value.absent(),
    this.setType = const Value.absent(),
    this.setsJson = const Value.absent(),
    this.restTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.supersetGroupId = const Value.absent(),
  });
  TemplateExercisesCompanion.insert({
    this.id = const Value.absent(),
    required int dayId,
    required int exerciseId,
    required int order,
    this.setType = const Value.absent(),
    required String setsJson,
    this.restTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.supersetGroupId = const Value.absent(),
  })  : dayId = Value(dayId),
        exerciseId = Value(exerciseId),
        order = Value(order),
        setsJson = Value(setsJson);
  static Insertable<TemplateExercise> custom({
    Expression<int>? id,
    Expression<int>? dayId,
    Expression<int>? exerciseId,
    Expression<int>? order,
    Expression<int>? setType,
    Expression<String>? setsJson,
    Expression<int>? restTime,
    Expression<String>? notes,
    Expression<String>? supersetGroupId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dayId != null) 'day_id': dayId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (order != null) 'order': order,
      if (setType != null) 'set_type': setType,
      if (setsJson != null) 'sets_json': setsJson,
      if (restTime != null) 'rest_time': restTime,
      if (notes != null) 'notes': notes,
      if (supersetGroupId != null) 'superset_group_id': supersetGroupId,
    });
  }

  TemplateExercisesCompanion copyWith(
      {Value<int>? id,
      Value<int>? dayId,
      Value<int>? exerciseId,
      Value<int>? order,
      Value<SetType>? setType,
      Value<String>? setsJson,
      Value<int>? restTime,
      Value<String?>? notes,
      Value<String?>? supersetGroupId}) {
    return TemplateExercisesCompanion(
      id: id ?? this.id,
      dayId: dayId ?? this.dayId,
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
      setType: setType ?? this.setType,
      setsJson: setsJson ?? this.setsJson,
      restTime: restTime ?? this.restTime,
      notes: notes ?? this.notes,
      supersetGroupId: supersetGroupId ?? this.supersetGroupId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dayId.present) {
      map['day_id'] = Variable<int>(dayId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (setType.present) {
      map['set_type'] = Variable<int>(
          $TemplateExercisesTable.$convertersetType.toSql(setType.value));
    }
    if (setsJson.present) {
      map['sets_json'] = Variable<String>(setsJson.value);
    }
    if (restTime.present) {
      map['rest_time'] = Variable<int>(restTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (supersetGroupId.present) {
      map['superset_group_id'] = Variable<String>(supersetGroupId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplateExercisesCompanion(')
          ..write('id: $id, ')
          ..write('dayId: $dayId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('order: $order, ')
          ..write('setType: $setType, ')
          ..write('setsJson: $setsJson, ')
          ..write('restTime: $restTime, ')
          ..write('notes: $notes, ')
          ..write('supersetGroupId: $supersetGroupId')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES workout_templates (id)'));
  static const VerificationMeta _dayIdMeta = const VerificationMeta('dayId');
  @override
  late final GeneratedColumn<int> dayId = GeneratedColumn<int>(
      'day_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES template_days (id)'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('draft'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        date,
        startTime,
        endTime,
        duration,
        templateId,
        dayId,
        notes,
        status
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(Insertable<Workout> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    }
    if (data.containsKey('day_id')) {
      context.handle(
          _dayIdMeta, dayId.isAcceptableOrUnknown(data['day_id']!, _dayIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workout(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time']),
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration']),
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id']),
      dayId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_id']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }
}

class Workout extends DataClass implements Insertable<Workout> {
  final int id;
  final String name;
  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? duration;
  final int? templateId;
  final int? dayId;
  final String? notes;
  final String status;
  const Workout(
      {required this.id,
      required this.name,
      required this.date,
      this.startTime,
      this.endTime,
      this.duration,
      this.templateId,
      this.dayId,
      this.notes,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<int>(templateId);
    }
    if (!nullToAbsent || dayId != null) {
      map['day_id'] = Variable<int>(dayId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: Value(id),
      name: Value(name),
      date: Value(date),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      dayId:
          dayId == null && nullToAbsent ? const Value.absent() : Value(dayId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      status: Value(status),
    );
  }

  factory Workout.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workout(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      date: serializer.fromJson<DateTime>(json['date']),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      duration: serializer.fromJson<int?>(json['duration']),
      templateId: serializer.fromJson<int?>(json['templateId']),
      dayId: serializer.fromJson<int?>(json['dayId']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'date': serializer.toJson<DateTime>(date),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'duration': serializer.toJson<int?>(duration),
      'templateId': serializer.toJson<int?>(templateId),
      'dayId': serializer.toJson<int?>(dayId),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
    };
  }

  Workout copyWith(
          {int? id,
          String? name,
          DateTime? date,
          Value<DateTime?> startTime = const Value.absent(),
          Value<DateTime?> endTime = const Value.absent(),
          Value<int?> duration = const Value.absent(),
          Value<int?> templateId = const Value.absent(),
          Value<int?> dayId = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          String? status}) =>
      Workout(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        startTime: startTime.present ? startTime.value : this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        duration: duration.present ? duration.value : this.duration,
        templateId: templateId.present ? templateId.value : this.templateId,
        dayId: dayId.present ? dayId.value : this.dayId,
        notes: notes.present ? notes.value : this.notes,
        status: status ?? this.status,
      );
  Workout copyWithCompanion(WorkoutsCompanion data) {
    return Workout(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      date: data.date.present ? data.date.value : this.date,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      duration: data.duration.present ? data.duration.value : this.duration,
      templateId:
          data.templateId.present ? data.templateId.value : this.templateId,
      dayId: data.dayId.present ? data.dayId.value : this.dayId,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Workout(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('duration: $duration, ')
          ..write('templateId: $templateId, ')
          ..write('dayId: $dayId, ')
          ..write('notes: $notes, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, date, startTime, endTime, duration,
      templateId, dayId, notes, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workout &&
          other.id == this.id &&
          other.name == this.name &&
          other.date == this.date &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.duration == this.duration &&
          other.templateId == this.templateId &&
          other.dayId == this.dayId &&
          other.notes == this.notes &&
          other.status == this.status);
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> date;
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  final Value<int?> duration;
  final Value<int?> templateId;
  final Value<int?> dayId;
  final Value<String?> notes;
  final Value<String> status;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.duration = const Value.absent(),
    this.templateId = const Value.absent(),
    this.dayId = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime date,
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.duration = const Value.absent(),
    this.templateId = const Value.absent(),
    this.dayId = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
  })  : name = Value(name),
        date = Value(date);
  static Insertable<Workout> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? date,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? duration,
    Expression<int>? templateId,
    Expression<int>? dayId,
    Expression<String>? notes,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (duration != null) 'duration': duration,
      if (templateId != null) 'template_id': templateId,
      if (dayId != null) 'day_id': dayId,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
    });
  }

  WorkoutsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime>? date,
      Value<DateTime?>? startTime,
      Value<DateTime?>? endTime,
      Value<int?>? duration,
      Value<int?>? templateId,
      Value<int?>? dayId,
      Value<String?>? notes,
      Value<String>? status}) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      templateId: templateId ?? this.templateId,
      dayId: dayId ?? this.dayId,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (dayId.present) {
      map['day_id'] = Variable<int>(dayId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('duration: $duration, ')
          ..write('templateId: $templateId, ')
          ..write('dayId: $dayId, ')
          ..write('notes: $notes, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSetsTable extends WorkoutSets
    with TableInfo<$WorkoutSetsTable, WorkoutSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workoutIdMeta =
      const VerificationMeta('workoutId');
  @override
  late final GeneratedColumn<int> workoutId = GeneratedColumn<int>(
      'workout_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES workouts (id)'));
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exercises (id)'));
  static const VerificationMeta _exerciseOrderMeta =
      const VerificationMeta('exerciseOrder');
  @override
  late final GeneratedColumn<int> exerciseOrder = GeneratedColumn<int>(
      'exercise_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _setNumberMeta =
      const VerificationMeta('setNumber');
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
      'set_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<double> reps = GeneratedColumn<double>(
      'reps', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<double> rpe = GeneratedColumn<double>(
      'rpe', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<SetType, int> setType =
      GeneratedColumn<int>('set_type', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<SetType>($WorkoutSetsTable.$convertersetType);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isPrMeta = const VerificationMeta('isPr');
  @override
  late final GeneratedColumn<bool> isPr = GeneratedColumn<bool>(
      'is_pr', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pr" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _supersetGroupIdMeta =
      const VerificationMeta('supersetGroupId');
  @override
  late final GeneratedColumn<String> supersetGroupId = GeneratedColumn<String>(
      'superset_group_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subSetsJsonMeta =
      const VerificationMeta('subSetsJson');
  @override
  late final GeneratedColumn<String> subSetsJson = GeneratedColumn<String>(
      'sub_sets_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workoutId,
        exerciseId,
        exerciseOrder,
        setNumber,
        reps,
        weight,
        rpe,
        setType,
        notes,
        completed,
        completedAt,
        isPr,
        supersetGroupId,
        subSetsJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sets';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutSet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('workout_id')) {
      context.handle(_workoutIdMeta,
          workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta));
    } else if (isInserting) {
      context.missing(_workoutIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('exercise_order')) {
      context.handle(
          _exerciseOrderMeta,
          exerciseOrder.isAcceptableOrUnknown(
              data['exercise_order']!, _exerciseOrderMeta));
    } else if (isInserting) {
      context.missing(_exerciseOrderMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(_setNumberMeta,
          setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta));
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('rpe')) {
      context.handle(
          _rpeMeta, rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('is_pr')) {
      context.handle(
          _isPrMeta, isPr.isAcceptableOrUnknown(data['is_pr']!, _isPrMeta));
    }
    if (data.containsKey('superset_group_id')) {
      context.handle(
          _supersetGroupIdMeta,
          supersetGroupId.isAcceptableOrUnknown(
              data['superset_group_id']!, _supersetGroupIdMeta));
    }
    if (data.containsKey('sub_sets_json')) {
      context.handle(
          _subSetsJsonMeta,
          subSetsJson.isAcceptableOrUnknown(
              data['sub_sets_json']!, _subSetsJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workoutId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}workout_id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_id'])!,
      exerciseOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_order'])!,
      setNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_number'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}reps'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      rpe: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rpe']),
      setType: $WorkoutSetsTable.$convertersetType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_type'])!),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      isPr: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pr'])!,
      supersetGroupId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}superset_group_id']),
      subSetsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sub_sets_json']),
    );
  }

  @override
  $WorkoutSetsTable createAlias(String alias) {
    return $WorkoutSetsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SetType, int, int> $convertersetType =
      const EnumIndexConverter<SetType>(SetType.values);
}

class WorkoutSet extends DataClass implements Insertable<WorkoutSet> {
  final int id;
  final int workoutId;
  final int exerciseId;
  final int exerciseOrder;
  final int setNumber;
  final double reps;
  final double weight;
  final double? rpe;
  final SetType setType;
  final String? notes;
  final bool completed;
  final DateTime? completedAt;
  final bool isPr;
  final String? supersetGroupId;
  final String? subSetsJson;
  const WorkoutSet(
      {required this.id,
      required this.workoutId,
      required this.exerciseId,
      required this.exerciseOrder,
      required this.setNumber,
      required this.reps,
      required this.weight,
      this.rpe,
      required this.setType,
      this.notes,
      required this.completed,
      this.completedAt,
      required this.isPr,
      this.supersetGroupId,
      this.subSetsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['workout_id'] = Variable<int>(workoutId);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['exercise_order'] = Variable<int>(exerciseOrder);
    map['set_number'] = Variable<int>(setNumber);
    map['reps'] = Variable<double>(reps);
    map['weight'] = Variable<double>(weight);
    if (!nullToAbsent || rpe != null) {
      map['rpe'] = Variable<double>(rpe);
    }
    {
      map['set_type'] =
          Variable<int>($WorkoutSetsTable.$convertersetType.toSql(setType));
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['is_pr'] = Variable<bool>(isPr);
    if (!nullToAbsent || supersetGroupId != null) {
      map['superset_group_id'] = Variable<String>(supersetGroupId);
    }
    if (!nullToAbsent || subSetsJson != null) {
      map['sub_sets_json'] = Variable<String>(subSetsJson);
    }
    return map;
  }

  WorkoutSetsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSetsCompanion(
      id: Value(id),
      workoutId: Value(workoutId),
      exerciseId: Value(exerciseId),
      exerciseOrder: Value(exerciseOrder),
      setNumber: Value(setNumber),
      reps: Value(reps),
      weight: Value(weight),
      rpe: rpe == null && nullToAbsent ? const Value.absent() : Value(rpe),
      setType: Value(setType),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      completed: Value(completed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      isPr: Value(isPr),
      supersetGroupId: supersetGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(supersetGroupId),
      subSetsJson: subSetsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(subSetsJson),
    );
  }

  factory WorkoutSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSet(
      id: serializer.fromJson<int>(json['id']),
      workoutId: serializer.fromJson<int>(json['workoutId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      exerciseOrder: serializer.fromJson<int>(json['exerciseOrder']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      reps: serializer.fromJson<double>(json['reps']),
      weight: serializer.fromJson<double>(json['weight']),
      rpe: serializer.fromJson<double?>(json['rpe']),
      setType: $WorkoutSetsTable.$convertersetType
          .fromJson(serializer.fromJson<int>(json['setType'])),
      notes: serializer.fromJson<String?>(json['notes']),
      completed: serializer.fromJson<bool>(json['completed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      isPr: serializer.fromJson<bool>(json['isPr']),
      supersetGroupId: serializer.fromJson<String?>(json['supersetGroupId']),
      subSetsJson: serializer.fromJson<String?>(json['subSetsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workoutId': serializer.toJson<int>(workoutId),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'exerciseOrder': serializer.toJson<int>(exerciseOrder),
      'setNumber': serializer.toJson<int>(setNumber),
      'reps': serializer.toJson<double>(reps),
      'weight': serializer.toJson<double>(weight),
      'rpe': serializer.toJson<double?>(rpe),
      'setType': serializer
          .toJson<int>($WorkoutSetsTable.$convertersetType.toJson(setType)),
      'notes': serializer.toJson<String?>(notes),
      'completed': serializer.toJson<bool>(completed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'isPr': serializer.toJson<bool>(isPr),
      'supersetGroupId': serializer.toJson<String?>(supersetGroupId),
      'subSetsJson': serializer.toJson<String?>(subSetsJson),
    };
  }

  WorkoutSet copyWith(
          {int? id,
          int? workoutId,
          int? exerciseId,
          int? exerciseOrder,
          int? setNumber,
          double? reps,
          double? weight,
          Value<double?> rpe = const Value.absent(),
          SetType? setType,
          Value<String?> notes = const Value.absent(),
          bool? completed,
          Value<DateTime?> completedAt = const Value.absent(),
          bool? isPr,
          Value<String?> supersetGroupId = const Value.absent(),
          Value<String?> subSetsJson = const Value.absent()}) =>
      WorkoutSet(
        id: id ?? this.id,
        workoutId: workoutId ?? this.workoutId,
        exerciseId: exerciseId ?? this.exerciseId,
        exerciseOrder: exerciseOrder ?? this.exerciseOrder,
        setNumber: setNumber ?? this.setNumber,
        reps: reps ?? this.reps,
        weight: weight ?? this.weight,
        rpe: rpe.present ? rpe.value : this.rpe,
        setType: setType ?? this.setType,
        notes: notes.present ? notes.value : this.notes,
        completed: completed ?? this.completed,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        isPr: isPr ?? this.isPr,
        supersetGroupId: supersetGroupId.present
            ? supersetGroupId.value
            : this.supersetGroupId,
        subSetsJson: subSetsJson.present ? subSetsJson.value : this.subSetsJson,
      );
  WorkoutSet copyWithCompanion(WorkoutSetsCompanion data) {
    return WorkoutSet(
      id: data.id.present ? data.id.value : this.id,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      exerciseOrder: data.exerciseOrder.present
          ? data.exerciseOrder.value
          : this.exerciseOrder,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      reps: data.reps.present ? data.reps.value : this.reps,
      weight: data.weight.present ? data.weight.value : this.weight,
      rpe: data.rpe.present ? data.rpe.value : this.rpe,
      setType: data.setType.present ? data.setType.value : this.setType,
      notes: data.notes.present ? data.notes.value : this.notes,
      completed: data.completed.present ? data.completed.value : this.completed,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      isPr: data.isPr.present ? data.isPr.value : this.isPr,
      supersetGroupId: data.supersetGroupId.present
          ? data.supersetGroupId.value
          : this.supersetGroupId,
      subSetsJson:
          data.subSetsJson.present ? data.subSetsJson.value : this.subSetsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSet(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('exerciseOrder: $exerciseOrder, ')
          ..write('setNumber: $setNumber, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
          ..write('rpe: $rpe, ')
          ..write('setType: $setType, ')
          ..write('notes: $notes, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('isPr: $isPr, ')
          ..write('supersetGroupId: $supersetGroupId, ')
          ..write('subSetsJson: $subSetsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      workoutId,
      exerciseId,
      exerciseOrder,
      setNumber,
      reps,
      weight,
      rpe,
      setType,
      notes,
      completed,
      completedAt,
      isPr,
      supersetGroupId,
      subSetsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSet &&
          other.id == this.id &&
          other.workoutId == this.workoutId &&
          other.exerciseId == this.exerciseId &&
          other.exerciseOrder == this.exerciseOrder &&
          other.setNumber == this.setNumber &&
          other.reps == this.reps &&
          other.weight == this.weight &&
          other.rpe == this.rpe &&
          other.setType == this.setType &&
          other.notes == this.notes &&
          other.completed == this.completed &&
          other.completedAt == this.completedAt &&
          other.isPr == this.isPr &&
          other.supersetGroupId == this.supersetGroupId &&
          other.subSetsJson == this.subSetsJson);
}

class WorkoutSetsCompanion extends UpdateCompanion<WorkoutSet> {
  final Value<int> id;
  final Value<int> workoutId;
  final Value<int> exerciseId;
  final Value<int> exerciseOrder;
  final Value<int> setNumber;
  final Value<double> reps;
  final Value<double> weight;
  final Value<double?> rpe;
  final Value<SetType> setType;
  final Value<String?> notes;
  final Value<bool> completed;
  final Value<DateTime?> completedAt;
  final Value<bool> isPr;
  final Value<String?> supersetGroupId;
  final Value<String?> subSetsJson;
  const WorkoutSetsCompanion({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.exerciseOrder = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.reps = const Value.absent(),
    this.weight = const Value.absent(),
    this.rpe = const Value.absent(),
    this.setType = const Value.absent(),
    this.notes = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isPr = const Value.absent(),
    this.supersetGroupId = const Value.absent(),
    this.subSetsJson = const Value.absent(),
  });
  WorkoutSetsCompanion.insert({
    this.id = const Value.absent(),
    required int workoutId,
    required int exerciseId,
    required int exerciseOrder,
    required int setNumber,
    required double reps,
    required double weight,
    this.rpe = const Value.absent(),
    this.setType = const Value.absent(),
    this.notes = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isPr = const Value.absent(),
    this.supersetGroupId = const Value.absent(),
    this.subSetsJson = const Value.absent(),
  })  : workoutId = Value(workoutId),
        exerciseId = Value(exerciseId),
        exerciseOrder = Value(exerciseOrder),
        setNumber = Value(setNumber),
        reps = Value(reps),
        weight = Value(weight);
  static Insertable<WorkoutSet> custom({
    Expression<int>? id,
    Expression<int>? workoutId,
    Expression<int>? exerciseId,
    Expression<int>? exerciseOrder,
    Expression<int>? setNumber,
    Expression<double>? reps,
    Expression<double>? weight,
    Expression<double>? rpe,
    Expression<int>? setType,
    Expression<String>? notes,
    Expression<bool>? completed,
    Expression<DateTime>? completedAt,
    Expression<bool>? isPr,
    Expression<String>? supersetGroupId,
    Expression<String>? subSetsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutId != null) 'workout_id': workoutId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (exerciseOrder != null) 'exercise_order': exerciseOrder,
      if (setNumber != null) 'set_number': setNumber,
      if (reps != null) 'reps': reps,
      if (weight != null) 'weight': weight,
      if (rpe != null) 'rpe': rpe,
      if (setType != null) 'set_type': setType,
      if (notes != null) 'notes': notes,
      if (completed != null) 'completed': completed,
      if (completedAt != null) 'completed_at': completedAt,
      if (isPr != null) 'is_pr': isPr,
      if (supersetGroupId != null) 'superset_group_id': supersetGroupId,
      if (subSetsJson != null) 'sub_sets_json': subSetsJson,
    });
  }

  WorkoutSetsCompanion copyWith(
      {Value<int>? id,
      Value<int>? workoutId,
      Value<int>? exerciseId,
      Value<int>? exerciseOrder,
      Value<int>? setNumber,
      Value<double>? reps,
      Value<double>? weight,
      Value<double?>? rpe,
      Value<SetType>? setType,
      Value<String?>? notes,
      Value<bool>? completed,
      Value<DateTime?>? completedAt,
      Value<bool>? isPr,
      Value<String?>? supersetGroupId,
      Value<String?>? subSetsJson}) {
    return WorkoutSetsCompanion(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseOrder: exerciseOrder ?? this.exerciseOrder,
      setNumber: setNumber ?? this.setNumber,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      rpe: rpe ?? this.rpe,
      setType: setType ?? this.setType,
      notes: notes ?? this.notes,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
      isPr: isPr ?? this.isPr,
      supersetGroupId: supersetGroupId ?? this.supersetGroupId,
      subSetsJson: subSetsJson ?? this.subSetsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<int>(workoutId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (exerciseOrder.present) {
      map['exercise_order'] = Variable<int>(exerciseOrder.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (reps.present) {
      map['reps'] = Variable<double>(reps.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (rpe.present) {
      map['rpe'] = Variable<double>(rpe.value);
    }
    if (setType.present) {
      map['set_type'] = Variable<int>(
          $WorkoutSetsTable.$convertersetType.toSql(setType.value));
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (isPr.present) {
      map['is_pr'] = Variable<bool>(isPr.value);
    }
    if (supersetGroupId.present) {
      map['superset_group_id'] = Variable<String>(supersetGroupId.value);
    }
    if (subSetsJson.present) {
      map['sub_sets_json'] = Variable<String>(subSetsJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSetsCompanion(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('exerciseOrder: $exerciseOrder, ')
          ..write('setNumber: $setNumber, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
          ..write('rpe: $rpe, ')
          ..write('setType: $setType, ')
          ..write('notes: $notes, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('isPr: $isPr, ')
          ..write('supersetGroupId: $supersetGroupId, ')
          ..write('subSetsJson: $subSetsJson')
          ..write(')'))
        .toString();
  }
}

class $BodyMeasurementsTable extends BodyMeasurements
    with TableInfo<$BodyMeasurementsTable, BodyMeasurement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyMeasurementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _chestMeta = const VerificationMeta('chest');
  @override
  late final GeneratedColumn<double> chest = GeneratedColumn<double>(
      'chest', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _waistMeta = const VerificationMeta('waist');
  @override
  late final GeneratedColumn<double> waist = GeneratedColumn<double>(
      'waist', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _hipsMeta = const VerificationMeta('hips');
  @override
  late final GeneratedColumn<double> hips = GeneratedColumn<double>(
      'hips', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _leftArmMeta =
      const VerificationMeta('leftArm');
  @override
  late final GeneratedColumn<double> leftArm = GeneratedColumn<double>(
      'left_arm', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _rightArmMeta =
      const VerificationMeta('rightArm');
  @override
  late final GeneratedColumn<double> rightArm = GeneratedColumn<double>(
      'right_arm', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _leftThighMeta =
      const VerificationMeta('leftThigh');
  @override
  late final GeneratedColumn<double> leftThigh = GeneratedColumn<double>(
      'left_thigh', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _rightThighMeta =
      const VerificationMeta('rightThigh');
  @override
  late final GeneratedColumn<double> rightThigh = GeneratedColumn<double>(
      'right_thigh', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _calvesMeta = const VerificationMeta('calves');
  @override
  late final GeneratedColumn<double> calves = GeneratedColumn<double>(
      'calves', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _bodyFatMeta =
      const VerificationMeta('bodyFat');
  @override
  late final GeneratedColumn<double> bodyFat = GeneratedColumn<double>(
      'body_fat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        weight,
        chest,
        waist,
        hips,
        leftArm,
        rightArm,
        leftThigh,
        rightThigh,
        calves,
        bodyFat
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_measurements';
  @override
  VerificationContext validateIntegrity(Insertable<BodyMeasurement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('chest')) {
      context.handle(
          _chestMeta, chest.isAcceptableOrUnknown(data['chest']!, _chestMeta));
    }
    if (data.containsKey('waist')) {
      context.handle(
          _waistMeta, waist.isAcceptableOrUnknown(data['waist']!, _waistMeta));
    }
    if (data.containsKey('hips')) {
      context.handle(
          _hipsMeta, hips.isAcceptableOrUnknown(data['hips']!, _hipsMeta));
    }
    if (data.containsKey('left_arm')) {
      context.handle(_leftArmMeta,
          leftArm.isAcceptableOrUnknown(data['left_arm']!, _leftArmMeta));
    }
    if (data.containsKey('right_arm')) {
      context.handle(_rightArmMeta,
          rightArm.isAcceptableOrUnknown(data['right_arm']!, _rightArmMeta));
    }
    if (data.containsKey('left_thigh')) {
      context.handle(_leftThighMeta,
          leftThigh.isAcceptableOrUnknown(data['left_thigh']!, _leftThighMeta));
    }
    if (data.containsKey('right_thigh')) {
      context.handle(
          _rightThighMeta,
          rightThigh.isAcceptableOrUnknown(
              data['right_thigh']!, _rightThighMeta));
    }
    if (data.containsKey('calves')) {
      context.handle(_calvesMeta,
          calves.isAcceptableOrUnknown(data['calves']!, _calvesMeta));
    }
    if (data.containsKey('body_fat')) {
      context.handle(_bodyFatMeta,
          bodyFat.isAcceptableOrUnknown(data['body_fat']!, _bodyFatMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BodyMeasurement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyMeasurement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      chest: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}chest']),
      waist: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}waist']),
      hips: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hips']),
      leftArm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}left_arm']),
      rightArm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}right_arm']),
      leftThigh: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}left_thigh']),
      rightThigh: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}right_thigh']),
      calves: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calves']),
      bodyFat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}body_fat']),
    );
  }

  @override
  $BodyMeasurementsTable createAlias(String alias) {
    return $BodyMeasurementsTable(attachedDatabase, alias);
  }
}

class BodyMeasurement extends DataClass implements Insertable<BodyMeasurement> {
  final int id;
  final DateTime date;
  final double? weight;
  final double? chest;
  final double? waist;
  final double? hips;
  final double? leftArm;
  final double? rightArm;
  final double? leftThigh;
  final double? rightThigh;
  final double? calves;
  final double? bodyFat;
  const BodyMeasurement(
      {required this.id,
      required this.date,
      this.weight,
      this.chest,
      this.waist,
      this.hips,
      this.leftArm,
      this.rightArm,
      this.leftThigh,
      this.rightThigh,
      this.calves,
      this.bodyFat});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || chest != null) {
      map['chest'] = Variable<double>(chest);
    }
    if (!nullToAbsent || waist != null) {
      map['waist'] = Variable<double>(waist);
    }
    if (!nullToAbsent || hips != null) {
      map['hips'] = Variable<double>(hips);
    }
    if (!nullToAbsent || leftArm != null) {
      map['left_arm'] = Variable<double>(leftArm);
    }
    if (!nullToAbsent || rightArm != null) {
      map['right_arm'] = Variable<double>(rightArm);
    }
    if (!nullToAbsent || leftThigh != null) {
      map['left_thigh'] = Variable<double>(leftThigh);
    }
    if (!nullToAbsent || rightThigh != null) {
      map['right_thigh'] = Variable<double>(rightThigh);
    }
    if (!nullToAbsent || calves != null) {
      map['calves'] = Variable<double>(calves);
    }
    if (!nullToAbsent || bodyFat != null) {
      map['body_fat'] = Variable<double>(bodyFat);
    }
    return map;
  }

  BodyMeasurementsCompanion toCompanion(bool nullToAbsent) {
    return BodyMeasurementsCompanion(
      id: Value(id),
      date: Value(date),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      chest:
          chest == null && nullToAbsent ? const Value.absent() : Value(chest),
      waist:
          waist == null && nullToAbsent ? const Value.absent() : Value(waist),
      hips: hips == null && nullToAbsent ? const Value.absent() : Value(hips),
      leftArm: leftArm == null && nullToAbsent
          ? const Value.absent()
          : Value(leftArm),
      rightArm: rightArm == null && nullToAbsent
          ? const Value.absent()
          : Value(rightArm),
      leftThigh: leftThigh == null && nullToAbsent
          ? const Value.absent()
          : Value(leftThigh),
      rightThigh: rightThigh == null && nullToAbsent
          ? const Value.absent()
          : Value(rightThigh),
      calves:
          calves == null && nullToAbsent ? const Value.absent() : Value(calves),
      bodyFat: bodyFat == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFat),
    );
  }

  factory BodyMeasurement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyMeasurement(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double?>(json['weight']),
      chest: serializer.fromJson<double?>(json['chest']),
      waist: serializer.fromJson<double?>(json['waist']),
      hips: serializer.fromJson<double?>(json['hips']),
      leftArm: serializer.fromJson<double?>(json['leftArm']),
      rightArm: serializer.fromJson<double?>(json['rightArm']),
      leftThigh: serializer.fromJson<double?>(json['leftThigh']),
      rightThigh: serializer.fromJson<double?>(json['rightThigh']),
      calves: serializer.fromJson<double?>(json['calves']),
      bodyFat: serializer.fromJson<double?>(json['bodyFat']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double?>(weight),
      'chest': serializer.toJson<double?>(chest),
      'waist': serializer.toJson<double?>(waist),
      'hips': serializer.toJson<double?>(hips),
      'leftArm': serializer.toJson<double?>(leftArm),
      'rightArm': serializer.toJson<double?>(rightArm),
      'leftThigh': serializer.toJson<double?>(leftThigh),
      'rightThigh': serializer.toJson<double?>(rightThigh),
      'calves': serializer.toJson<double?>(calves),
      'bodyFat': serializer.toJson<double?>(bodyFat),
    };
  }

  BodyMeasurement copyWith(
          {int? id,
          DateTime? date,
          Value<double?> weight = const Value.absent(),
          Value<double?> chest = const Value.absent(),
          Value<double?> waist = const Value.absent(),
          Value<double?> hips = const Value.absent(),
          Value<double?> leftArm = const Value.absent(),
          Value<double?> rightArm = const Value.absent(),
          Value<double?> leftThigh = const Value.absent(),
          Value<double?> rightThigh = const Value.absent(),
          Value<double?> calves = const Value.absent(),
          Value<double?> bodyFat = const Value.absent()}) =>
      BodyMeasurement(
        id: id ?? this.id,
        date: date ?? this.date,
        weight: weight.present ? weight.value : this.weight,
        chest: chest.present ? chest.value : this.chest,
        waist: waist.present ? waist.value : this.waist,
        hips: hips.present ? hips.value : this.hips,
        leftArm: leftArm.present ? leftArm.value : this.leftArm,
        rightArm: rightArm.present ? rightArm.value : this.rightArm,
        leftThigh: leftThigh.present ? leftThigh.value : this.leftThigh,
        rightThigh: rightThigh.present ? rightThigh.value : this.rightThigh,
        calves: calves.present ? calves.value : this.calves,
        bodyFat: bodyFat.present ? bodyFat.value : this.bodyFat,
      );
  BodyMeasurement copyWithCompanion(BodyMeasurementsCompanion data) {
    return BodyMeasurement(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
      chest: data.chest.present ? data.chest.value : this.chest,
      waist: data.waist.present ? data.waist.value : this.waist,
      hips: data.hips.present ? data.hips.value : this.hips,
      leftArm: data.leftArm.present ? data.leftArm.value : this.leftArm,
      rightArm: data.rightArm.present ? data.rightArm.value : this.rightArm,
      leftThigh: data.leftThigh.present ? data.leftThigh.value : this.leftThigh,
      rightThigh:
          data.rightThigh.present ? data.rightThigh.value : this.rightThigh,
      calves: data.calves.present ? data.calves.value : this.calves,
      bodyFat: data.bodyFat.present ? data.bodyFat.value : this.bodyFat,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyMeasurement(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('chest: $chest, ')
          ..write('waist: $waist, ')
          ..write('hips: $hips, ')
          ..write('leftArm: $leftArm, ')
          ..write('rightArm: $rightArm, ')
          ..write('leftThigh: $leftThigh, ')
          ..write('rightThigh: $rightThigh, ')
          ..write('calves: $calves, ')
          ..write('bodyFat: $bodyFat')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, weight, chest, waist, hips, leftArm,
      rightArm, leftThigh, rightThigh, calves, bodyFat);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyMeasurement &&
          other.id == this.id &&
          other.date == this.date &&
          other.weight == this.weight &&
          other.chest == this.chest &&
          other.waist == this.waist &&
          other.hips == this.hips &&
          other.leftArm == this.leftArm &&
          other.rightArm == this.rightArm &&
          other.leftThigh == this.leftThigh &&
          other.rightThigh == this.rightThigh &&
          other.calves == this.calves &&
          other.bodyFat == this.bodyFat);
}

class BodyMeasurementsCompanion extends UpdateCompanion<BodyMeasurement> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<double?> weight;
  final Value<double?> chest;
  final Value<double?> waist;
  final Value<double?> hips;
  final Value<double?> leftArm;
  final Value<double?> rightArm;
  final Value<double?> leftThigh;
  final Value<double?> rightThigh;
  final Value<double?> calves;
  final Value<double?> bodyFat;
  const BodyMeasurementsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.chest = const Value.absent(),
    this.waist = const Value.absent(),
    this.hips = const Value.absent(),
    this.leftArm = const Value.absent(),
    this.rightArm = const Value.absent(),
    this.leftThigh = const Value.absent(),
    this.rightThigh = const Value.absent(),
    this.calves = const Value.absent(),
    this.bodyFat = const Value.absent(),
  });
  BodyMeasurementsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.weight = const Value.absent(),
    this.chest = const Value.absent(),
    this.waist = const Value.absent(),
    this.hips = const Value.absent(),
    this.leftArm = const Value.absent(),
    this.rightArm = const Value.absent(),
    this.leftThigh = const Value.absent(),
    this.rightThigh = const Value.absent(),
    this.calves = const Value.absent(),
    this.bodyFat = const Value.absent(),
  }) : date = Value(date);
  static Insertable<BodyMeasurement> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<double>? weight,
    Expression<double>? chest,
    Expression<double>? waist,
    Expression<double>? hips,
    Expression<double>? leftArm,
    Expression<double>? rightArm,
    Expression<double>? leftThigh,
    Expression<double>? rightThigh,
    Expression<double>? calves,
    Expression<double>? bodyFat,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
      if (chest != null) 'chest': chest,
      if (waist != null) 'waist': waist,
      if (hips != null) 'hips': hips,
      if (leftArm != null) 'left_arm': leftArm,
      if (rightArm != null) 'right_arm': rightArm,
      if (leftThigh != null) 'left_thigh': leftThigh,
      if (rightThigh != null) 'right_thigh': rightThigh,
      if (calves != null) 'calves': calves,
      if (bodyFat != null) 'body_fat': bodyFat,
    });
  }

  BodyMeasurementsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<double?>? weight,
      Value<double?>? chest,
      Value<double?>? waist,
      Value<double?>? hips,
      Value<double?>? leftArm,
      Value<double?>? rightArm,
      Value<double?>? leftThigh,
      Value<double?>? rightThigh,
      Value<double?>? calves,
      Value<double?>? bodyFat}) {
    return BodyMeasurementsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      chest: chest ?? this.chest,
      waist: waist ?? this.waist,
      hips: hips ?? this.hips,
      leftArm: leftArm ?? this.leftArm,
      rightArm: rightArm ?? this.rightArm,
      leftThigh: leftThigh ?? this.leftThigh,
      rightThigh: rightThigh ?? this.rightThigh,
      calves: calves ?? this.calves,
      bodyFat: bodyFat ?? this.bodyFat,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (chest.present) {
      map['chest'] = Variable<double>(chest.value);
    }
    if (waist.present) {
      map['waist'] = Variable<double>(waist.value);
    }
    if (hips.present) {
      map['hips'] = Variable<double>(hips.value);
    }
    if (leftArm.present) {
      map['left_arm'] = Variable<double>(leftArm.value);
    }
    if (rightArm.present) {
      map['right_arm'] = Variable<double>(rightArm.value);
    }
    if (leftThigh.present) {
      map['left_thigh'] = Variable<double>(leftThigh.value);
    }
    if (rightThigh.present) {
      map['right_thigh'] = Variable<double>(rightThigh.value);
    }
    if (calves.present) {
      map['calves'] = Variable<double>(calves.value);
    }
    if (bodyFat.present) {
      map['body_fat'] = Variable<double>(bodyFat.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyMeasurementsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('chest: $chest, ')
          ..write('waist: $waist, ')
          ..write('hips: $hips, ')
          ..write('leftArm: $leftArm, ')
          ..write('rightArm: $rightArm, ')
          ..write('leftThigh: $leftThigh, ')
          ..write('rightThigh: $rightThigh, ')
          ..write('calves: $calves, ')
          ..write('bodyFat: $bodyFat')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workoutIdMeta =
      const VerificationMeta('workoutId');
  @override
  late final GeneratedColumn<int> workoutId = GeneratedColumn<int>(
      'workout_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES workouts (id)'));
  static const VerificationMeta _measurementIdMeta =
      const VerificationMeta('measurementId');
  @override
  late final GeneratedColumn<int> measurementId = GeneratedColumn<int>(
      'measurement_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES body_measurements (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _attemptsMeta =
      const VerificationMeta('attempts');
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
      'attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, workoutId, measurementId, type, status, createdAt, attempts, error];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('workout_id')) {
      context.handle(_workoutIdMeta,
          workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta));
    }
    if (data.containsKey('measurement_id')) {
      context.handle(
          _measurementIdMeta,
          measurementId.isAcceptableOrUnknown(
              data['measurement_id']!, _measurementIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(_attemptsMeta,
          attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta));
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workoutId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}workout_id']),
      measurementId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}measurement_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      attempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempts'])!,
      error: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error']),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final int? workoutId;
  final int? measurementId;
  final String type;
  final String status;
  final DateTime createdAt;
  final int attempts;
  final String? error;
  const SyncQueueData(
      {required this.id,
      this.workoutId,
      this.measurementId,
      required this.type,
      required this.status,
      required this.createdAt,
      required this.attempts,
      this.error});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || workoutId != null) {
      map['workout_id'] = Variable<int>(workoutId);
    }
    if (!nullToAbsent || measurementId != null) {
      map['measurement_id'] = Variable<int>(measurementId);
    }
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      workoutId: workoutId == null && nullToAbsent
          ? const Value.absent()
          : Value(workoutId),
      measurementId: measurementId == null && nullToAbsent
          ? const Value.absent()
          : Value(measurementId),
      type: Value(type),
      status: Value(status),
      createdAt: Value(createdAt),
      attempts: Value(attempts),
      error:
          error == null && nullToAbsent ? const Value.absent() : Value(error),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      workoutId: serializer.fromJson<int?>(json['workoutId']),
      measurementId: serializer.fromJson<int?>(json['measurementId']),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      attempts: serializer.fromJson<int>(json['attempts']),
      error: serializer.fromJson<String?>(json['error']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workoutId': serializer.toJson<int?>(workoutId),
      'measurementId': serializer.toJson<int?>(measurementId),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'attempts': serializer.toJson<int>(attempts),
      'error': serializer.toJson<String?>(error),
    };
  }

  SyncQueueData copyWith(
          {int? id,
          Value<int?> workoutId = const Value.absent(),
          Value<int?> measurementId = const Value.absent(),
          String? type,
          String? status,
          DateTime? createdAt,
          int? attempts,
          Value<String?> error = const Value.absent()}) =>
      SyncQueueData(
        id: id ?? this.id,
        workoutId: workoutId.present ? workoutId.value : this.workoutId,
        measurementId:
            measurementId.present ? measurementId.value : this.measurementId,
        type: type ?? this.type,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        attempts: attempts ?? this.attempts,
        error: error.present ? error.value : this.error,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      measurementId: data.measurementId.present
          ? data.measurementId.value
          : this.measurementId,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      error: data.error.present ? data.error.value : this.error,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('measurementId: $measurementId, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts, ')
          ..write('error: $error')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, workoutId, measurementId, type, status, createdAt, attempts, error);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.workoutId == this.workoutId &&
          other.measurementId == this.measurementId &&
          other.type == this.type &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.attempts == this.attempts &&
          other.error == this.error);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<int?> workoutId;
  final Value<int?> measurementId;
  final Value<String> type;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> attempts;
  final Value<String?> error;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.measurementId = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.attempts = const Value.absent(),
    this.error = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.measurementId = const Value.absent(),
    required String type,
    this.status = const Value.absent(),
    required DateTime createdAt,
    this.attempts = const Value.absent(),
    this.error = const Value.absent(),
  })  : type = Value(type),
        createdAt = Value(createdAt);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<int>? workoutId,
    Expression<int>? measurementId,
    Expression<String>? type,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? attempts,
    Expression<String>? error,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutId != null) 'workout_id': workoutId,
      if (measurementId != null) 'measurement_id': measurementId,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (attempts != null) 'attempts': attempts,
      if (error != null) 'error': error,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<int>? id,
      Value<int?>? workoutId,
      Value<int?>? measurementId,
      Value<String>? type,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? attempts,
      Value<String?>? error}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      measurementId: measurementId ?? this.measurementId,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      attempts: attempts ?? this.attempts,
      error: error ?? this.error,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<int>(workoutId.value);
    }
    if (measurementId.present) {
      map['measurement_id'] = Variable<int>(measurementId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('measurementId: $measurementId, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts, ')
          ..write('error: $error')
          ..write(')'))
        .toString();
  }
}

class $ExerciseProgressionSettingsTable extends ExerciseProgressionSettings
    with
        TableInfo<$ExerciseProgressionSettingsTable,
            ExerciseProgressionSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseProgressionSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exercises (id)'));
  static const VerificationMeta _incrementOverrideMeta =
      const VerificationMeta('incrementOverride');
  @override
  late final GeneratedColumn<double> incrementOverride =
      GeneratedColumn<double>('increment_override', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _targetRepsMeta =
      const VerificationMeta('targetReps');
  @override
  late final GeneratedColumn<int> targetReps = GeneratedColumn<int>(
      'target_reps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(10));
  static const VerificationMeta _targetSetsMeta =
      const VerificationMeta('targetSets');
  @override
  late final GeneratedColumn<int> targetSets = GeneratedColumn<int>(
      'target_sets', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _autoSuggestMeta =
      const VerificationMeta('autoSuggest');
  @override
  late final GeneratedColumn<bool> autoSuggest = GeneratedColumn<bool>(
      'auto_suggest', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("auto_suggest" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, exerciseId, incrementOverride, targetReps, targetSets, autoSuggest];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_progression_settings';
  @override
  VerificationContext validateIntegrity(
      Insertable<ExerciseProgressionSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('increment_override')) {
      context.handle(
          _incrementOverrideMeta,
          incrementOverride.isAcceptableOrUnknown(
              data['increment_override']!, _incrementOverrideMeta));
    }
    if (data.containsKey('target_reps')) {
      context.handle(
          _targetRepsMeta,
          targetReps.isAcceptableOrUnknown(
              data['target_reps']!, _targetRepsMeta));
    }
    if (data.containsKey('target_sets')) {
      context.handle(
          _targetSetsMeta,
          targetSets.isAcceptableOrUnknown(
              data['target_sets']!, _targetSetsMeta));
    }
    if (data.containsKey('auto_suggest')) {
      context.handle(
          _autoSuggestMeta,
          autoSuggest.isAcceptableOrUnknown(
              data['auto_suggest']!, _autoSuggestMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseProgressionSetting map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseProgressionSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_id'])!,
      incrementOverride: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}increment_override']),
      targetReps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_reps'])!,
      targetSets: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_sets'])!,
      autoSuggest: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}auto_suggest'])!,
    );
  }

  @override
  $ExerciseProgressionSettingsTable createAlias(String alias) {
    return $ExerciseProgressionSettingsTable(attachedDatabase, alias);
  }
}

class ExerciseProgressionSetting extends DataClass
    implements Insertable<ExerciseProgressionSetting> {
  final int id;
  final int exerciseId;
  final double? incrementOverride;
  final int targetReps;
  final int targetSets;
  final bool autoSuggest;
  const ExerciseProgressionSetting(
      {required this.id,
      required this.exerciseId,
      this.incrementOverride,
      required this.targetReps,
      required this.targetSets,
      required this.autoSuggest});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<int>(exerciseId);
    if (!nullToAbsent || incrementOverride != null) {
      map['increment_override'] = Variable<double>(incrementOverride);
    }
    map['target_reps'] = Variable<int>(targetReps);
    map['target_sets'] = Variable<int>(targetSets);
    map['auto_suggest'] = Variable<bool>(autoSuggest);
    return map;
  }

  ExerciseProgressionSettingsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseProgressionSettingsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      incrementOverride: incrementOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(incrementOverride),
      targetReps: Value(targetReps),
      targetSets: Value(targetSets),
      autoSuggest: Value(autoSuggest),
    );
  }

  factory ExerciseProgressionSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseProgressionSetting(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      incrementOverride:
          serializer.fromJson<double?>(json['incrementOverride']),
      targetReps: serializer.fromJson<int>(json['targetReps']),
      targetSets: serializer.fromJson<int>(json['targetSets']),
      autoSuggest: serializer.fromJson<bool>(json['autoSuggest']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'incrementOverride': serializer.toJson<double?>(incrementOverride),
      'targetReps': serializer.toJson<int>(targetReps),
      'targetSets': serializer.toJson<int>(targetSets),
      'autoSuggest': serializer.toJson<bool>(autoSuggest),
    };
  }

  ExerciseProgressionSetting copyWith(
          {int? id,
          int? exerciseId,
          Value<double?> incrementOverride = const Value.absent(),
          int? targetReps,
          int? targetSets,
          bool? autoSuggest}) =>
      ExerciseProgressionSetting(
        id: id ?? this.id,
        exerciseId: exerciseId ?? this.exerciseId,
        incrementOverride: incrementOverride.present
            ? incrementOverride.value
            : this.incrementOverride,
        targetReps: targetReps ?? this.targetReps,
        targetSets: targetSets ?? this.targetSets,
        autoSuggest: autoSuggest ?? this.autoSuggest,
      );
  ExerciseProgressionSetting copyWithCompanion(
      ExerciseProgressionSettingsCompanion data) {
    return ExerciseProgressionSetting(
      id: data.id.present ? data.id.value : this.id,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      incrementOverride: data.incrementOverride.present
          ? data.incrementOverride.value
          : this.incrementOverride,
      targetReps:
          data.targetReps.present ? data.targetReps.value : this.targetReps,
      targetSets:
          data.targetSets.present ? data.targetSets.value : this.targetSets,
      autoSuggest:
          data.autoSuggest.present ? data.autoSuggest.value : this.autoSuggest,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseProgressionSetting(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('incrementOverride: $incrementOverride, ')
          ..write('targetReps: $targetReps, ')
          ..write('targetSets: $targetSets, ')
          ..write('autoSuggest: $autoSuggest')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, exerciseId, incrementOverride, targetReps, targetSets, autoSuggest);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseProgressionSetting &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.incrementOverride == this.incrementOverride &&
          other.targetReps == this.targetReps &&
          other.targetSets == this.targetSets &&
          other.autoSuggest == this.autoSuggest);
}

class ExerciseProgressionSettingsCompanion
    extends UpdateCompanion<ExerciseProgressionSetting> {
  final Value<int> id;
  final Value<int> exerciseId;
  final Value<double?> incrementOverride;
  final Value<int> targetReps;
  final Value<int> targetSets;
  final Value<bool> autoSuggest;
  const ExerciseProgressionSettingsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.incrementOverride = const Value.absent(),
    this.targetReps = const Value.absent(),
    this.targetSets = const Value.absent(),
    this.autoSuggest = const Value.absent(),
  });
  ExerciseProgressionSettingsCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseId,
    this.incrementOverride = const Value.absent(),
    this.targetReps = const Value.absent(),
    this.targetSets = const Value.absent(),
    this.autoSuggest = const Value.absent(),
  }) : exerciseId = Value(exerciseId);
  static Insertable<ExerciseProgressionSetting> custom({
    Expression<int>? id,
    Expression<int>? exerciseId,
    Expression<double>? incrementOverride,
    Expression<int>? targetReps,
    Expression<int>? targetSets,
    Expression<bool>? autoSuggest,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (incrementOverride != null) 'increment_override': incrementOverride,
      if (targetReps != null) 'target_reps': targetReps,
      if (targetSets != null) 'target_sets': targetSets,
      if (autoSuggest != null) 'auto_suggest': autoSuggest,
    });
  }

  ExerciseProgressionSettingsCompanion copyWith(
      {Value<int>? id,
      Value<int>? exerciseId,
      Value<double?>? incrementOverride,
      Value<int>? targetReps,
      Value<int>? targetSets,
      Value<bool>? autoSuggest}) {
    return ExerciseProgressionSettingsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      incrementOverride: incrementOverride ?? this.incrementOverride,
      targetReps: targetReps ?? this.targetReps,
      targetSets: targetSets ?? this.targetSets,
      autoSuggest: autoSuggest ?? this.autoSuggest,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (incrementOverride.present) {
      map['increment_override'] = Variable<double>(incrementOverride.value);
    }
    if (targetReps.present) {
      map['target_reps'] = Variable<int>(targetReps.value);
    }
    if (targetSets.present) {
      map['target_sets'] = Variable<int>(targetSets.value);
    }
    if (autoSuggest.present) {
      map['auto_suggest'] = Variable<bool>(autoSuggest.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseProgressionSettingsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('incrementOverride: $incrementOverride, ')
          ..write('targetReps: $targetReps, ')
          ..write('targetSets: $targetSets, ')
          ..write('autoSuggest: $autoSuggest')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $WorkoutTemplatesTable workoutTemplates =
      $WorkoutTemplatesTable(this);
  late final $TemplateDaysTable templateDays = $TemplateDaysTable(this);
  late final $TemplateExercisesTable templateExercises =
      $TemplateExercisesTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $WorkoutSetsTable workoutSets = $WorkoutSetsTable(this);
  late final $BodyMeasurementsTable bodyMeasurements =
      $BodyMeasurementsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $ExerciseProgressionSettingsTable exerciseProgressionSettings =
      $ExerciseProgressionSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        exercises,
        workoutTemplates,
        templateDays,
        templateExercises,
        workouts,
        workoutSets,
        bodyMeasurements,
        syncQueue,
        exerciseProgressionSettings
      ];
}

typedef $$ExercisesTableCreateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  required String name,
  required String primaryMuscle,
  Value<String?> secondaryMuscle,
  required String equipment,
  required String setType,
  Value<int> restTime,
  Value<String?> instructions,
  Value<bool> isCustom,
  Value<DateTime?> lastUsed,
});
typedef $$ExercisesTableUpdateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> primaryMuscle,
  Value<String?> secondaryMuscle,
  Value<String> equipment,
  Value<String> setType,
  Value<int> restTime,
  Value<String?> instructions,
  Value<bool> isCustom,
  Value<DateTime?> lastUsed,
});

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, Exercise> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TemplateExercisesTable, List<TemplateExercise>>
      _templateExercisesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.templateExercises,
              aliasName: $_aliasNameGenerator(
                  db.exercises.id, db.templateExercises.exerciseId));

  $$TemplateExercisesTableProcessedTableManager get templateExercisesRefs {
    final manager =
        $$TemplateExercisesTableTableManager($_db, $_db.templateExercises)
            .filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_templateExercisesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WorkoutSetsTable, List<WorkoutSet>>
      _workoutSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.workoutSets,
          aliasName:
              $_aliasNameGenerator(db.exercises.id, db.workoutSets.exerciseId));

  $$WorkoutSetsTableProcessedTableManager get workoutSetsRefs {
    final manager = $$WorkoutSetsTableTableManager($_db, $_db.workoutSets)
        .filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutSetsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExerciseProgressionSettingsTable,
      List<ExerciseProgressionSetting>> _exerciseProgressionSettingsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.exerciseProgressionSettings,
          aliasName: $_aliasNameGenerator(
              db.exercises.id, db.exerciseProgressionSettings.exerciseId));

  $$ExerciseProgressionSettingsTableProcessedTableManager
      get exerciseProgressionSettingsRefs {
    final manager = $$ExerciseProgressionSettingsTableTableManager(
            $_db, $_db.exerciseProgressionSettings)
        .filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult
        .readTableOrNull(_exerciseProgressionSettingsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get primaryMuscle => $composableBuilder(
      column: $table.primaryMuscle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get secondaryMuscle => $composableBuilder(
      column: $table.secondaryMuscle,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get equipment => $composableBuilder(
      column: $table.equipment, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get setType => $composableBuilder(
      column: $table.setType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get restTime => $composableBuilder(
      column: $table.restTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCustom => $composableBuilder(
      column: $table.isCustom, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUsed => $composableBuilder(
      column: $table.lastUsed, builder: (column) => ColumnFilters(column));

  Expression<bool> templateExercisesRefs(
      Expression<bool> Function($$TemplateExercisesTableFilterComposer f) f) {
    final $$TemplateExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.templateExercises,
        getReferencedColumn: (t) => t.exerciseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateExercisesTableFilterComposer(
              $db: $db,
              $table: $db.templateExercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> workoutSetsRefs(
      Expression<bool> Function($$WorkoutSetsTableFilterComposer f) f) {
    final $$WorkoutSetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutSets,
        getReferencedColumn: (t) => t.exerciseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutSetsTableFilterComposer(
              $db: $db,
              $table: $db.workoutSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> exerciseProgressionSettingsRefs(
      Expression<bool> Function(
              $$ExerciseProgressionSettingsTableFilterComposer f)
          f) {
    final $$ExerciseProgressionSettingsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.exerciseProgressionSettings,
            getReferencedColumn: (t) => t.exerciseId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ExerciseProgressionSettingsTableFilterComposer(
                  $db: $db,
                  $table: $db.exerciseProgressionSettings,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get primaryMuscle => $composableBuilder(
      column: $table.primaryMuscle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get secondaryMuscle => $composableBuilder(
      column: $table.secondaryMuscle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipment => $composableBuilder(
      column: $table.equipment, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get setType => $composableBuilder(
      column: $table.setType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get restTime => $composableBuilder(
      column: $table.restTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instructions => $composableBuilder(
      column: $table.instructions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCustom => $composableBuilder(
      column: $table.isCustom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUsed => $composableBuilder(
      column: $table.lastUsed, builder: (column) => ColumnOrderings(column));
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get primaryMuscle => $composableBuilder(
      column: $table.primaryMuscle, builder: (column) => column);

  GeneratedColumn<String> get secondaryMuscle => $composableBuilder(
      column: $table.secondaryMuscle, builder: (column) => column);

  GeneratedColumn<String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);

  GeneratedColumn<String> get setType =>
      $composableBuilder(column: $table.setType, builder: (column) => column);

  GeneratedColumn<int> get restTime =>
      $composableBuilder(column: $table.restTime, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => column);

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsed =>
      $composableBuilder(column: $table.lastUsed, builder: (column) => column);

  Expression<T> templateExercisesRefs<T extends Object>(
      Expression<T> Function($$TemplateExercisesTableAnnotationComposer a) f) {
    final $$TemplateExercisesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.templateExercises,
            getReferencedColumn: (t) => t.exerciseId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TemplateExercisesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.templateExercises,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> workoutSetsRefs<T extends Object>(
      Expression<T> Function($$WorkoutSetsTableAnnotationComposer a) f) {
    final $$WorkoutSetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutSets,
        getReferencedColumn: (t) => t.exerciseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutSetsTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> exerciseProgressionSettingsRefs<T extends Object>(
      Expression<T> Function(
              $$ExerciseProgressionSettingsTableAnnotationComposer a)
          f) {
    final $$ExerciseProgressionSettingsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.exerciseProgressionSettings,
            getReferencedColumn: (t) => t.exerciseId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ExerciseProgressionSettingsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.exerciseProgressionSettings,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExercisesTable,
    Exercise,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (Exercise, $$ExercisesTableReferences),
    Exercise,
    PrefetchHooks Function(
        {bool templateExercisesRefs,
        bool workoutSetsRefs,
        bool exerciseProgressionSettingsRefs})> {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> primaryMuscle = const Value.absent(),
            Value<String?> secondaryMuscle = const Value.absent(),
            Value<String> equipment = const Value.absent(),
            Value<String> setType = const Value.absent(),
            Value<int> restTime = const Value.absent(),
            Value<String?> instructions = const Value.absent(),
            Value<bool> isCustom = const Value.absent(),
            Value<DateTime?> lastUsed = const Value.absent(),
          }) =>
              ExercisesCompanion(
            id: id,
            name: name,
            primaryMuscle: primaryMuscle,
            secondaryMuscle: secondaryMuscle,
            equipment: equipment,
            setType: setType,
            restTime: restTime,
            instructions: instructions,
            isCustom: isCustom,
            lastUsed: lastUsed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String primaryMuscle,
            Value<String?> secondaryMuscle = const Value.absent(),
            required String equipment,
            required String setType,
            Value<int> restTime = const Value.absent(),
            Value<String?> instructions = const Value.absent(),
            Value<bool> isCustom = const Value.absent(),
            Value<DateTime?> lastUsed = const Value.absent(),
          }) =>
              ExercisesCompanion.insert(
            id: id,
            name: name,
            primaryMuscle: primaryMuscle,
            secondaryMuscle: secondaryMuscle,
            equipment: equipment,
            setType: setType,
            restTime: restTime,
            instructions: instructions,
            isCustom: isCustom,
            lastUsed: lastUsed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExercisesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {templateExercisesRefs = false,
              workoutSetsRefs = false,
              exerciseProgressionSettingsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (templateExercisesRefs) db.templateExercises,
                if (workoutSetsRefs) db.workoutSets,
                if (exerciseProgressionSettingsRefs)
                  db.exerciseProgressionSettings
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (templateExercisesRefs)
                    await $_getPrefetchedData<Exercise, $ExercisesTable,
                            TemplateExercise>(
                        currentTable: table,
                        referencedTable: $$ExercisesTableReferences
                            ._templateExercisesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExercisesTableReferences(db, table, p0)
                                .templateExercisesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseId == item.id),
                        typedResults: items),
                  if (workoutSetsRefs)
                    await $_getPrefetchedData<Exercise, $ExercisesTable,
                            WorkoutSet>(
                        currentTable: table,
                        referencedTable: $$ExercisesTableReferences
                            ._workoutSetsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExercisesTableReferences(db, table, p0)
                                .workoutSetsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseId == item.id),
                        typedResults: items),
                  if (exerciseProgressionSettingsRefs)
                    await $_getPrefetchedData<Exercise, $ExercisesTable,
                            ExerciseProgressionSetting>(
                        currentTable: table,
                        referencedTable: $$ExercisesTableReferences
                            ._exerciseProgressionSettingsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExercisesTableReferences(db, table, p0)
                                .exerciseProgressionSettingsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExercisesTable,
    Exercise,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (Exercise, $$ExercisesTableReferences),
    Exercise,
    PrefetchHooks Function(
        {bool templateExercisesRefs,
        bool workoutSetsRefs,
        bool exerciseProgressionSettingsRefs})>;
typedef $$WorkoutTemplatesTableCreateCompanionBuilder
    = WorkoutTemplatesCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  Value<DateTime?> lastUsed,
});
typedef $$WorkoutTemplatesTableUpdateCompanionBuilder
    = WorkoutTemplatesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<DateTime?> lastUsed,
});

final class $$WorkoutTemplatesTableReferences extends BaseReferences<
    _$AppDatabase, $WorkoutTemplatesTable, WorkoutTemplate> {
  $$WorkoutTemplatesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TemplateDaysTable, List<TemplateDay>>
      _templateDaysRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.templateDays,
              aliasName: $_aliasNameGenerator(
                  db.workoutTemplates.id, db.templateDays.templateId));

  $$TemplateDaysTableProcessedTableManager get templateDaysRefs {
    final manager = $$TemplateDaysTableTableManager($_db, $_db.templateDays)
        .filter((f) => f.templateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_templateDaysRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WorkoutsTable, List<Workout>> _workoutsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.workouts,
          aliasName: $_aliasNameGenerator(
              db.workoutTemplates.id, db.workouts.templateId));

  $$WorkoutsTableProcessedTableManager get workoutsRefs {
    final manager = $$WorkoutsTableTableManager($_db, $_db.workouts)
        .filter((f) => f.templateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WorkoutTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutTemplatesTable> {
  $$WorkoutTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUsed => $composableBuilder(
      column: $table.lastUsed, builder: (column) => ColumnFilters(column));

  Expression<bool> templateDaysRefs(
      Expression<bool> Function($$TemplateDaysTableFilterComposer f) f) {
    final $$TemplateDaysTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.templateDays,
        getReferencedColumn: (t) => t.templateId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateDaysTableFilterComposer(
              $db: $db,
              $table: $db.templateDays,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> workoutsRefs(
      Expression<bool> Function($$WorkoutsTableFilterComposer f) f) {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.templateId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableFilterComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutTemplatesTable> {
  $$WorkoutTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUsed => $composableBuilder(
      column: $table.lastUsed, builder: (column) => ColumnOrderings(column));
}

class $$WorkoutTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutTemplatesTable> {
  $$WorkoutTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsed =>
      $composableBuilder(column: $table.lastUsed, builder: (column) => column);

  Expression<T> templateDaysRefs<T extends Object>(
      Expression<T> Function($$TemplateDaysTableAnnotationComposer a) f) {
    final $$TemplateDaysTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.templateDays,
        getReferencedColumn: (t) => t.templateId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateDaysTableAnnotationComposer(
              $db: $db,
              $table: $db.templateDays,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> workoutsRefs<T extends Object>(
      Expression<T> Function($$WorkoutsTableAnnotationComposer a) f) {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.templateId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableAnnotationComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutTemplatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutTemplatesTable,
    WorkoutTemplate,
    $$WorkoutTemplatesTableFilterComposer,
    $$WorkoutTemplatesTableOrderingComposer,
    $$WorkoutTemplatesTableAnnotationComposer,
    $$WorkoutTemplatesTableCreateCompanionBuilder,
    $$WorkoutTemplatesTableUpdateCompanionBuilder,
    (WorkoutTemplate, $$WorkoutTemplatesTableReferences),
    WorkoutTemplate,
    PrefetchHooks Function({bool templateDaysRefs, bool workoutsRefs})> {
  $$WorkoutTemplatesTableTableManager(
      _$AppDatabase db, $WorkoutTemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime?> lastUsed = const Value.absent(),
          }) =>
              WorkoutTemplatesCompanion(
            id: id,
            name: name,
            description: description,
            lastUsed: lastUsed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<DateTime?> lastUsed = const Value.absent(),
          }) =>
              WorkoutTemplatesCompanion.insert(
            id: id,
            name: name,
            description: description,
            lastUsed: lastUsed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkoutTemplatesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {templateDaysRefs = false, workoutsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (templateDaysRefs) db.templateDays,
                if (workoutsRefs) db.workouts
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (templateDaysRefs)
                    await $_getPrefetchedData<WorkoutTemplate,
                            $WorkoutTemplatesTable, TemplateDay>(
                        currentTable: table,
                        referencedTable: $$WorkoutTemplatesTableReferences
                            ._templateDaysRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutTemplatesTableReferences(db, table, p0)
                                .templateDaysRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.templateId == item.id),
                        typedResults: items),
                  if (workoutsRefs)
                    await $_getPrefetchedData<WorkoutTemplate,
                            $WorkoutTemplatesTable, Workout>(
                        currentTable: table,
                        referencedTable: $$WorkoutTemplatesTableReferences
                            ._workoutsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutTemplatesTableReferences(db, table, p0)
                                .workoutsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.templateId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WorkoutTemplatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutTemplatesTable,
    WorkoutTemplate,
    $$WorkoutTemplatesTableFilterComposer,
    $$WorkoutTemplatesTableOrderingComposer,
    $$WorkoutTemplatesTableAnnotationComposer,
    $$WorkoutTemplatesTableCreateCompanionBuilder,
    $$WorkoutTemplatesTableUpdateCompanionBuilder,
    (WorkoutTemplate, $$WorkoutTemplatesTableReferences),
    WorkoutTemplate,
    PrefetchHooks Function({bool templateDaysRefs, bool workoutsRefs})>;
typedef $$TemplateDaysTableCreateCompanionBuilder = TemplateDaysCompanion
    Function({
  Value<int> id,
  required int templateId,
  required String name,
  required int order,
});
typedef $$TemplateDaysTableUpdateCompanionBuilder = TemplateDaysCompanion
    Function({
  Value<int> id,
  Value<int> templateId,
  Value<String> name,
  Value<int> order,
});

final class $$TemplateDaysTableReferences
    extends BaseReferences<_$AppDatabase, $TemplateDaysTable, TemplateDay> {
  $$TemplateDaysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutTemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.workoutTemplates.createAlias($_aliasNameGenerator(
          db.templateDays.templateId, db.workoutTemplates.id));

  $$WorkoutTemplatesTableProcessedTableManager get templateId {
    final $_column = $_itemColumn<int>('template_id')!;

    final manager =
        $$WorkoutTemplatesTableTableManager($_db, $_db.workoutTemplates)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TemplateExercisesTable, List<TemplateExercise>>
      _templateExercisesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.templateExercises,
              aliasName: $_aliasNameGenerator(
                  db.templateDays.id, db.templateExercises.dayId));

  $$TemplateExercisesTableProcessedTableManager get templateExercisesRefs {
    final manager =
        $$TemplateExercisesTableTableManager($_db, $_db.templateExercises)
            .filter((f) => f.dayId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_templateExercisesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WorkoutsTable, List<Workout>> _workoutsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.workouts,
          aliasName:
              $_aliasNameGenerator(db.templateDays.id, db.workouts.dayId));

  $$WorkoutsTableProcessedTableManager get workoutsRefs {
    final manager = $$WorkoutsTableTableManager($_db, $_db.workouts)
        .filter((f) => f.dayId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TemplateDaysTableFilterComposer
    extends Composer<_$AppDatabase, $TemplateDaysTable> {
  $$TemplateDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  $$WorkoutTemplatesTableFilterComposer get templateId {
    final $$WorkoutTemplatesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.templateId,
        referencedTable: $db.workoutTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTemplatesTableFilterComposer(
              $db: $db,
              $table: $db.workoutTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> templateExercisesRefs(
      Expression<bool> Function($$TemplateExercisesTableFilterComposer f) f) {
    final $$TemplateExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.templateExercises,
        getReferencedColumn: (t) => t.dayId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateExercisesTableFilterComposer(
              $db: $db,
              $table: $db.templateExercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> workoutsRefs(
      Expression<bool> Function($$WorkoutsTableFilterComposer f) f) {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.dayId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableFilterComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TemplateDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplateDaysTable> {
  $$TemplateDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  $$WorkoutTemplatesTableOrderingComposer get templateId {
    final $$WorkoutTemplatesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.templateId,
        referencedTable: $db.workoutTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTemplatesTableOrderingComposer(
              $db: $db,
              $table: $db.workoutTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TemplateDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplateDaysTable> {
  $$TemplateDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$WorkoutTemplatesTableAnnotationComposer get templateId {
    final $$WorkoutTemplatesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.templateId,
        referencedTable: $db.workoutTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTemplatesTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> templateExercisesRefs<T extends Object>(
      Expression<T> Function($$TemplateExercisesTableAnnotationComposer a) f) {
    final $$TemplateExercisesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.templateExercises,
            getReferencedColumn: (t) => t.dayId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TemplateExercisesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.templateExercises,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> workoutsRefs<T extends Object>(
      Expression<T> Function($$WorkoutsTableAnnotationComposer a) f) {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.dayId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableAnnotationComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TemplateDaysTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TemplateDaysTable,
    TemplateDay,
    $$TemplateDaysTableFilterComposer,
    $$TemplateDaysTableOrderingComposer,
    $$TemplateDaysTableAnnotationComposer,
    $$TemplateDaysTableCreateCompanionBuilder,
    $$TemplateDaysTableUpdateCompanionBuilder,
    (TemplateDay, $$TemplateDaysTableReferences),
    TemplateDay,
    PrefetchHooks Function(
        {bool templateId, bool templateExercisesRefs, bool workoutsRefs})> {
  $$TemplateDaysTableTableManager(_$AppDatabase db, $TemplateDaysTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplateDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplateDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplateDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> templateId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> order = const Value.absent(),
          }) =>
              TemplateDaysCompanion(
            id: id,
            templateId: templateId,
            name: name,
            order: order,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int templateId,
            required String name,
            required int order,
          }) =>
              TemplateDaysCompanion.insert(
            id: id,
            templateId: templateId,
            name: name,
            order: order,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TemplateDaysTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {templateId = false,
              templateExercisesRefs = false,
              workoutsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (templateExercisesRefs) db.templateExercises,
                if (workoutsRefs) db.workouts
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (templateId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.templateId,
                    referencedTable:
                        $$TemplateDaysTableReferences._templateIdTable(db),
                    referencedColumn:
                        $$TemplateDaysTableReferences._templateIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (templateExercisesRefs)
                    await $_getPrefetchedData<TemplateDay, $TemplateDaysTable, TemplateExercise>(
                        currentTable: table,
                        referencedTable: $$TemplateDaysTableReferences
                            ._templateExercisesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TemplateDaysTableReferences(db, table, p0)
                                .templateExercisesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.dayId == item.id),
                        typedResults: items),
                  if (workoutsRefs)
                    await $_getPrefetchedData<TemplateDay, $TemplateDaysTable,
                            Workout>(
                        currentTable: table,
                        referencedTable: $$TemplateDaysTableReferences
                            ._workoutsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TemplateDaysTableReferences(db, table, p0)
                                .workoutsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.dayId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TemplateDaysTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TemplateDaysTable,
    TemplateDay,
    $$TemplateDaysTableFilterComposer,
    $$TemplateDaysTableOrderingComposer,
    $$TemplateDaysTableAnnotationComposer,
    $$TemplateDaysTableCreateCompanionBuilder,
    $$TemplateDaysTableUpdateCompanionBuilder,
    (TemplateDay, $$TemplateDaysTableReferences),
    TemplateDay,
    PrefetchHooks Function(
        {bool templateId, bool templateExercisesRefs, bool workoutsRefs})>;
typedef $$TemplateExercisesTableCreateCompanionBuilder
    = TemplateExercisesCompanion Function({
  Value<int> id,
  required int dayId,
  required int exerciseId,
  required int order,
  Value<SetType> setType,
  required String setsJson,
  Value<int> restTime,
  Value<String?> notes,
  Value<String?> supersetGroupId,
});
typedef $$TemplateExercisesTableUpdateCompanionBuilder
    = TemplateExercisesCompanion Function({
  Value<int> id,
  Value<int> dayId,
  Value<int> exerciseId,
  Value<int> order,
  Value<SetType> setType,
  Value<String> setsJson,
  Value<int> restTime,
  Value<String?> notes,
  Value<String?> supersetGroupId,
});

final class $$TemplateExercisesTableReferences extends BaseReferences<
    _$AppDatabase, $TemplateExercisesTable, TemplateExercise> {
  $$TemplateExercisesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TemplateDaysTable _dayIdTable(_$AppDatabase db) =>
      db.templateDays.createAlias(
          $_aliasNameGenerator(db.templateExercises.dayId, db.templateDays.id));

  $$TemplateDaysTableProcessedTableManager get dayId {
    final $_column = $_itemColumn<int>('day_id')!;

    final manager = $$TemplateDaysTableTableManager($_db, $_db.templateDays)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias($_aliasNameGenerator(
          db.templateExercises.exerciseId, db.exercises.id));

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager($_db, $_db.exercises)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TemplateExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $TemplateExercisesTable> {
  $$TemplateExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<SetType, SetType, int> get setType =>
      $composableBuilder(
          column: $table.setType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get setsJson => $composableBuilder(
      column: $table.setsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get restTime => $composableBuilder(
      column: $table.restTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get supersetGroupId => $composableBuilder(
      column: $table.supersetGroupId,
      builder: (column) => ColumnFilters(column));

  $$TemplateDaysTableFilterComposer get dayId {
    final $$TemplateDaysTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayId,
        referencedTable: $db.templateDays,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateDaysTableFilterComposer(
              $db: $db,
              $table: $db.templateDays,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableFilterComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TemplateExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplateExercisesTable> {
  $$TemplateExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get setType => $composableBuilder(
      column: $table.setType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get setsJson => $composableBuilder(
      column: $table.setsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get restTime => $composableBuilder(
      column: $table.restTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get supersetGroupId => $composableBuilder(
      column: $table.supersetGroupId,
      builder: (column) => ColumnOrderings(column));

  $$TemplateDaysTableOrderingComposer get dayId {
    final $$TemplateDaysTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayId,
        referencedTable: $db.templateDays,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateDaysTableOrderingComposer(
              $db: $db,
              $table: $db.templateDays,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableOrderingComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TemplateExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplateExercisesTable> {
  $$TemplateExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SetType, int> get setType =>
      $composableBuilder(column: $table.setType, builder: (column) => column);

  GeneratedColumn<String> get setsJson =>
      $composableBuilder(column: $table.setsJson, builder: (column) => column);

  GeneratedColumn<int> get restTime =>
      $composableBuilder(column: $table.restTime, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get supersetGroupId => $composableBuilder(
      column: $table.supersetGroupId, builder: (column) => column);

  $$TemplateDaysTableAnnotationComposer get dayId {
    final $$TemplateDaysTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayId,
        referencedTable: $db.templateDays,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateDaysTableAnnotationComposer(
              $db: $db,
              $table: $db.templateDays,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableAnnotationComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TemplateExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TemplateExercisesTable,
    TemplateExercise,
    $$TemplateExercisesTableFilterComposer,
    $$TemplateExercisesTableOrderingComposer,
    $$TemplateExercisesTableAnnotationComposer,
    $$TemplateExercisesTableCreateCompanionBuilder,
    $$TemplateExercisesTableUpdateCompanionBuilder,
    (TemplateExercise, $$TemplateExercisesTableReferences),
    TemplateExercise,
    PrefetchHooks Function({bool dayId, bool exerciseId})> {
  $$TemplateExercisesTableTableManager(
      _$AppDatabase db, $TemplateExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplateExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplateExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplateExercisesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> dayId = const Value.absent(),
            Value<int> exerciseId = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<SetType> setType = const Value.absent(),
            Value<String> setsJson = const Value.absent(),
            Value<int> restTime = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> supersetGroupId = const Value.absent(),
          }) =>
              TemplateExercisesCompanion(
            id: id,
            dayId: dayId,
            exerciseId: exerciseId,
            order: order,
            setType: setType,
            setsJson: setsJson,
            restTime: restTime,
            notes: notes,
            supersetGroupId: supersetGroupId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dayId,
            required int exerciseId,
            required int order,
            Value<SetType> setType = const Value.absent(),
            required String setsJson,
            Value<int> restTime = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> supersetGroupId = const Value.absent(),
          }) =>
              TemplateExercisesCompanion.insert(
            id: id,
            dayId: dayId,
            exerciseId: exerciseId,
            order: order,
            setType: setType,
            setsJson: setsJson,
            restTime: restTime,
            notes: notes,
            supersetGroupId: supersetGroupId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TemplateExercisesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({dayId = false, exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (dayId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dayId,
                    referencedTable:
                        $$TemplateExercisesTableReferences._dayIdTable(db),
                    referencedColumn:
                        $$TemplateExercisesTableReferences._dayIdTable(db).id,
                  ) as T;
                }
                if (exerciseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseId,
                    referencedTable:
                        $$TemplateExercisesTableReferences._exerciseIdTable(db),
                    referencedColumn: $$TemplateExercisesTableReferences
                        ._exerciseIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TemplateExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TemplateExercisesTable,
    TemplateExercise,
    $$TemplateExercisesTableFilterComposer,
    $$TemplateExercisesTableOrderingComposer,
    $$TemplateExercisesTableAnnotationComposer,
    $$TemplateExercisesTableCreateCompanionBuilder,
    $$TemplateExercisesTableUpdateCompanionBuilder,
    (TemplateExercise, $$TemplateExercisesTableReferences),
    TemplateExercise,
    PrefetchHooks Function({bool dayId, bool exerciseId})>;
typedef $$WorkoutsTableCreateCompanionBuilder = WorkoutsCompanion Function({
  Value<int> id,
  required String name,
  required DateTime date,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<int?> duration,
  Value<int?> templateId,
  Value<int?> dayId,
  Value<String?> notes,
  Value<String> status,
});
typedef $$WorkoutsTableUpdateCompanionBuilder = WorkoutsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<DateTime> date,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<int?> duration,
  Value<int?> templateId,
  Value<int?> dayId,
  Value<String?> notes,
  Value<String> status,
});

final class $$WorkoutsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutsTable, Workout> {
  $$WorkoutsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutTemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.workoutTemplates.createAlias(
          $_aliasNameGenerator(db.workouts.templateId, db.workoutTemplates.id));

  $$WorkoutTemplatesTableProcessedTableManager? get templateId {
    final $_column = $_itemColumn<int>('template_id');
    if ($_column == null) return null;
    final manager =
        $$WorkoutTemplatesTableTableManager($_db, $_db.workoutTemplates)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TemplateDaysTable _dayIdTable(_$AppDatabase db) => db.templateDays
      .createAlias($_aliasNameGenerator(db.workouts.dayId, db.templateDays.id));

  $$TemplateDaysTableProcessedTableManager? get dayId {
    final $_column = $_itemColumn<int>('day_id');
    if ($_column == null) return null;
    final manager = $$TemplateDaysTableTableManager($_db, $_db.templateDays)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$WorkoutSetsTable, List<WorkoutSet>>
      _workoutSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.workoutSets,
          aliasName:
              $_aliasNameGenerator(db.workouts.id, db.workoutSets.workoutId));

  $$WorkoutSetsTableProcessedTableManager get workoutSetsRefs {
    final manager = $$WorkoutSetsTableTableManager($_db, $_db.workoutSets)
        .filter((f) => f.workoutId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutSetsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SyncQueueTable, List<SyncQueueData>>
      _syncQueueRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.syncQueue,
              aliasName:
                  $_aliasNameGenerator(db.workouts.id, db.syncQueue.workoutId));

  $$SyncQueueTableProcessedTableManager get syncQueueRefs {
    final manager = $$SyncQueueTableTableManager($_db, $_db.syncQueue)
        .filter((f) => f.workoutId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncQueueRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WorkoutsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  $$WorkoutTemplatesTableFilterComposer get templateId {
    final $$WorkoutTemplatesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.templateId,
        referencedTable: $db.workoutTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTemplatesTableFilterComposer(
              $db: $db,
              $table: $db.workoutTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TemplateDaysTableFilterComposer get dayId {
    final $$TemplateDaysTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayId,
        referencedTable: $db.templateDays,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateDaysTableFilterComposer(
              $db: $db,
              $table: $db.templateDays,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> workoutSetsRefs(
      Expression<bool> Function($$WorkoutSetsTableFilterComposer f) f) {
    final $$WorkoutSetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutSets,
        getReferencedColumn: (t) => t.workoutId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutSetsTableFilterComposer(
              $db: $db,
              $table: $db.workoutSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> syncQueueRefs(
      Expression<bool> Function($$SyncQueueTableFilterComposer f) f) {
    final $$SyncQueueTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.syncQueue,
        getReferencedColumn: (t) => t.workoutId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SyncQueueTableFilterComposer(
              $db: $db,
              $table: $db.syncQueue,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  $$WorkoutTemplatesTableOrderingComposer get templateId {
    final $$WorkoutTemplatesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.templateId,
        referencedTable: $db.workoutTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTemplatesTableOrderingComposer(
              $db: $db,
              $table: $db.workoutTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TemplateDaysTableOrderingComposer get dayId {
    final $$TemplateDaysTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayId,
        referencedTable: $db.templateDays,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateDaysTableOrderingComposer(
              $db: $db,
              $table: $db.templateDays,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$WorkoutTemplatesTableAnnotationComposer get templateId {
    final $$WorkoutTemplatesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.templateId,
        referencedTable: $db.workoutTemplates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTemplatesTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TemplateDaysTableAnnotationComposer get dayId {
    final $$TemplateDaysTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dayId,
        referencedTable: $db.templateDays,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateDaysTableAnnotationComposer(
              $db: $db,
              $table: $db.templateDays,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> workoutSetsRefs<T extends Object>(
      Expression<T> Function($$WorkoutSetsTableAnnotationComposer a) f) {
    final $$WorkoutSetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutSets,
        getReferencedColumn: (t) => t.workoutId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutSetsTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> syncQueueRefs<T extends Object>(
      Expression<T> Function($$SyncQueueTableAnnotationComposer a) f) {
    final $$SyncQueueTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.syncQueue,
        getReferencedColumn: (t) => t.workoutId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SyncQueueTableAnnotationComposer(
              $db: $db,
              $table: $db.syncQueue,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutsTable,
    Workout,
    $$WorkoutsTableFilterComposer,
    $$WorkoutsTableOrderingComposer,
    $$WorkoutsTableAnnotationComposer,
    $$WorkoutsTableCreateCompanionBuilder,
    $$WorkoutsTableUpdateCompanionBuilder,
    (Workout, $$WorkoutsTableReferences),
    Workout,
    PrefetchHooks Function(
        {bool templateId,
        bool dayId,
        bool workoutSetsRefs,
        bool syncQueueRefs})> {
  $$WorkoutsTableTableManager(_$AppDatabase db, $WorkoutsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int?> duration = const Value.absent(),
            Value<int?> templateId = const Value.absent(),
            Value<int?> dayId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              WorkoutsCompanion(
            id: id,
            name: name,
            date: date,
            startTime: startTime,
            endTime: endTime,
            duration: duration,
            templateId: templateId,
            dayId: dayId,
            notes: notes,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required DateTime date,
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int?> duration = const Value.absent(),
            Value<int?> templateId = const Value.absent(),
            Value<int?> dayId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              WorkoutsCompanion.insert(
            id: id,
            name: name,
            date: date,
            startTime: startTime,
            endTime: endTime,
            duration: duration,
            templateId: templateId,
            dayId: dayId,
            notes: notes,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WorkoutsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {templateId = false,
              dayId = false,
              workoutSetsRefs = false,
              syncQueueRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (workoutSetsRefs) db.workoutSets,
                if (syncQueueRefs) db.syncQueue
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (templateId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.templateId,
                    referencedTable:
                        $$WorkoutsTableReferences._templateIdTable(db),
                    referencedColumn:
                        $$WorkoutsTableReferences._templateIdTable(db).id,
                  ) as T;
                }
                if (dayId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dayId,
                    referencedTable: $$WorkoutsTableReferences._dayIdTable(db),
                    referencedColumn:
                        $$WorkoutsTableReferences._dayIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workoutSetsRefs)
                    await $_getPrefetchedData<Workout, $WorkoutsTable,
                            WorkoutSet>(
                        currentTable: table,
                        referencedTable:
                            $$WorkoutsTableReferences._workoutSetsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutsTableReferences(db, table, p0)
                                .workoutSetsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.workoutId == item.id),
                        typedResults: items),
                  if (syncQueueRefs)
                    await $_getPrefetchedData<Workout, $WorkoutsTable,
                            SyncQueueData>(
                        currentTable: table,
                        referencedTable:
                            $$WorkoutsTableReferences._syncQueueRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutsTableReferences(db, table, p0)
                                .syncQueueRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.workoutId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WorkoutsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutsTable,
    Workout,
    $$WorkoutsTableFilterComposer,
    $$WorkoutsTableOrderingComposer,
    $$WorkoutsTableAnnotationComposer,
    $$WorkoutsTableCreateCompanionBuilder,
    $$WorkoutsTableUpdateCompanionBuilder,
    (Workout, $$WorkoutsTableReferences),
    Workout,
    PrefetchHooks Function(
        {bool templateId,
        bool dayId,
        bool workoutSetsRefs,
        bool syncQueueRefs})>;
typedef $$WorkoutSetsTableCreateCompanionBuilder = WorkoutSetsCompanion
    Function({
  Value<int> id,
  required int workoutId,
  required int exerciseId,
  required int exerciseOrder,
  required int setNumber,
  required double reps,
  required double weight,
  Value<double?> rpe,
  Value<SetType> setType,
  Value<String?> notes,
  Value<bool> completed,
  Value<DateTime?> completedAt,
  Value<bool> isPr,
  Value<String?> supersetGroupId,
  Value<String?> subSetsJson,
});
typedef $$WorkoutSetsTableUpdateCompanionBuilder = WorkoutSetsCompanion
    Function({
  Value<int> id,
  Value<int> workoutId,
  Value<int> exerciseId,
  Value<int> exerciseOrder,
  Value<int> setNumber,
  Value<double> reps,
  Value<double> weight,
  Value<double?> rpe,
  Value<SetType> setType,
  Value<String?> notes,
  Value<bool> completed,
  Value<DateTime?> completedAt,
  Value<bool> isPr,
  Value<String?> supersetGroupId,
  Value<String?> subSetsJson,
});

final class $$WorkoutSetsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutSetsTable, WorkoutSet> {
  $$WorkoutSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutsTable _workoutIdTable(_$AppDatabase db) =>
      db.workouts.createAlias(
          $_aliasNameGenerator(db.workoutSets.workoutId, db.workouts.id));

  $$WorkoutsTableProcessedTableManager get workoutId {
    final $_column = $_itemColumn<int>('workout_id')!;

    final manager = $$WorkoutsTableTableManager($_db, $_db.workouts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
          $_aliasNameGenerator(db.workoutSets.exerciseId, db.exercises.id));

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager($_db, $_db.exercises)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WorkoutSetsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get exerciseOrder => $composableBuilder(
      column: $table.exerciseOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rpe => $composableBuilder(
      column: $table.rpe, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<SetType, SetType, int> get setType =>
      $composableBuilder(
          column: $table.setType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPr => $composableBuilder(
      column: $table.isPr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get supersetGroupId => $composableBuilder(
      column: $table.supersetGroupId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subSetsJson => $composableBuilder(
      column: $table.subSetsJson, builder: (column) => ColumnFilters(column));

  $$WorkoutsTableFilterComposer get workoutId {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableFilterComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableFilterComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkoutSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exerciseOrder => $composableBuilder(
      column: $table.exerciseOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rpe => $composableBuilder(
      column: $table.rpe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get setType => $composableBuilder(
      column: $table.setType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPr => $composableBuilder(
      column: $table.isPr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get supersetGroupId => $composableBuilder(
      column: $table.supersetGroupId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subSetsJson => $composableBuilder(
      column: $table.subSetsJson, builder: (column) => ColumnOrderings(column));

  $$WorkoutsTableOrderingComposer get workoutId {
    final $$WorkoutsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableOrderingComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableOrderingComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkoutSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get exerciseOrder => $composableBuilder(
      column: $table.exerciseOrder, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<double> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get rpe =>
      $composableBuilder(column: $table.rpe, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SetType, int> get setType =>
      $composableBuilder(column: $table.setType, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<bool> get isPr =>
      $composableBuilder(column: $table.isPr, builder: (column) => column);

  GeneratedColumn<String> get supersetGroupId => $composableBuilder(
      column: $table.supersetGroupId, builder: (column) => column);

  GeneratedColumn<String> get subSetsJson => $composableBuilder(
      column: $table.subSetsJson, builder: (column) => column);

  $$WorkoutsTableAnnotationComposer get workoutId {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableAnnotationComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableAnnotationComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkoutSetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutSetsTable,
    WorkoutSet,
    $$WorkoutSetsTableFilterComposer,
    $$WorkoutSetsTableOrderingComposer,
    $$WorkoutSetsTableAnnotationComposer,
    $$WorkoutSetsTableCreateCompanionBuilder,
    $$WorkoutSetsTableUpdateCompanionBuilder,
    (WorkoutSet, $$WorkoutSetsTableReferences),
    WorkoutSet,
    PrefetchHooks Function({bool workoutId, bool exerciseId})> {
  $$WorkoutSetsTableTableManager(_$AppDatabase db, $WorkoutSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> workoutId = const Value.absent(),
            Value<int> exerciseId = const Value.absent(),
            Value<int> exerciseOrder = const Value.absent(),
            Value<int> setNumber = const Value.absent(),
            Value<double> reps = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<double?> rpe = const Value.absent(),
            Value<SetType> setType = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<bool> isPr = const Value.absent(),
            Value<String?> supersetGroupId = const Value.absent(),
            Value<String?> subSetsJson = const Value.absent(),
          }) =>
              WorkoutSetsCompanion(
            id: id,
            workoutId: workoutId,
            exerciseId: exerciseId,
            exerciseOrder: exerciseOrder,
            setNumber: setNumber,
            reps: reps,
            weight: weight,
            rpe: rpe,
            setType: setType,
            notes: notes,
            completed: completed,
            completedAt: completedAt,
            isPr: isPr,
            supersetGroupId: supersetGroupId,
            subSetsJson: subSetsJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int workoutId,
            required int exerciseId,
            required int exerciseOrder,
            required int setNumber,
            required double reps,
            required double weight,
            Value<double?> rpe = const Value.absent(),
            Value<SetType> setType = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<bool> isPr = const Value.absent(),
            Value<String?> supersetGroupId = const Value.absent(),
            Value<String?> subSetsJson = const Value.absent(),
          }) =>
              WorkoutSetsCompanion.insert(
            id: id,
            workoutId: workoutId,
            exerciseId: exerciseId,
            exerciseOrder: exerciseOrder,
            setNumber: setNumber,
            reps: reps,
            weight: weight,
            rpe: rpe,
            setType: setType,
            notes: notes,
            completed: completed,
            completedAt: completedAt,
            isPr: isPr,
            supersetGroupId: supersetGroupId,
            subSetsJson: subSetsJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkoutSetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({workoutId = false, exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workoutId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workoutId,
                    referencedTable:
                        $$WorkoutSetsTableReferences._workoutIdTable(db),
                    referencedColumn:
                        $$WorkoutSetsTableReferences._workoutIdTable(db).id,
                  ) as T;
                }
                if (exerciseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseId,
                    referencedTable:
                        $$WorkoutSetsTableReferences._exerciseIdTable(db),
                    referencedColumn:
                        $$WorkoutSetsTableReferences._exerciseIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WorkoutSetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutSetsTable,
    WorkoutSet,
    $$WorkoutSetsTableFilterComposer,
    $$WorkoutSetsTableOrderingComposer,
    $$WorkoutSetsTableAnnotationComposer,
    $$WorkoutSetsTableCreateCompanionBuilder,
    $$WorkoutSetsTableUpdateCompanionBuilder,
    (WorkoutSet, $$WorkoutSetsTableReferences),
    WorkoutSet,
    PrefetchHooks Function({bool workoutId, bool exerciseId})>;
typedef $$BodyMeasurementsTableCreateCompanionBuilder
    = BodyMeasurementsCompanion Function({
  Value<int> id,
  required DateTime date,
  Value<double?> weight,
  Value<double?> chest,
  Value<double?> waist,
  Value<double?> hips,
  Value<double?> leftArm,
  Value<double?> rightArm,
  Value<double?> leftThigh,
  Value<double?> rightThigh,
  Value<double?> calves,
  Value<double?> bodyFat,
});
typedef $$BodyMeasurementsTableUpdateCompanionBuilder
    = BodyMeasurementsCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<double?> weight,
  Value<double?> chest,
  Value<double?> waist,
  Value<double?> hips,
  Value<double?> leftArm,
  Value<double?> rightArm,
  Value<double?> leftThigh,
  Value<double?> rightThigh,
  Value<double?> calves,
  Value<double?> bodyFat,
});

final class $$BodyMeasurementsTableReferences extends BaseReferences<
    _$AppDatabase, $BodyMeasurementsTable, BodyMeasurement> {
  $$BodyMeasurementsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SyncQueueTable, List<SyncQueueData>>
      _syncQueueRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.syncQueue,
              aliasName: $_aliasNameGenerator(
                  db.bodyMeasurements.id, db.syncQueue.measurementId));

  $$SyncQueueTableProcessedTableManager get syncQueueRefs {
    final manager = $$SyncQueueTableTableManager($_db, $_db.syncQueue)
        .filter((f) => f.measurementId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncQueueRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BodyMeasurementsTableFilterComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get chest => $composableBuilder(
      column: $table.chest, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get waist => $composableBuilder(
      column: $table.waist, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hips => $composableBuilder(
      column: $table.hips, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get leftArm => $composableBuilder(
      column: $table.leftArm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rightArm => $composableBuilder(
      column: $table.rightArm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get leftThigh => $composableBuilder(
      column: $table.leftThigh, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rightThigh => $composableBuilder(
      column: $table.rightThigh, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get calves => $composableBuilder(
      column: $table.calves, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bodyFat => $composableBuilder(
      column: $table.bodyFat, builder: (column) => ColumnFilters(column));

  Expression<bool> syncQueueRefs(
      Expression<bool> Function($$SyncQueueTableFilterComposer f) f) {
    final $$SyncQueueTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.syncQueue,
        getReferencedColumn: (t) => t.measurementId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SyncQueueTableFilterComposer(
              $db: $db,
              $table: $db.syncQueue,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BodyMeasurementsTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get chest => $composableBuilder(
      column: $table.chest, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get waist => $composableBuilder(
      column: $table.waist, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hips => $composableBuilder(
      column: $table.hips, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get leftArm => $composableBuilder(
      column: $table.leftArm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rightArm => $composableBuilder(
      column: $table.rightArm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get leftThigh => $composableBuilder(
      column: $table.leftThigh, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rightThigh => $composableBuilder(
      column: $table.rightThigh, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get calves => $composableBuilder(
      column: $table.calves, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bodyFat => $composableBuilder(
      column: $table.bodyFat, builder: (column) => ColumnOrderings(column));
}

class $$BodyMeasurementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get chest =>
      $composableBuilder(column: $table.chest, builder: (column) => column);

  GeneratedColumn<double> get waist =>
      $composableBuilder(column: $table.waist, builder: (column) => column);

  GeneratedColumn<double> get hips =>
      $composableBuilder(column: $table.hips, builder: (column) => column);

  GeneratedColumn<double> get leftArm =>
      $composableBuilder(column: $table.leftArm, builder: (column) => column);

  GeneratedColumn<double> get rightArm =>
      $composableBuilder(column: $table.rightArm, builder: (column) => column);

  GeneratedColumn<double> get leftThigh =>
      $composableBuilder(column: $table.leftThigh, builder: (column) => column);

  GeneratedColumn<double> get rightThigh => $composableBuilder(
      column: $table.rightThigh, builder: (column) => column);

  GeneratedColumn<double> get calves =>
      $composableBuilder(column: $table.calves, builder: (column) => column);

  GeneratedColumn<double> get bodyFat =>
      $composableBuilder(column: $table.bodyFat, builder: (column) => column);

  Expression<T> syncQueueRefs<T extends Object>(
      Expression<T> Function($$SyncQueueTableAnnotationComposer a) f) {
    final $$SyncQueueTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.syncQueue,
        getReferencedColumn: (t) => t.measurementId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SyncQueueTableAnnotationComposer(
              $db: $db,
              $table: $db.syncQueue,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BodyMeasurementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BodyMeasurementsTable,
    BodyMeasurement,
    $$BodyMeasurementsTableFilterComposer,
    $$BodyMeasurementsTableOrderingComposer,
    $$BodyMeasurementsTableAnnotationComposer,
    $$BodyMeasurementsTableCreateCompanionBuilder,
    $$BodyMeasurementsTableUpdateCompanionBuilder,
    (BodyMeasurement, $$BodyMeasurementsTableReferences),
    BodyMeasurement,
    PrefetchHooks Function({bool syncQueueRefs})> {
  $$BodyMeasurementsTableTableManager(
      _$AppDatabase db, $BodyMeasurementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyMeasurementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyMeasurementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyMeasurementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<double?> chest = const Value.absent(),
            Value<double?> waist = const Value.absent(),
            Value<double?> hips = const Value.absent(),
            Value<double?> leftArm = const Value.absent(),
            Value<double?> rightArm = const Value.absent(),
            Value<double?> leftThigh = const Value.absent(),
            Value<double?> rightThigh = const Value.absent(),
            Value<double?> calves = const Value.absent(),
            Value<double?> bodyFat = const Value.absent(),
          }) =>
              BodyMeasurementsCompanion(
            id: id,
            date: date,
            weight: weight,
            chest: chest,
            waist: waist,
            hips: hips,
            leftArm: leftArm,
            rightArm: rightArm,
            leftThigh: leftThigh,
            rightThigh: rightThigh,
            calves: calves,
            bodyFat: bodyFat,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            Value<double?> weight = const Value.absent(),
            Value<double?> chest = const Value.absent(),
            Value<double?> waist = const Value.absent(),
            Value<double?> hips = const Value.absent(),
            Value<double?> leftArm = const Value.absent(),
            Value<double?> rightArm = const Value.absent(),
            Value<double?> leftThigh = const Value.absent(),
            Value<double?> rightThigh = const Value.absent(),
            Value<double?> calves = const Value.absent(),
            Value<double?> bodyFat = const Value.absent(),
          }) =>
              BodyMeasurementsCompanion.insert(
            id: id,
            date: date,
            weight: weight,
            chest: chest,
            waist: waist,
            hips: hips,
            leftArm: leftArm,
            rightArm: rightArm,
            leftThigh: leftThigh,
            rightThigh: rightThigh,
            calves: calves,
            bodyFat: bodyFat,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BodyMeasurementsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({syncQueueRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (syncQueueRefs) db.syncQueue],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (syncQueueRefs)
                    await $_getPrefetchedData<BodyMeasurement,
                            $BodyMeasurementsTable, SyncQueueData>(
                        currentTable: table,
                        referencedTable: $$BodyMeasurementsTableReferences
                            ._syncQueueRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BodyMeasurementsTableReferences(db, table, p0)
                                .syncQueueRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.measurementId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BodyMeasurementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BodyMeasurementsTable,
    BodyMeasurement,
    $$BodyMeasurementsTableFilterComposer,
    $$BodyMeasurementsTableOrderingComposer,
    $$BodyMeasurementsTableAnnotationComposer,
    $$BodyMeasurementsTableCreateCompanionBuilder,
    $$BodyMeasurementsTableUpdateCompanionBuilder,
    (BodyMeasurement, $$BodyMeasurementsTableReferences),
    BodyMeasurement,
    PrefetchHooks Function({bool syncQueueRefs})>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<int?> workoutId,
  Value<int?> measurementId,
  required String type,
  Value<String> status,
  required DateTime createdAt,
  Value<int> attempts,
  Value<String?> error,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<int?> workoutId,
  Value<int?> measurementId,
  Value<String> type,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> attempts,
  Value<String?> error,
});

final class $$SyncQueueTableReferences
    extends BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData> {
  $$SyncQueueTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutsTable _workoutIdTable(_$AppDatabase db) =>
      db.workouts.createAlias(
          $_aliasNameGenerator(db.syncQueue.workoutId, db.workouts.id));

  $$WorkoutsTableProcessedTableManager? get workoutId {
    final $_column = $_itemColumn<int>('workout_id');
    if ($_column == null) return null;
    final manager = $$WorkoutsTableTableManager($_db, $_db.workouts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BodyMeasurementsTable _measurementIdTable(_$AppDatabase db) =>
      db.bodyMeasurements.createAlias($_aliasNameGenerator(
          db.syncQueue.measurementId, db.bodyMeasurements.id));

  $$BodyMeasurementsTableProcessedTableManager? get measurementId {
    final $_column = $_itemColumn<int>('measurement_id');
    if ($_column == null) return null;
    final manager =
        $$BodyMeasurementsTableTableManager($_db, $_db.bodyMeasurements)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_measurementIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnFilters(column));

  $$WorkoutsTableFilterComposer get workoutId {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableFilterComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BodyMeasurementsTableFilterComposer get measurementId {
    final $$BodyMeasurementsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.measurementId,
        referencedTable: $db.bodyMeasurements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BodyMeasurementsTableFilterComposer(
              $db: $db,
              $table: $db.bodyMeasurements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnOrderings(column));

  $$WorkoutsTableOrderingComposer get workoutId {
    final $$WorkoutsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableOrderingComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BodyMeasurementsTableOrderingComposer get measurementId {
    final $$BodyMeasurementsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.measurementId,
        referencedTable: $db.bodyMeasurements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BodyMeasurementsTableOrderingComposer(
              $db: $db,
              $table: $db.bodyMeasurements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  $$WorkoutsTableAnnotationComposer get workoutId {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableAnnotationComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BodyMeasurementsTableAnnotationComposer get measurementId {
    final $$BodyMeasurementsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.measurementId,
        referencedTable: $db.bodyMeasurements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BodyMeasurementsTableAnnotationComposer(
              $db: $db,
              $table: $db.bodyMeasurements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (SyncQueueData, $$SyncQueueTableReferences),
    SyncQueueData,
    PrefetchHooks Function({bool workoutId, bool measurementId})> {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> workoutId = const Value.absent(),
            Value<int?> measurementId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<String?> error = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            workoutId: workoutId,
            measurementId: measurementId,
            type: type,
            status: status,
            createdAt: createdAt,
            attempts: attempts,
            error: error,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> workoutId = const Value.absent(),
            Value<int?> measurementId = const Value.absent(),
            required String type,
            Value<String> status = const Value.absent(),
            required DateTime createdAt,
            Value<int> attempts = const Value.absent(),
            Value<String?> error = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            workoutId: workoutId,
            measurementId: measurementId,
            type: type,
            status: status,
            createdAt: createdAt,
            attempts: attempts,
            error: error,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SyncQueueTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({workoutId = false, measurementId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workoutId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workoutId,
                    referencedTable:
                        $$SyncQueueTableReferences._workoutIdTable(db),
                    referencedColumn:
                        $$SyncQueueTableReferences._workoutIdTable(db).id,
                  ) as T;
                }
                if (measurementId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.measurementId,
                    referencedTable:
                        $$SyncQueueTableReferences._measurementIdTable(db),
                    referencedColumn:
                        $$SyncQueueTableReferences._measurementIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (SyncQueueData, $$SyncQueueTableReferences),
    SyncQueueData,
    PrefetchHooks Function({bool workoutId, bool measurementId})>;
typedef $$ExerciseProgressionSettingsTableCreateCompanionBuilder
    = ExerciseProgressionSettingsCompanion Function({
  Value<int> id,
  required int exerciseId,
  Value<double?> incrementOverride,
  Value<int> targetReps,
  Value<int> targetSets,
  Value<bool> autoSuggest,
});
typedef $$ExerciseProgressionSettingsTableUpdateCompanionBuilder
    = ExerciseProgressionSettingsCompanion Function({
  Value<int> id,
  Value<int> exerciseId,
  Value<double?> incrementOverride,
  Value<int> targetReps,
  Value<int> targetSets,
  Value<bool> autoSuggest,
});

final class $$ExerciseProgressionSettingsTableReferences extends BaseReferences<
    _$AppDatabase,
    $ExerciseProgressionSettingsTable,
    ExerciseProgressionSetting> {
  $$ExerciseProgressionSettingsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias($_aliasNameGenerator(
          db.exerciseProgressionSettings.exerciseId, db.exercises.id));

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager($_db, $_db.exercises)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExerciseProgressionSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseProgressionSettingsTable> {
  $$ExerciseProgressionSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get incrementOverride => $composableBuilder(
      column: $table.incrementOverride,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetReps => $composableBuilder(
      column: $table.targetReps, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetSets => $composableBuilder(
      column: $table.targetSets, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get autoSuggest => $composableBuilder(
      column: $table.autoSuggest, builder: (column) => ColumnFilters(column));

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableFilterComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExerciseProgressionSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseProgressionSettingsTable> {
  $$ExerciseProgressionSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get incrementOverride => $composableBuilder(
      column: $table.incrementOverride,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetReps => $composableBuilder(
      column: $table.targetReps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetSets => $composableBuilder(
      column: $table.targetSets, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get autoSuggest => $composableBuilder(
      column: $table.autoSuggest, builder: (column) => ColumnOrderings(column));

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableOrderingComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExerciseProgressionSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseProgressionSettingsTable> {
  $$ExerciseProgressionSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get incrementOverride => $composableBuilder(
      column: $table.incrementOverride, builder: (column) => column);

  GeneratedColumn<int> get targetReps => $composableBuilder(
      column: $table.targetReps, builder: (column) => column);

  GeneratedColumn<int> get targetSets => $composableBuilder(
      column: $table.targetSets, builder: (column) => column);

  GeneratedColumn<bool> get autoSuggest => $composableBuilder(
      column: $table.autoSuggest, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableAnnotationComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExerciseProgressionSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseProgressionSettingsTable,
    ExerciseProgressionSetting,
    $$ExerciseProgressionSettingsTableFilterComposer,
    $$ExerciseProgressionSettingsTableOrderingComposer,
    $$ExerciseProgressionSettingsTableAnnotationComposer,
    $$ExerciseProgressionSettingsTableCreateCompanionBuilder,
    $$ExerciseProgressionSettingsTableUpdateCompanionBuilder,
    (ExerciseProgressionSetting, $$ExerciseProgressionSettingsTableReferences),
    ExerciseProgressionSetting,
    PrefetchHooks Function({bool exerciseId})> {
  $$ExerciseProgressionSettingsTableTableManager(
      _$AppDatabase db, $ExerciseProgressionSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseProgressionSettingsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseProgressionSettingsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseProgressionSettingsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> exerciseId = const Value.absent(),
            Value<double?> incrementOverride = const Value.absent(),
            Value<int> targetReps = const Value.absent(),
            Value<int> targetSets = const Value.absent(),
            Value<bool> autoSuggest = const Value.absent(),
          }) =>
              ExerciseProgressionSettingsCompanion(
            id: id,
            exerciseId: exerciseId,
            incrementOverride: incrementOverride,
            targetReps: targetReps,
            targetSets: targetSets,
            autoSuggest: autoSuggest,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int exerciseId,
            Value<double?> incrementOverride = const Value.absent(),
            Value<int> targetReps = const Value.absent(),
            Value<int> targetSets = const Value.absent(),
            Value<bool> autoSuggest = const Value.absent(),
          }) =>
              ExerciseProgressionSettingsCompanion.insert(
            id: id,
            exerciseId: exerciseId,
            incrementOverride: incrementOverride,
            targetReps: targetReps,
            targetSets: targetSets,
            autoSuggest: autoSuggest,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExerciseProgressionSettingsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (exerciseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseId,
                    referencedTable:
                        $$ExerciseProgressionSettingsTableReferences
                            ._exerciseIdTable(db),
                    referencedColumn:
                        $$ExerciseProgressionSettingsTableReferences
                            ._exerciseIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExerciseProgressionSettingsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ExerciseProgressionSettingsTable,
        ExerciseProgressionSetting,
        $$ExerciseProgressionSettingsTableFilterComposer,
        $$ExerciseProgressionSettingsTableOrderingComposer,
        $$ExerciseProgressionSettingsTableAnnotationComposer,
        $$ExerciseProgressionSettingsTableCreateCompanionBuilder,
        $$ExerciseProgressionSettingsTableUpdateCompanionBuilder,
        (
          ExerciseProgressionSetting,
          $$ExerciseProgressionSettingsTableReferences
        ),
        ExerciseProgressionSetting,
        PrefetchHooks Function({bool exerciseId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$WorkoutTemplatesTableTableManager get workoutTemplates =>
      $$WorkoutTemplatesTableTableManager(_db, _db.workoutTemplates);
  $$TemplateDaysTableTableManager get templateDays =>
      $$TemplateDaysTableTableManager(_db, _db.templateDays);
  $$TemplateExercisesTableTableManager get templateExercises =>
      $$TemplateExercisesTableTableManager(_db, _db.templateExercises);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$WorkoutSetsTableTableManager get workoutSets =>
      $$WorkoutSetsTableTableManager(_db, _db.workoutSets);
  $$BodyMeasurementsTableTableManager get bodyMeasurements =>
      $$BodyMeasurementsTableTableManager(_db, _db.bodyMeasurements);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$ExerciseProgressionSettingsTableTableManager
      get exerciseProgressionSettings =>
          $$ExerciseProgressionSettingsTableTableManager(
              _db, _db.exerciseProgressionSettings);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'96b544ff7ce456f0fc1edbdafdf332306a9affed';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = ProviderRef<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
