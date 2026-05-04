// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, ExerciseTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Strength'),
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Beginner'),
  );
  static const VerificationMeta _primaryMuscleMeta = const VerificationMeta(
    'primaryMuscle',
  );
  @override
  late final GeneratedColumn<String> primaryMuscle = GeneratedColumn<String>(
    'primary_muscle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secondaryMuscleMeta = const VerificationMeta(
    'secondaryMuscle',
  );
  @override
  late final GeneratedColumn<String> secondaryMuscle = GeneratedColumn<String>(
    'secondary_muscle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _equipmentMeta = const VerificationMeta(
    'equipment',
  );
  @override
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setTypeMeta = const VerificationMeta(
    'setType',
  );
  @override
  late final GeneratedColumn<String> setType = GeneratedColumn<String>(
    'set_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restTimeMeta = const VerificationMeta(
    'restTime',
  );
  @override
  late final GeneratedColumn<int> restTime = GeneratedColumn<int>(
    'rest_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(90),
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gifUrlMeta = const VerificationMeta('gifUrl');
  @override
  late final GeneratedColumn<String> gifUrl = GeneratedColumn<String>(
    'gif_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _videoUrlMeta = const VerificationMeta(
    'videoUrl',
  );
  @override
  late final GeneratedColumn<String> videoUrl = GeneratedColumn<String>(
    'video_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mechanicMeta = const VerificationMeta(
    'mechanic',
  );
  @override
  late final GeneratedColumn<String> mechanic = GeneratedColumn<String>(
    'mechanic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _forceMeta = const VerificationMeta('force');
  @override
  late final GeneratedColumn<String> force = GeneratedColumn<String>(
    'force',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_custom" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isEnrichedMeta = const VerificationMeta(
    'isEnriched',
  );
  @override
  late final GeneratedColumn<bool> isEnriched = GeneratedColumn<bool>(
    'is_enriched',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enriched" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _nameHiMeta = const VerificationMeta('nameHi');
  @override
  late final GeneratedColumn<String> nameHi = GeneratedColumn<String>(
    'name_hi',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMrMeta = const VerificationMeta('nameMr');
  @override
  late final GeneratedColumn<String> nameMr = GeneratedColumn<String>(
    'name_mr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUsedMeta = const VerificationMeta(
    'lastUsed',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsed = GeneratedColumn<DateTime>(
    'last_used',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usageCountMeta = const VerificationMeta(
    'usageCount',
  );
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
    'usage_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    name,
    description,
    category,
    difficulty,
    primaryMuscle,
    secondaryMuscle,
    equipment,
    setType,
    restTime,
    instructions,
    gifUrl,
    imageUrl,
    videoUrl,
    mechanic,
    force,
    source,
    isCustom,
    isFavorite,
    isEnriched,
    nameHi,
    nameMr,
    lastUsed,
    usageCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseTable> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('primary_muscle')) {
      context.handle(
        _primaryMuscleMeta,
        primaryMuscle.isAcceptableOrUnknown(
          data['primary_muscle']!,
          _primaryMuscleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryMuscleMeta);
    }
    if (data.containsKey('secondary_muscle')) {
      context.handle(
        _secondaryMuscleMeta,
        secondaryMuscle.isAcceptableOrUnknown(
          data['secondary_muscle']!,
          _secondaryMuscleMeta,
        ),
      );
    }
    if (data.containsKey('equipment')) {
      context.handle(
        _equipmentMeta,
        equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta),
      );
    } else if (isInserting) {
      context.missing(_equipmentMeta);
    }
    if (data.containsKey('set_type')) {
      context.handle(
        _setTypeMeta,
        setType.isAcceptableOrUnknown(data['set_type']!, _setTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_setTypeMeta);
    }
    if (data.containsKey('rest_time')) {
      context.handle(
        _restTimeMeta,
        restTime.isAcceptableOrUnknown(data['rest_time']!, _restTimeMeta),
      );
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    }
    if (data.containsKey('gif_url')) {
      context.handle(
        _gifUrlMeta,
        gifUrl.isAcceptableOrUnknown(data['gif_url']!, _gifUrlMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('video_url')) {
      context.handle(
        _videoUrlMeta,
        videoUrl.isAcceptableOrUnknown(data['video_url']!, _videoUrlMeta),
      );
    }
    if (data.containsKey('mechanic')) {
      context.handle(
        _mechanicMeta,
        mechanic.isAcceptableOrUnknown(data['mechanic']!, _mechanicMeta),
      );
    }
    if (data.containsKey('force')) {
      context.handle(
        _forceMeta,
        force.isAcceptableOrUnknown(data['force']!, _forceMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('is_enriched')) {
      context.handle(
        _isEnrichedMeta,
        isEnriched.isAcceptableOrUnknown(data['is_enriched']!, _isEnrichedMeta),
      );
    }
    if (data.containsKey('name_hi')) {
      context.handle(
        _nameHiMeta,
        nameHi.isAcceptableOrUnknown(data['name_hi']!, _nameHiMeta),
      );
    }
    if (data.containsKey('name_mr')) {
      context.handle(
        _nameMrMeta,
        nameMr.isAcceptableOrUnknown(data['name_mr']!, _nameMrMeta),
      );
    }
    if (data.containsKey('last_used')) {
      context.handle(
        _lastUsedMeta,
        lastUsed.isAcceptableOrUnknown(data['last_used']!, _lastUsedMeta),
      );
    }
    if (data.containsKey('usage_count')) {
      context.handle(
        _usageCountMeta,
        usageCount.isAcceptableOrUnknown(data['usage_count']!, _usageCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseTable(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      primaryMuscle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_muscle'],
      )!,
      secondaryMuscle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_muscle'],
      ),
      equipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment'],
      )!,
      setType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_type'],
      )!,
      restTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_time'],
      )!,
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      ),
      gifUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gif_url'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      videoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}video_url'],
      ),
      mechanic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mechanic'],
      ),
      force: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}force'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      isCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_custom'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      isEnriched: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enriched'],
      )!,
      nameHi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_hi'],
      ),
      nameMr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_mr'],
      ),
      lastUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used'],
      ),
      usageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class ExerciseTable extends DataClass implements Insertable<ExerciseTable> {
  final int id;
  final String? exerciseId;
  final String name;
  final String? description;
  final String category;
  final String difficulty;
  final String primaryMuscle;
  final String? secondaryMuscle;
  final String equipment;
  final String setType;
  final int restTime;
  final String? instructions;
  final String? gifUrl;
  final String? imageUrl;
  final String? videoUrl;
  final String? mechanic;
  final String? force;
  final String source;
  final bool isCustom;
  final bool isFavorite;
  final bool isEnriched;
  final String? nameHi;
  final String? nameMr;
  final DateTime? lastUsed;
  final int usageCount;
  const ExerciseTable({
    required this.id,
    this.exerciseId,
    required this.name,
    this.description,
    required this.category,
    required this.difficulty,
    required this.primaryMuscle,
    this.secondaryMuscle,
    required this.equipment,
    required this.setType,
    required this.restTime,
    this.instructions,
    this.gifUrl,
    this.imageUrl,
    this.videoUrl,
    this.mechanic,
    this.force,
    required this.source,
    required this.isCustom,
    required this.isFavorite,
    required this.isEnriched,
    this.nameHi,
    this.nameMr,
    this.lastUsed,
    required this.usageCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || exerciseId != null) {
      map['exercise_id'] = Variable<String>(exerciseId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['category'] = Variable<String>(category);
    map['difficulty'] = Variable<String>(difficulty);
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
    if (!nullToAbsent || gifUrl != null) {
      map['gif_url'] = Variable<String>(gifUrl);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || videoUrl != null) {
      map['video_url'] = Variable<String>(videoUrl);
    }
    if (!nullToAbsent || mechanic != null) {
      map['mechanic'] = Variable<String>(mechanic);
    }
    if (!nullToAbsent || force != null) {
      map['force'] = Variable<String>(force);
    }
    map['source'] = Variable<String>(source);
    map['is_custom'] = Variable<bool>(isCustom);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_enriched'] = Variable<bool>(isEnriched);
    if (!nullToAbsent || nameHi != null) {
      map['name_hi'] = Variable<String>(nameHi);
    }
    if (!nullToAbsent || nameMr != null) {
      map['name_mr'] = Variable<String>(nameMr);
    }
    if (!nullToAbsent || lastUsed != null) {
      map['last_used'] = Variable<DateTime>(lastUsed);
    }
    map['usage_count'] = Variable<int>(usageCount);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      exerciseId: exerciseId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: Value(category),
      difficulty: Value(difficulty),
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
      gifUrl: gifUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(gifUrl),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      videoUrl: videoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(videoUrl),
      mechanic: mechanic == null && nullToAbsent
          ? const Value.absent()
          : Value(mechanic),
      force: force == null && nullToAbsent
          ? const Value.absent()
          : Value(force),
      source: Value(source),
      isCustom: Value(isCustom),
      isFavorite: Value(isFavorite),
      isEnriched: Value(isEnriched),
      nameHi: nameHi == null && nullToAbsent
          ? const Value.absent()
          : Value(nameHi),
      nameMr: nameMr == null && nullToAbsent
          ? const Value.absent()
          : Value(nameMr),
      lastUsed: lastUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsed),
      usageCount: Value(usageCount),
    );
  }

  factory ExerciseTable.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseTable(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<String?>(json['exerciseId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      primaryMuscle: serializer.fromJson<String>(json['primaryMuscle']),
      secondaryMuscle: serializer.fromJson<String?>(json['secondaryMuscle']),
      equipment: serializer.fromJson<String>(json['equipment']),
      setType: serializer.fromJson<String>(json['setType']),
      restTime: serializer.fromJson<int>(json['restTime']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      gifUrl: serializer.fromJson<String?>(json['gifUrl']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      videoUrl: serializer.fromJson<String?>(json['videoUrl']),
      mechanic: serializer.fromJson<String?>(json['mechanic']),
      force: serializer.fromJson<String?>(json['force']),
      source: serializer.fromJson<String>(json['source']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isEnriched: serializer.fromJson<bool>(json['isEnriched']),
      nameHi: serializer.fromJson<String?>(json['nameHi']),
      nameMr: serializer.fromJson<String?>(json['nameMr']),
      lastUsed: serializer.fromJson<DateTime?>(json['lastUsed']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<String?>(exerciseId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String>(category),
      'difficulty': serializer.toJson<String>(difficulty),
      'primaryMuscle': serializer.toJson<String>(primaryMuscle),
      'secondaryMuscle': serializer.toJson<String?>(secondaryMuscle),
      'equipment': serializer.toJson<String>(equipment),
      'setType': serializer.toJson<String>(setType),
      'restTime': serializer.toJson<int>(restTime),
      'instructions': serializer.toJson<String?>(instructions),
      'gifUrl': serializer.toJson<String?>(gifUrl),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'videoUrl': serializer.toJson<String?>(videoUrl),
      'mechanic': serializer.toJson<String?>(mechanic),
      'force': serializer.toJson<String?>(force),
      'source': serializer.toJson<String>(source),
      'isCustom': serializer.toJson<bool>(isCustom),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isEnriched': serializer.toJson<bool>(isEnriched),
      'nameHi': serializer.toJson<String?>(nameHi),
      'nameMr': serializer.toJson<String?>(nameMr),
      'lastUsed': serializer.toJson<DateTime?>(lastUsed),
      'usageCount': serializer.toJson<int>(usageCount),
    };
  }

  ExerciseTable copyWith({
    int? id,
    Value<String?> exerciseId = const Value.absent(),
    String? name,
    Value<String?> description = const Value.absent(),
    String? category,
    String? difficulty,
    String? primaryMuscle,
    Value<String?> secondaryMuscle = const Value.absent(),
    String? equipment,
    String? setType,
    int? restTime,
    Value<String?> instructions = const Value.absent(),
    Value<String?> gifUrl = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> videoUrl = const Value.absent(),
    Value<String?> mechanic = const Value.absent(),
    Value<String?> force = const Value.absent(),
    String? source,
    bool? isCustom,
    bool? isFavorite,
    bool? isEnriched,
    Value<String?> nameHi = const Value.absent(),
    Value<String?> nameMr = const Value.absent(),
    Value<DateTime?> lastUsed = const Value.absent(),
    int? usageCount,
  }) => ExerciseTable(
    id: id ?? this.id,
    exerciseId: exerciseId.present ? exerciseId.value : this.exerciseId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    category: category ?? this.category,
    difficulty: difficulty ?? this.difficulty,
    primaryMuscle: primaryMuscle ?? this.primaryMuscle,
    secondaryMuscle: secondaryMuscle.present
        ? secondaryMuscle.value
        : this.secondaryMuscle,
    equipment: equipment ?? this.equipment,
    setType: setType ?? this.setType,
    restTime: restTime ?? this.restTime,
    instructions: instructions.present ? instructions.value : this.instructions,
    gifUrl: gifUrl.present ? gifUrl.value : this.gifUrl,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    videoUrl: videoUrl.present ? videoUrl.value : this.videoUrl,
    mechanic: mechanic.present ? mechanic.value : this.mechanic,
    force: force.present ? force.value : this.force,
    source: source ?? this.source,
    isCustom: isCustom ?? this.isCustom,
    isFavorite: isFavorite ?? this.isFavorite,
    isEnriched: isEnriched ?? this.isEnriched,
    nameHi: nameHi.present ? nameHi.value : this.nameHi,
    nameMr: nameMr.present ? nameMr.value : this.nameMr,
    lastUsed: lastUsed.present ? lastUsed.value : this.lastUsed,
    usageCount: usageCount ?? this.usageCount,
  );
  ExerciseTable copyWithCompanion(ExercisesCompanion data) {
    return ExerciseTable(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
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
      gifUrl: data.gifUrl.present ? data.gifUrl.value : this.gifUrl,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      videoUrl: data.videoUrl.present ? data.videoUrl.value : this.videoUrl,
      mechanic: data.mechanic.present ? data.mechanic.value : this.mechanic,
      force: data.force.present ? data.force.value : this.force,
      source: data.source.present ? data.source.value : this.source,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      isEnriched: data.isEnriched.present
          ? data.isEnriched.value
          : this.isEnriched,
      nameHi: data.nameHi.present ? data.nameHi.value : this.nameHi,
      nameMr: data.nameMr.present ? data.nameMr.value : this.nameMr,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
      usageCount: data.usageCount.present
          ? data.usageCount.value
          : this.usageCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseTable(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('difficulty: $difficulty, ')
          ..write('primaryMuscle: $primaryMuscle, ')
          ..write('secondaryMuscle: $secondaryMuscle, ')
          ..write('equipment: $equipment, ')
          ..write('setType: $setType, ')
          ..write('restTime: $restTime, ')
          ..write('instructions: $instructions, ')
          ..write('gifUrl: $gifUrl, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('mechanic: $mechanic, ')
          ..write('force: $force, ')
          ..write('source: $source, ')
          ..write('isCustom: $isCustom, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isEnriched: $isEnriched, ')
          ..write('nameHi: $nameHi, ')
          ..write('nameMr: $nameMr, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('usageCount: $usageCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    exerciseId,
    name,
    description,
    category,
    difficulty,
    primaryMuscle,
    secondaryMuscle,
    equipment,
    setType,
    restTime,
    instructions,
    gifUrl,
    imageUrl,
    videoUrl,
    mechanic,
    force,
    source,
    isCustom,
    isFavorite,
    isEnriched,
    nameHi,
    nameMr,
    lastUsed,
    usageCount,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseTable &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.difficulty == this.difficulty &&
          other.primaryMuscle == this.primaryMuscle &&
          other.secondaryMuscle == this.secondaryMuscle &&
          other.equipment == this.equipment &&
          other.setType == this.setType &&
          other.restTime == this.restTime &&
          other.instructions == this.instructions &&
          other.gifUrl == this.gifUrl &&
          other.imageUrl == this.imageUrl &&
          other.videoUrl == this.videoUrl &&
          other.mechanic == this.mechanic &&
          other.force == this.force &&
          other.source == this.source &&
          other.isCustom == this.isCustom &&
          other.isFavorite == this.isFavorite &&
          other.isEnriched == this.isEnriched &&
          other.nameHi == this.nameHi &&
          other.nameMr == this.nameMr &&
          other.lastUsed == this.lastUsed &&
          other.usageCount == this.usageCount);
}

class ExercisesCompanion extends UpdateCompanion<ExerciseTable> {
  final Value<int> id;
  final Value<String?> exerciseId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> category;
  final Value<String> difficulty;
  final Value<String> primaryMuscle;
  final Value<String?> secondaryMuscle;
  final Value<String> equipment;
  final Value<String> setType;
  final Value<int> restTime;
  final Value<String?> instructions;
  final Value<String?> gifUrl;
  final Value<String?> imageUrl;
  final Value<String?> videoUrl;
  final Value<String?> mechanic;
  final Value<String?> force;
  final Value<String> source;
  final Value<bool> isCustom;
  final Value<bool> isFavorite;
  final Value<bool> isEnriched;
  final Value<String?> nameHi;
  final Value<String?> nameMr;
  final Value<DateTime?> lastUsed;
  final Value<int> usageCount;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.primaryMuscle = const Value.absent(),
    this.secondaryMuscle = const Value.absent(),
    this.equipment = const Value.absent(),
    this.setType = const Value.absent(),
    this.restTime = const Value.absent(),
    this.instructions = const Value.absent(),
    this.gifUrl = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.videoUrl = const Value.absent(),
    this.mechanic = const Value.absent(),
    this.force = const Value.absent(),
    this.source = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isEnriched = const Value.absent(),
    this.nameHi = const Value.absent(),
    this.nameMr = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.usageCount = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.difficulty = const Value.absent(),
    required String primaryMuscle,
    this.secondaryMuscle = const Value.absent(),
    required String equipment,
    required String setType,
    this.restTime = const Value.absent(),
    this.instructions = const Value.absent(),
    this.gifUrl = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.videoUrl = const Value.absent(),
    this.mechanic = const Value.absent(),
    this.force = const Value.absent(),
    this.source = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isEnriched = const Value.absent(),
    this.nameHi = const Value.absent(),
    this.nameMr = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.usageCount = const Value.absent(),
  }) : name = Value(name),
       primaryMuscle = Value(primaryMuscle),
       equipment = Value(equipment),
       setType = Value(setType);
  static Insertable<ExerciseTable> custom({
    Expression<int>? id,
    Expression<String>? exerciseId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? difficulty,
    Expression<String>? primaryMuscle,
    Expression<String>? secondaryMuscle,
    Expression<String>? equipment,
    Expression<String>? setType,
    Expression<int>? restTime,
    Expression<String>? instructions,
    Expression<String>? gifUrl,
    Expression<String>? imageUrl,
    Expression<String>? videoUrl,
    Expression<String>? mechanic,
    Expression<String>? force,
    Expression<String>? source,
    Expression<bool>? isCustom,
    Expression<bool>? isFavorite,
    Expression<bool>? isEnriched,
    Expression<String>? nameHi,
    Expression<String>? nameMr,
    Expression<DateTime>? lastUsed,
    Expression<int>? usageCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (difficulty != null) 'difficulty': difficulty,
      if (primaryMuscle != null) 'primary_muscle': primaryMuscle,
      if (secondaryMuscle != null) 'secondary_muscle': secondaryMuscle,
      if (equipment != null) 'equipment': equipment,
      if (setType != null) 'set_type': setType,
      if (restTime != null) 'rest_time': restTime,
      if (instructions != null) 'instructions': instructions,
      if (gifUrl != null) 'gif_url': gifUrl,
      if (imageUrl != null) 'image_url': imageUrl,
      if (videoUrl != null) 'video_url': videoUrl,
      if (mechanic != null) 'mechanic': mechanic,
      if (force != null) 'force': force,
      if (source != null) 'source': source,
      if (isCustom != null) 'is_custom': isCustom,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isEnriched != null) 'is_enriched': isEnriched,
      if (nameHi != null) 'name_hi': nameHi,
      if (nameMr != null) 'name_mr': nameMr,
      if (lastUsed != null) 'last_used': lastUsed,
      if (usageCount != null) 'usage_count': usageCount,
    });
  }

  ExercisesCompanion copyWith({
    Value<int>? id,
    Value<String?>? exerciseId,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? category,
    Value<String>? difficulty,
    Value<String>? primaryMuscle,
    Value<String?>? secondaryMuscle,
    Value<String>? equipment,
    Value<String>? setType,
    Value<int>? restTime,
    Value<String?>? instructions,
    Value<String?>? gifUrl,
    Value<String?>? imageUrl,
    Value<String?>? videoUrl,
    Value<String?>? mechanic,
    Value<String?>? force,
    Value<String>? source,
    Value<bool>? isCustom,
    Value<bool>? isFavorite,
    Value<bool>? isEnriched,
    Value<String?>? nameHi,
    Value<String?>? nameMr,
    Value<DateTime?>? lastUsed,
    Value<int>? usageCount,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      primaryMuscle: primaryMuscle ?? this.primaryMuscle,
      secondaryMuscle: secondaryMuscle ?? this.secondaryMuscle,
      equipment: equipment ?? this.equipment,
      setType: setType ?? this.setType,
      restTime: restTime ?? this.restTime,
      instructions: instructions ?? this.instructions,
      gifUrl: gifUrl ?? this.gifUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      mechanic: mechanic ?? this.mechanic,
      force: force ?? this.force,
      source: source ?? this.source,
      isCustom: isCustom ?? this.isCustom,
      isFavorite: isFavorite ?? this.isFavorite,
      isEnriched: isEnriched ?? this.isEnriched,
      nameHi: nameHi ?? this.nameHi,
      nameMr: nameMr ?? this.nameMr,
      lastUsed: lastUsed ?? this.lastUsed,
      usageCount: usageCount ?? this.usageCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
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
    if (gifUrl.present) {
      map['gif_url'] = Variable<String>(gifUrl.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (videoUrl.present) {
      map['video_url'] = Variable<String>(videoUrl.value);
    }
    if (mechanic.present) {
      map['mechanic'] = Variable<String>(mechanic.value);
    }
    if (force.present) {
      map['force'] = Variable<String>(force.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isEnriched.present) {
      map['is_enriched'] = Variable<bool>(isEnriched.value);
    }
    if (nameHi.present) {
      map['name_hi'] = Variable<String>(nameHi.value);
    }
    if (nameMr.present) {
      map['name_mr'] = Variable<String>(nameMr.value);
    }
    if (lastUsed.present) {
      map['last_used'] = Variable<DateTime>(lastUsed.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('difficulty: $difficulty, ')
          ..write('primaryMuscle: $primaryMuscle, ')
          ..write('secondaryMuscle: $secondaryMuscle, ')
          ..write('equipment: $equipment, ')
          ..write('setType: $setType, ')
          ..write('restTime: $restTime, ')
          ..write('instructions: $instructions, ')
          ..write('gifUrl: $gifUrl, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('mechanic: $mechanic, ')
          ..write('force: $force, ')
          ..write('source: $source, ')
          ..write('isCustom: $isCustom, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isEnriched: $isEnriched, ')
          ..write('nameHi: $nameHi, ')
          ..write('nameMr: $nameMr, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('usageCount: $usageCount')
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUsedMeta = const VerificationMeta(
    'lastUsed',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsed = GeneratedColumn<DateTime>(
    'last_used',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSelectedMeta = const VerificationMeta(
    'isSelected',
  );
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
    'is_selected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_selected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    goal,
    duration,
    lastUsed,
    isSelected,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('last_used')) {
      context.handle(
        _lastUsedMeta,
        lastUsed.isAcceptableOrUnknown(data['last_used']!, _lastUsedMeta),
      );
    }
    if (data.containsKey('is_selected')) {
      context.handle(
        _isSelectedMeta,
        isSelected.isAcceptableOrUnknown(data['is_selected']!, _isSelectedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}duration'],
      ),
      lastUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used'],
      ),
      isSelected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_selected'],
      )!,
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
  final String? goal;
  final String? duration;
  final DateTime? lastUsed;
  final bool isSelected;
  const WorkoutTemplate({
    required this.id,
    required this.name,
    this.description,
    this.goal,
    this.duration,
    this.lastUsed,
    required this.isSelected,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || goal != null) {
      map['goal'] = Variable<String>(goal);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<String>(duration);
    }
    if (!nullToAbsent || lastUsed != null) {
      map['last_used'] = Variable<DateTime>(lastUsed);
    }
    map['is_selected'] = Variable<bool>(isSelected);
    return map;
  }

  WorkoutTemplatesCompanion toCompanion(bool nullToAbsent) {
    return WorkoutTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      goal: goal == null && nullToAbsent ? const Value.absent() : Value(goal),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      lastUsed: lastUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsed),
      isSelected: Value(isSelected),
    );
  }

  factory WorkoutTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutTemplate(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      goal: serializer.fromJson<String?>(json['goal']),
      duration: serializer.fromJson<String?>(json['duration']),
      lastUsed: serializer.fromJson<DateTime?>(json['lastUsed']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'goal': serializer.toJson<String?>(goal),
      'duration': serializer.toJson<String?>(duration),
      'lastUsed': serializer.toJson<DateTime?>(lastUsed),
      'isSelected': serializer.toJson<bool>(isSelected),
    };
  }

  WorkoutTemplate copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> goal = const Value.absent(),
    Value<String?> duration = const Value.absent(),
    Value<DateTime?> lastUsed = const Value.absent(),
    bool? isSelected,
  }) => WorkoutTemplate(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    goal: goal.present ? goal.value : this.goal,
    duration: duration.present ? duration.value : this.duration,
    lastUsed: lastUsed.present ? lastUsed.value : this.lastUsed,
    isSelected: isSelected ?? this.isSelected,
  );
  WorkoutTemplate copyWithCompanion(WorkoutTemplatesCompanion data) {
    return WorkoutTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      goal: data.goal.present ? data.goal.value : this.goal,
      duration: data.duration.present ? data.duration.value : this.duration,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
      isSelected: data.isSelected.present
          ? data.isSelected.value
          : this.isSelected,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('goal: $goal, ')
          ..write('duration: $duration, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('isSelected: $isSelected')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, goal, duration, lastUsed, isSelected);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.goal == this.goal &&
          other.duration == this.duration &&
          other.lastUsed == this.lastUsed &&
          other.isSelected == this.isSelected);
}

class WorkoutTemplatesCompanion extends UpdateCompanion<WorkoutTemplate> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> goal;
  final Value<String?> duration;
  final Value<DateTime?> lastUsed;
  final Value<bool> isSelected;
  const WorkoutTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.goal = const Value.absent(),
    this.duration = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.isSelected = const Value.absent(),
  });
  WorkoutTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.goal = const Value.absent(),
    this.duration = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.isSelected = const Value.absent(),
  }) : name = Value(name);
  static Insertable<WorkoutTemplate> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? goal,
    Expression<String>? duration,
    Expression<DateTime>? lastUsed,
    Expression<bool>? isSelected,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (goal != null) 'goal': goal,
      if (duration != null) 'duration': duration,
      if (lastUsed != null) 'last_used': lastUsed,
      if (isSelected != null) 'is_selected': isSelected,
    });
  }

  WorkoutTemplatesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? goal,
    Value<String?>? duration,
    Value<DateTime?>? lastUsed,
    Value<bool>? isSelected,
  }) {
    return WorkoutTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      goal: goal ?? this.goal,
      duration: duration ?? this.duration,
      lastUsed: lastUsed ?? this.lastUsed,
      isSelected: isSelected ?? this.isSelected,
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
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (lastUsed.present) {
      map['last_used'] = Variable<DateTime>(lastUsed.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('goal: $goal, ')
          ..write('duration: $duration, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('isSelected: $isSelected')
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workout_templates (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekdayMeta = const VerificationMeta(
    'weekday',
  );
  @override
  late final GeneratedColumn<int> weekday = GeneratedColumn<int>(
    'weekday',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, templateId, name, order, weekday];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'template_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<TemplateDay> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('weekday')) {
      context.handle(
        _weekdayMeta,
        weekday.isAcceptableOrUnknown(data['weekday']!, _weekdayMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemplateDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemplateDay(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}template_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      weekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekday'],
      ),
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
  final int? weekday;
  const TemplateDay({
    required this.id,
    required this.templateId,
    required this.name,
    required this.order,
    this.weekday,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['template_id'] = Variable<int>(templateId);
    map['name'] = Variable<String>(name);
    map['order'] = Variable<int>(order);
    if (!nullToAbsent || weekday != null) {
      map['weekday'] = Variable<int>(weekday);
    }
    return map;
  }

  TemplateDaysCompanion toCompanion(bool nullToAbsent) {
    return TemplateDaysCompanion(
      id: Value(id),
      templateId: Value(templateId),
      name: Value(name),
      order: Value(order),
      weekday: weekday == null && nullToAbsent
          ? const Value.absent()
          : Value(weekday),
    );
  }

  factory TemplateDay.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemplateDay(
      id: serializer.fromJson<int>(json['id']),
      templateId: serializer.fromJson<int>(json['templateId']),
      name: serializer.fromJson<String>(json['name']),
      order: serializer.fromJson<int>(json['order']),
      weekday: serializer.fromJson<int?>(json['weekday']),
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
      'weekday': serializer.toJson<int?>(weekday),
    };
  }

  TemplateDay copyWith({
    int? id,
    int? templateId,
    String? name,
    int? order,
    Value<int?> weekday = const Value.absent(),
  }) => TemplateDay(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    name: name ?? this.name,
    order: order ?? this.order,
    weekday: weekday.present ? weekday.value : this.weekday,
  );
  TemplateDay copyWithCompanion(TemplateDaysCompanion data) {
    return TemplateDay(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      name: data.name.present ? data.name.value : this.name,
      order: data.order.present ? data.order.value : this.order,
      weekday: data.weekday.present ? data.weekday.value : this.weekday,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemplateDay(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('name: $name, ')
          ..write('order: $order, ')
          ..write('weekday: $weekday')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, templateId, name, order, weekday);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemplateDay &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.name == this.name &&
          other.order == this.order &&
          other.weekday == this.weekday);
}

class TemplateDaysCompanion extends UpdateCompanion<TemplateDay> {
  final Value<int> id;
  final Value<int> templateId;
  final Value<String> name;
  final Value<int> order;
  final Value<int?> weekday;
  const TemplateDaysCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.name = const Value.absent(),
    this.order = const Value.absent(),
    this.weekday = const Value.absent(),
  });
  TemplateDaysCompanion.insert({
    this.id = const Value.absent(),
    required int templateId,
    required String name,
    required int order,
    this.weekday = const Value.absent(),
  }) : templateId = Value(templateId),
       name = Value(name),
       order = Value(order);
  static Insertable<TemplateDay> custom({
    Expression<int>? id,
    Expression<int>? templateId,
    Expression<String>? name,
    Expression<int>? order,
    Expression<int>? weekday,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (name != null) 'name': name,
      if (order != null) 'order': order,
      if (weekday != null) 'weekday': weekday,
    });
  }

  TemplateDaysCompanion copyWith({
    Value<int>? id,
    Value<int>? templateId,
    Value<String>? name,
    Value<int>? order,
    Value<int?>? weekday,
  }) {
    return TemplateDaysCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      name: name ?? this.name,
      order: order ?? this.order,
      weekday: weekday ?? this.weekday,
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
    if (weekday.present) {
      map['weekday'] = Variable<int>(weekday.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplateDaysCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('name: $name, ')
          ..write('order: $order, ')
          ..write('weekday: $weekday')
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dayIdMeta = const VerificationMeta('dayId');
  @override
  late final GeneratedColumn<int> dayId = GeneratedColumn<int>(
    'day_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES template_days (id)',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SetType, int> setType =
      GeneratedColumn<int>(
        'set_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<SetType>($TemplateExercisesTable.$convertersetType);
  static const VerificationMeta _setsJsonMeta = const VerificationMeta(
    'setsJson',
  );
  @override
  late final GeneratedColumn<String> setsJson = GeneratedColumn<String>(
    'sets_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restTimeMeta = const VerificationMeta(
    'restTime',
  );
  @override
  late final GeneratedColumn<int> restTime = GeneratedColumn<int>(
    'rest_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(90),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supersetGroupIdMeta = const VerificationMeta(
    'supersetGroupId',
  );
  @override
  late final GeneratedColumn<String> supersetGroupId = GeneratedColumn<String>(
    'superset_group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
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
    supersetGroupId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'template_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<TemplateExercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('day_id')) {
      context.handle(
        _dayIdMeta,
        dayId.isAcceptableOrUnknown(data['day_id']!, _dayIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dayIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('sets_json')) {
      context.handle(
        _setsJsonMeta,
        setsJson.isAcceptableOrUnknown(data['sets_json']!, _setsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_setsJsonMeta);
    }
    if (data.containsKey('rest_time')) {
      context.handle(
        _restTimeMeta,
        restTime.isAcceptableOrUnknown(data['rest_time']!, _restTimeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('superset_group_id')) {
      context.handle(
        _supersetGroupIdMeta,
        supersetGroupId.isAcceptableOrUnknown(
          data['superset_group_id']!,
          _supersetGroupIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemplateExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemplateExercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dayId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      setType: $TemplateExercisesTable.$convertersetType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}set_type'],
        )!,
      ),
      setsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sets_json'],
      )!,
      restTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_time'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      supersetGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}superset_group_id'],
      ),
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
  const TemplateExercise({
    required this.id,
    required this.dayId,
    required this.exerciseId,
    required this.order,
    required this.setType,
    required this.setsJson,
    required this.restTime,
    this.notes,
    this.supersetGroupId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['day_id'] = Variable<int>(dayId);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['order'] = Variable<int>(order);
    {
      map['set_type'] = Variable<int>(
        $TemplateExercisesTable.$convertersetType.toSql(setType),
      );
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
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      supersetGroupId: supersetGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(supersetGroupId),
    );
  }

  factory TemplateExercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemplateExercise(
      id: serializer.fromJson<int>(json['id']),
      dayId: serializer.fromJson<int>(json['dayId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      order: serializer.fromJson<int>(json['order']),
      setType: $TemplateExercisesTable.$convertersetType.fromJson(
        serializer.fromJson<int>(json['setType']),
      ),
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
        $TemplateExercisesTable.$convertersetType.toJson(setType),
      ),
      'setsJson': serializer.toJson<String>(setsJson),
      'restTime': serializer.toJson<int>(restTime),
      'notes': serializer.toJson<String?>(notes),
      'supersetGroupId': serializer.toJson<String?>(supersetGroupId),
    };
  }

  TemplateExercise copyWith({
    int? id,
    int? dayId,
    int? exerciseId,
    int? order,
    SetType? setType,
    String? setsJson,
    int? restTime,
    Value<String?> notes = const Value.absent(),
    Value<String?> supersetGroupId = const Value.absent(),
  }) => TemplateExercise(
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
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
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
  int get hashCode => Object.hash(
    id,
    dayId,
    exerciseId,
    order,
    setType,
    setsJson,
    restTime,
    notes,
    supersetGroupId,
  );
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
  }) : dayId = Value(dayId),
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

  TemplateExercisesCompanion copyWith({
    Value<int>? id,
    Value<int>? dayId,
    Value<int>? exerciseId,
    Value<int>? order,
    Value<SetType>? setType,
    Value<String>? setsJson,
    Value<int>? restTime,
    Value<String?>? notes,
    Value<String?>? supersetGroupId,
  }) {
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
        $TemplateExercisesTable.$convertersetType.toSql(setType.value),
      );
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

class $MesocyclesTable extends Mesocycles
    with TableInfo<$MesocyclesTable, Mesocycle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MesocyclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _splitTypeMeta = const VerificationMeta(
    'splitType',
  );
  @override
  late final GeneratedColumn<String> splitType = GeneratedColumn<String>(
    'split_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _experienceLevelMeta = const VerificationMeta(
    'experienceLevel',
  );
  @override
  late final GeneratedColumn<String> experienceLevel = GeneratedColumn<String>(
    'experience_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weeksCountMeta = const VerificationMeta(
    'weeksCount',
  );
  @override
  late final GeneratedColumn<int> weeksCount = GeneratedColumn<int>(
    'weeks_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _daysPerWeekMeta = const VerificationMeta(
    'daysPerWeek',
  );
  @override
  late final GeneratedColumn<int> daysPerWeek = GeneratedColumn<int>(
    'days_per_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    goal,
    splitType,
    experienceLevel,
    weeksCount,
    daysPerWeek,
    createdAt,
    updatedAt,
    notes,
    isArchived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mesocycles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Mesocycle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('split_type')) {
      context.handle(
        _splitTypeMeta,
        splitType.isAcceptableOrUnknown(data['split_type']!, _splitTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_splitTypeMeta);
    }
    if (data.containsKey('experience_level')) {
      context.handle(
        _experienceLevelMeta,
        experienceLevel.isAcceptableOrUnknown(
          data['experience_level']!,
          _experienceLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_experienceLevelMeta);
    }
    if (data.containsKey('weeks_count')) {
      context.handle(
        _weeksCountMeta,
        weeksCount.isAcceptableOrUnknown(data['weeks_count']!, _weeksCountMeta),
      );
    } else if (isInserting) {
      context.missing(_weeksCountMeta);
    }
    if (data.containsKey('days_per_week')) {
      context.handle(
        _daysPerWeekMeta,
        daysPerWeek.isAcceptableOrUnknown(
          data['days_per_week']!,
          _daysPerWeekMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_daysPerWeekMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Mesocycle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Mesocycle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      )!,
      splitType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}split_type'],
      )!,
      experienceLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}experience_level'],
      )!,
      weeksCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weeks_count'],
      )!,
      daysPerWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}days_per_week'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
    );
  }

  @override
  $MesocyclesTable createAlias(String alias) {
    return $MesocyclesTable(attachedDatabase, alias);
  }
}

class Mesocycle extends DataClass implements Insertable<Mesocycle> {
  final int id;
  final String name;
  final String goal;
  final String splitType;
  final String experienceLevel;
  final int weeksCount;
  final int daysPerWeek;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? notes;
  final bool isArchived;
  const Mesocycle({
    required this.id,
    required this.name,
    required this.goal,
    required this.splitType,
    required this.experienceLevel,
    required this.weeksCount,
    required this.daysPerWeek,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
    required this.isArchived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['goal'] = Variable<String>(goal);
    map['split_type'] = Variable<String>(splitType);
    map['experience_level'] = Variable<String>(experienceLevel);
    map['weeks_count'] = Variable<int>(weeksCount);
    map['days_per_week'] = Variable<int>(daysPerWeek);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  MesocyclesCompanion toCompanion(bool nullToAbsent) {
    return MesocyclesCompanion(
      id: Value(id),
      name: Value(name),
      goal: Value(goal),
      splitType: Value(splitType),
      experienceLevel: Value(experienceLevel),
      weeksCount: Value(weeksCount),
      daysPerWeek: Value(daysPerWeek),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isArchived: Value(isArchived),
    );
  }

  factory Mesocycle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Mesocycle(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      goal: serializer.fromJson<String>(json['goal']),
      splitType: serializer.fromJson<String>(json['splitType']),
      experienceLevel: serializer.fromJson<String>(json['experienceLevel']),
      weeksCount: serializer.fromJson<int>(json['weeksCount']),
      daysPerWeek: serializer.fromJson<int>(json['daysPerWeek']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'goal': serializer.toJson<String>(goal),
      'splitType': serializer.toJson<String>(splitType),
      'experienceLevel': serializer.toJson<String>(experienceLevel),
      'weeksCount': serializer.toJson<int>(weeksCount),
      'daysPerWeek': serializer.toJson<int>(daysPerWeek),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'notes': serializer.toJson<String?>(notes),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  Mesocycle copyWith({
    int? id,
    String? name,
    String? goal,
    String? splitType,
    String? experienceLevel,
    int? weeksCount,
    int? daysPerWeek,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> notes = const Value.absent(),
    bool? isArchived,
  }) => Mesocycle(
    id: id ?? this.id,
    name: name ?? this.name,
    goal: goal ?? this.goal,
    splitType: splitType ?? this.splitType,
    experienceLevel: experienceLevel ?? this.experienceLevel,
    weeksCount: weeksCount ?? this.weeksCount,
    daysPerWeek: daysPerWeek ?? this.daysPerWeek,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    notes: notes.present ? notes.value : this.notes,
    isArchived: isArchived ?? this.isArchived,
  );
  Mesocycle copyWithCompanion(MesocyclesCompanion data) {
    return Mesocycle(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      goal: data.goal.present ? data.goal.value : this.goal,
      splitType: data.splitType.present ? data.splitType.value : this.splitType,
      experienceLevel: data.experienceLevel.present
          ? data.experienceLevel.value
          : this.experienceLevel,
      weeksCount: data.weeksCount.present
          ? data.weeksCount.value
          : this.weeksCount,
      daysPerWeek: data.daysPerWeek.present
          ? data.daysPerWeek.value
          : this.daysPerWeek,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Mesocycle(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('goal: $goal, ')
          ..write('splitType: $splitType, ')
          ..write('experienceLevel: $experienceLevel, ')
          ..write('weeksCount: $weeksCount, ')
          ..write('daysPerWeek: $daysPerWeek, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    goal,
    splitType,
    experienceLevel,
    weeksCount,
    daysPerWeek,
    createdAt,
    updatedAt,
    notes,
    isArchived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mesocycle &&
          other.id == this.id &&
          other.name == this.name &&
          other.goal == this.goal &&
          other.splitType == this.splitType &&
          other.experienceLevel == this.experienceLevel &&
          other.weeksCount == this.weeksCount &&
          other.daysPerWeek == this.daysPerWeek &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.notes == this.notes &&
          other.isArchived == this.isArchived);
}

class MesocyclesCompanion extends UpdateCompanion<Mesocycle> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> goal;
  final Value<String> splitType;
  final Value<String> experienceLevel;
  final Value<int> weeksCount;
  final Value<int> daysPerWeek;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> notes;
  final Value<bool> isArchived;
  const MesocyclesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.goal = const Value.absent(),
    this.splitType = const Value.absent(),
    this.experienceLevel = const Value.absent(),
    this.weeksCount = const Value.absent(),
    this.daysPerWeek = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
  });
  MesocyclesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String goal,
    required String splitType,
    required String experienceLevel,
    required int weeksCount,
    required int daysPerWeek,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
  }) : name = Value(name),
       goal = Value(goal),
       splitType = Value(splitType),
       experienceLevel = Value(experienceLevel),
       weeksCount = Value(weeksCount),
       daysPerWeek = Value(daysPerWeek),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Mesocycle> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? goal,
    Expression<String>? splitType,
    Expression<String>? experienceLevel,
    Expression<int>? weeksCount,
    Expression<int>? daysPerWeek,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? notes,
    Expression<bool>? isArchived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (goal != null) 'goal': goal,
      if (splitType != null) 'split_type': splitType,
      if (experienceLevel != null) 'experience_level': experienceLevel,
      if (weeksCount != null) 'weeks_count': weeksCount,
      if (daysPerWeek != null) 'days_per_week': daysPerWeek,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (notes != null) 'notes': notes,
      if (isArchived != null) 'is_archived': isArchived,
    });
  }

  MesocyclesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? goal,
    Value<String>? splitType,
    Value<String>? experienceLevel,
    Value<int>? weeksCount,
    Value<int>? daysPerWeek,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? notes,
    Value<bool>? isArchived,
  }) {
    return MesocyclesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      goal: goal ?? this.goal,
      splitType: splitType ?? this.splitType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      weeksCount: weeksCount ?? this.weeksCount,
      daysPerWeek: daysPerWeek ?? this.daysPerWeek,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
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
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (splitType.present) {
      map['split_type'] = Variable<String>(splitType.value);
    }
    if (experienceLevel.present) {
      map['experience_level'] = Variable<String>(experienceLevel.value);
    }
    if (weeksCount.present) {
      map['weeks_count'] = Variable<int>(weeksCount.value);
    }
    if (daysPerWeek.present) {
      map['days_per_week'] = Variable<int>(daysPerWeek.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MesocyclesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('goal: $goal, ')
          ..write('splitType: $splitType, ')
          ..write('experienceLevel: $experienceLevel, ')
          ..write('weeksCount: $weeksCount, ')
          ..write('daysPerWeek: $daysPerWeek, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }
}

class $MesocycleWeeksTable extends MesocycleWeeks
    with TableInfo<$MesocycleWeeksTable, MesocycleWeek> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MesocycleWeeksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mesocycleIdMeta = const VerificationMeta(
    'mesocycleId',
  );
  @override
  late final GeneratedColumn<int> mesocycleId = GeneratedColumn<int>(
    'mesocycle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mesocycles (id)',
    ),
  );
  static const VerificationMeta _weekNumberMeta = const VerificationMeta(
    'weekNumber',
  );
  @override
  late final GeneratedColumn<int> weekNumber = GeneratedColumn<int>(
    'week_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phaseNameMeta = const VerificationMeta(
    'phaseName',
  );
  @override
  late final GeneratedColumn<String> phaseName = GeneratedColumn<String>(
    'phase_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volumeMultiplierMeta = const VerificationMeta(
    'volumeMultiplier',
  );
  @override
  late final GeneratedColumn<double> volumeMultiplier = GeneratedColumn<double>(
    'volume_multiplier',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _intensityMultiplierMeta =
      const VerificationMeta('intensityMultiplier');
  @override
  late final GeneratedColumn<double> intensityMultiplier =
      GeneratedColumn<double>(
        'intensity_multiplier',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(1.0),
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mesocycleId,
    weekNumber,
    phaseName,
    volumeMultiplier,
    intensityMultiplier,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mesocycle_weeks';
  @override
  VerificationContext validateIntegrity(
    Insertable<MesocycleWeek> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mesocycle_id')) {
      context.handle(
        _mesocycleIdMeta,
        mesocycleId.isAcceptableOrUnknown(
          data['mesocycle_id']!,
          _mesocycleIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mesocycleIdMeta);
    }
    if (data.containsKey('week_number')) {
      context.handle(
        _weekNumberMeta,
        weekNumber.isAcceptableOrUnknown(data['week_number']!, _weekNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_weekNumberMeta);
    }
    if (data.containsKey('phase_name')) {
      context.handle(
        _phaseNameMeta,
        phaseName.isAcceptableOrUnknown(data['phase_name']!, _phaseNameMeta),
      );
    } else if (isInserting) {
      context.missing(_phaseNameMeta);
    }
    if (data.containsKey('volume_multiplier')) {
      context.handle(
        _volumeMultiplierMeta,
        volumeMultiplier.isAcceptableOrUnknown(
          data['volume_multiplier']!,
          _volumeMultiplierMeta,
        ),
      );
    }
    if (data.containsKey('intensity_multiplier')) {
      context.handle(
        _intensityMultiplierMeta,
        intensityMultiplier.isAcceptableOrUnknown(
          data['intensity_multiplier']!,
          _intensityMultiplierMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MesocycleWeek map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MesocycleWeek(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mesocycleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mesocycle_id'],
      )!,
      weekNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_number'],
      )!,
      phaseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phase_name'],
      )!,
      volumeMultiplier: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_multiplier'],
      )!,
      intensityMultiplier: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}intensity_multiplier'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $MesocycleWeeksTable createAlias(String alias) {
    return $MesocycleWeeksTable(attachedDatabase, alias);
  }
}

class MesocycleWeek extends DataClass implements Insertable<MesocycleWeek> {
  final int id;
  final int mesocycleId;
  final int weekNumber;
  final String phaseName;
  final double volumeMultiplier;
  final double intensityMultiplier;
  final String? notes;
  const MesocycleWeek({
    required this.id,
    required this.mesocycleId,
    required this.weekNumber,
    required this.phaseName,
    required this.volumeMultiplier,
    required this.intensityMultiplier,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mesocycle_id'] = Variable<int>(mesocycleId);
    map['week_number'] = Variable<int>(weekNumber);
    map['phase_name'] = Variable<String>(phaseName);
    map['volume_multiplier'] = Variable<double>(volumeMultiplier);
    map['intensity_multiplier'] = Variable<double>(intensityMultiplier);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MesocycleWeeksCompanion toCompanion(bool nullToAbsent) {
    return MesocycleWeeksCompanion(
      id: Value(id),
      mesocycleId: Value(mesocycleId),
      weekNumber: Value(weekNumber),
      phaseName: Value(phaseName),
      volumeMultiplier: Value(volumeMultiplier),
      intensityMultiplier: Value(intensityMultiplier),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory MesocycleWeek.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MesocycleWeek(
      id: serializer.fromJson<int>(json['id']),
      mesocycleId: serializer.fromJson<int>(json['mesocycleId']),
      weekNumber: serializer.fromJson<int>(json['weekNumber']),
      phaseName: serializer.fromJson<String>(json['phaseName']),
      volumeMultiplier: serializer.fromJson<double>(json['volumeMultiplier']),
      intensityMultiplier: serializer.fromJson<double>(
        json['intensityMultiplier'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mesocycleId': serializer.toJson<int>(mesocycleId),
      'weekNumber': serializer.toJson<int>(weekNumber),
      'phaseName': serializer.toJson<String>(phaseName),
      'volumeMultiplier': serializer.toJson<double>(volumeMultiplier),
      'intensityMultiplier': serializer.toJson<double>(intensityMultiplier),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MesocycleWeek copyWith({
    int? id,
    int? mesocycleId,
    int? weekNumber,
    String? phaseName,
    double? volumeMultiplier,
    double? intensityMultiplier,
    Value<String?> notes = const Value.absent(),
  }) => MesocycleWeek(
    id: id ?? this.id,
    mesocycleId: mesocycleId ?? this.mesocycleId,
    weekNumber: weekNumber ?? this.weekNumber,
    phaseName: phaseName ?? this.phaseName,
    volumeMultiplier: volumeMultiplier ?? this.volumeMultiplier,
    intensityMultiplier: intensityMultiplier ?? this.intensityMultiplier,
    notes: notes.present ? notes.value : this.notes,
  );
  MesocycleWeek copyWithCompanion(MesocycleWeeksCompanion data) {
    return MesocycleWeek(
      id: data.id.present ? data.id.value : this.id,
      mesocycleId: data.mesocycleId.present
          ? data.mesocycleId.value
          : this.mesocycleId,
      weekNumber: data.weekNumber.present
          ? data.weekNumber.value
          : this.weekNumber,
      phaseName: data.phaseName.present ? data.phaseName.value : this.phaseName,
      volumeMultiplier: data.volumeMultiplier.present
          ? data.volumeMultiplier.value
          : this.volumeMultiplier,
      intensityMultiplier: data.intensityMultiplier.present
          ? data.intensityMultiplier.value
          : this.intensityMultiplier,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MesocycleWeek(')
          ..write('id: $id, ')
          ..write('mesocycleId: $mesocycleId, ')
          ..write('weekNumber: $weekNumber, ')
          ..write('phaseName: $phaseName, ')
          ..write('volumeMultiplier: $volumeMultiplier, ')
          ..write('intensityMultiplier: $intensityMultiplier, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mesocycleId,
    weekNumber,
    phaseName,
    volumeMultiplier,
    intensityMultiplier,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MesocycleWeek &&
          other.id == this.id &&
          other.mesocycleId == this.mesocycleId &&
          other.weekNumber == this.weekNumber &&
          other.phaseName == this.phaseName &&
          other.volumeMultiplier == this.volumeMultiplier &&
          other.intensityMultiplier == this.intensityMultiplier &&
          other.notes == this.notes);
}

class MesocycleWeeksCompanion extends UpdateCompanion<MesocycleWeek> {
  final Value<int> id;
  final Value<int> mesocycleId;
  final Value<int> weekNumber;
  final Value<String> phaseName;
  final Value<double> volumeMultiplier;
  final Value<double> intensityMultiplier;
  final Value<String?> notes;
  const MesocycleWeeksCompanion({
    this.id = const Value.absent(),
    this.mesocycleId = const Value.absent(),
    this.weekNumber = const Value.absent(),
    this.phaseName = const Value.absent(),
    this.volumeMultiplier = const Value.absent(),
    this.intensityMultiplier = const Value.absent(),
    this.notes = const Value.absent(),
  });
  MesocycleWeeksCompanion.insert({
    this.id = const Value.absent(),
    required int mesocycleId,
    required int weekNumber,
    required String phaseName,
    this.volumeMultiplier = const Value.absent(),
    this.intensityMultiplier = const Value.absent(),
    this.notes = const Value.absent(),
  }) : mesocycleId = Value(mesocycleId),
       weekNumber = Value(weekNumber),
       phaseName = Value(phaseName);
  static Insertable<MesocycleWeek> custom({
    Expression<int>? id,
    Expression<int>? mesocycleId,
    Expression<int>? weekNumber,
    Expression<String>? phaseName,
    Expression<double>? volumeMultiplier,
    Expression<double>? intensityMultiplier,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mesocycleId != null) 'mesocycle_id': mesocycleId,
      if (weekNumber != null) 'week_number': weekNumber,
      if (phaseName != null) 'phase_name': phaseName,
      if (volumeMultiplier != null) 'volume_multiplier': volumeMultiplier,
      if (intensityMultiplier != null)
        'intensity_multiplier': intensityMultiplier,
      if (notes != null) 'notes': notes,
    });
  }

  MesocycleWeeksCompanion copyWith({
    Value<int>? id,
    Value<int>? mesocycleId,
    Value<int>? weekNumber,
    Value<String>? phaseName,
    Value<double>? volumeMultiplier,
    Value<double>? intensityMultiplier,
    Value<String?>? notes,
  }) {
    return MesocycleWeeksCompanion(
      id: id ?? this.id,
      mesocycleId: mesocycleId ?? this.mesocycleId,
      weekNumber: weekNumber ?? this.weekNumber,
      phaseName: phaseName ?? this.phaseName,
      volumeMultiplier: volumeMultiplier ?? this.volumeMultiplier,
      intensityMultiplier: intensityMultiplier ?? this.intensityMultiplier,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mesocycleId.present) {
      map['mesocycle_id'] = Variable<int>(mesocycleId.value);
    }
    if (weekNumber.present) {
      map['week_number'] = Variable<int>(weekNumber.value);
    }
    if (phaseName.present) {
      map['phase_name'] = Variable<String>(phaseName.value);
    }
    if (volumeMultiplier.present) {
      map['volume_multiplier'] = Variable<double>(volumeMultiplier.value);
    }
    if (intensityMultiplier.present) {
      map['intensity_multiplier'] = Variable<double>(intensityMultiplier.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MesocycleWeeksCompanion(')
          ..write('id: $id, ')
          ..write('mesocycleId: $mesocycleId, ')
          ..write('weekNumber: $weekNumber, ')
          ..write('phaseName: $phaseName, ')
          ..write('volumeMultiplier: $volumeMultiplier, ')
          ..write('intensityMultiplier: $intensityMultiplier, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $MesocycleDaysTable extends MesocycleDays
    with TableInfo<$MesocycleDaysTable, MesocycleDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MesocycleDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mesocycleWeekIdMeta = const VerificationMeta(
    'mesocycleWeekId',
  );
  @override
  late final GeneratedColumn<int> mesocycleWeekId = GeneratedColumn<int>(
    'mesocycle_week_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mesocycle_weeks (id)',
    ),
  );
  static const VerificationMeta _dayNumberMeta = const VerificationMeta(
    'dayNumber',
  );
  @override
  late final GeneratedColumn<int> dayNumber = GeneratedColumn<int>(
    'day_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _splitLabelMeta = const VerificationMeta(
    'splitLabel',
  );
  @override
  late final GeneratedColumn<String> splitLabel = GeneratedColumn<String>(
    'split_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mesocycleWeekId,
    dayNumber,
    title,
    splitLabel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mesocycle_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<MesocycleDay> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mesocycle_week_id')) {
      context.handle(
        _mesocycleWeekIdMeta,
        mesocycleWeekId.isAcceptableOrUnknown(
          data['mesocycle_week_id']!,
          _mesocycleWeekIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mesocycleWeekIdMeta);
    }
    if (data.containsKey('day_number')) {
      context.handle(
        _dayNumberMeta,
        dayNumber.isAcceptableOrUnknown(data['day_number']!, _dayNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_dayNumberMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('split_label')) {
      context.handle(
        _splitLabelMeta,
        splitLabel.isAcceptableOrUnknown(data['split_label']!, _splitLabelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MesocycleDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MesocycleDay(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mesocycleWeekId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mesocycle_week_id'],
      )!,
      dayNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_number'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      splitLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}split_label'],
      ),
    );
  }

  @override
  $MesocycleDaysTable createAlias(String alias) {
    return $MesocycleDaysTable(attachedDatabase, alias);
  }
}

class MesocycleDay extends DataClass implements Insertable<MesocycleDay> {
  final int id;
  final int mesocycleWeekId;
  final int dayNumber;
  final String title;
  final String? splitLabel;
  const MesocycleDay({
    required this.id,
    required this.mesocycleWeekId,
    required this.dayNumber,
    required this.title,
    this.splitLabel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mesocycle_week_id'] = Variable<int>(mesocycleWeekId);
    map['day_number'] = Variable<int>(dayNumber);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || splitLabel != null) {
      map['split_label'] = Variable<String>(splitLabel);
    }
    return map;
  }

  MesocycleDaysCompanion toCompanion(bool nullToAbsent) {
    return MesocycleDaysCompanion(
      id: Value(id),
      mesocycleWeekId: Value(mesocycleWeekId),
      dayNumber: Value(dayNumber),
      title: Value(title),
      splitLabel: splitLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(splitLabel),
    );
  }

  factory MesocycleDay.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MesocycleDay(
      id: serializer.fromJson<int>(json['id']),
      mesocycleWeekId: serializer.fromJson<int>(json['mesocycleWeekId']),
      dayNumber: serializer.fromJson<int>(json['dayNumber']),
      title: serializer.fromJson<String>(json['title']),
      splitLabel: serializer.fromJson<String?>(json['splitLabel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mesocycleWeekId': serializer.toJson<int>(mesocycleWeekId),
      'dayNumber': serializer.toJson<int>(dayNumber),
      'title': serializer.toJson<String>(title),
      'splitLabel': serializer.toJson<String?>(splitLabel),
    };
  }

  MesocycleDay copyWith({
    int? id,
    int? mesocycleWeekId,
    int? dayNumber,
    String? title,
    Value<String?> splitLabel = const Value.absent(),
  }) => MesocycleDay(
    id: id ?? this.id,
    mesocycleWeekId: mesocycleWeekId ?? this.mesocycleWeekId,
    dayNumber: dayNumber ?? this.dayNumber,
    title: title ?? this.title,
    splitLabel: splitLabel.present ? splitLabel.value : this.splitLabel,
  );
  MesocycleDay copyWithCompanion(MesocycleDaysCompanion data) {
    return MesocycleDay(
      id: data.id.present ? data.id.value : this.id,
      mesocycleWeekId: data.mesocycleWeekId.present
          ? data.mesocycleWeekId.value
          : this.mesocycleWeekId,
      dayNumber: data.dayNumber.present ? data.dayNumber.value : this.dayNumber,
      title: data.title.present ? data.title.value : this.title,
      splitLabel: data.splitLabel.present
          ? data.splitLabel.value
          : this.splitLabel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MesocycleDay(')
          ..write('id: $id, ')
          ..write('mesocycleWeekId: $mesocycleWeekId, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('title: $title, ')
          ..write('splitLabel: $splitLabel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, mesocycleWeekId, dayNumber, title, splitLabel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MesocycleDay &&
          other.id == this.id &&
          other.mesocycleWeekId == this.mesocycleWeekId &&
          other.dayNumber == this.dayNumber &&
          other.title == this.title &&
          other.splitLabel == this.splitLabel);
}

class MesocycleDaysCompanion extends UpdateCompanion<MesocycleDay> {
  final Value<int> id;
  final Value<int> mesocycleWeekId;
  final Value<int> dayNumber;
  final Value<String> title;
  final Value<String?> splitLabel;
  const MesocycleDaysCompanion({
    this.id = const Value.absent(),
    this.mesocycleWeekId = const Value.absent(),
    this.dayNumber = const Value.absent(),
    this.title = const Value.absent(),
    this.splitLabel = const Value.absent(),
  });
  MesocycleDaysCompanion.insert({
    this.id = const Value.absent(),
    required int mesocycleWeekId,
    required int dayNumber,
    required String title,
    this.splitLabel = const Value.absent(),
  }) : mesocycleWeekId = Value(mesocycleWeekId),
       dayNumber = Value(dayNumber),
       title = Value(title);
  static Insertable<MesocycleDay> custom({
    Expression<int>? id,
    Expression<int>? mesocycleWeekId,
    Expression<int>? dayNumber,
    Expression<String>? title,
    Expression<String>? splitLabel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mesocycleWeekId != null) 'mesocycle_week_id': mesocycleWeekId,
      if (dayNumber != null) 'day_number': dayNumber,
      if (title != null) 'title': title,
      if (splitLabel != null) 'split_label': splitLabel,
    });
  }

  MesocycleDaysCompanion copyWith({
    Value<int>? id,
    Value<int>? mesocycleWeekId,
    Value<int>? dayNumber,
    Value<String>? title,
    Value<String?>? splitLabel,
  }) {
    return MesocycleDaysCompanion(
      id: id ?? this.id,
      mesocycleWeekId: mesocycleWeekId ?? this.mesocycleWeekId,
      dayNumber: dayNumber ?? this.dayNumber,
      title: title ?? this.title,
      splitLabel: splitLabel ?? this.splitLabel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mesocycleWeekId.present) {
      map['mesocycle_week_id'] = Variable<int>(mesocycleWeekId.value);
    }
    if (dayNumber.present) {
      map['day_number'] = Variable<int>(dayNumber.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (splitLabel.present) {
      map['split_label'] = Variable<String>(splitLabel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MesocycleDaysCompanion(')
          ..write('id: $id, ')
          ..write('mesocycleWeekId: $mesocycleWeekId, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('title: $title, ')
          ..write('splitLabel: $splitLabel')
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workout_templates (id)',
    ),
  );
  static const VerificationMeta _dayIdMeta = const VerificationMeta('dayId');
  @override
  late final GeneratedColumn<int> dayId = GeneratedColumn<int>(
    'day_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES template_days (id)',
    ),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _mesocycleIdMeta = const VerificationMeta(
    'mesocycleId',
  );
  @override
  late final GeneratedColumn<int> mesocycleId = GeneratedColumn<int>(
    'mesocycle_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mesocycles (id)',
    ),
  );
  static const VerificationMeta _mesocycleWeekIdMeta = const VerificationMeta(
    'mesocycleWeekId',
  );
  @override
  late final GeneratedColumn<int> mesocycleWeekId = GeneratedColumn<int>(
    'mesocycle_week_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mesocycle_weeks (id)',
    ),
  );
  static const VerificationMeta _mesocycleDayIdMeta = const VerificationMeta(
    'mesocycleDayId',
  );
  @override
  late final GeneratedColumn<int> mesocycleDayId = GeneratedColumn<int>(
    'mesocycle_day_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mesocycle_days (id)',
    ),
  );
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
    status,
    mesocycleId,
    mesocycleWeekId,
    mesocycleDayId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Workout> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('day_id')) {
      context.handle(
        _dayIdMeta,
        dayId.isAcceptableOrUnknown(data['day_id']!, _dayIdMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('mesocycle_id')) {
      context.handle(
        _mesocycleIdMeta,
        mesocycleId.isAcceptableOrUnknown(
          data['mesocycle_id']!,
          _mesocycleIdMeta,
        ),
      );
    }
    if (data.containsKey('mesocycle_week_id')) {
      context.handle(
        _mesocycleWeekIdMeta,
        mesocycleWeekId.isAcceptableOrUnknown(
          data['mesocycle_week_id']!,
          _mesocycleWeekIdMeta,
        ),
      );
    }
    if (data.containsKey('mesocycle_day_id')) {
      context.handle(
        _mesocycleDayIdMeta,
        mesocycleDayId.isAcceptableOrUnknown(
          data['mesocycle_day_id']!,
          _mesocycleDayIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workout(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      ),
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      ),
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}template_id'],
      ),
      dayId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      mesocycleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mesocycle_id'],
      ),
      mesocycleWeekId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mesocycle_week_id'],
      ),
      mesocycleDayId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mesocycle_day_id'],
      ),
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
  final int? mesocycleId;
  final int? mesocycleWeekId;
  final int? mesocycleDayId;
  const Workout({
    required this.id,
    required this.name,
    required this.date,
    this.startTime,
    this.endTime,
    this.duration,
    this.templateId,
    this.dayId,
    this.notes,
    required this.status,
    this.mesocycleId,
    this.mesocycleWeekId,
    this.mesocycleDayId,
  });
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
    if (!nullToAbsent || mesocycleId != null) {
      map['mesocycle_id'] = Variable<int>(mesocycleId);
    }
    if (!nullToAbsent || mesocycleWeekId != null) {
      map['mesocycle_week_id'] = Variable<int>(mesocycleWeekId);
    }
    if (!nullToAbsent || mesocycleDayId != null) {
      map['mesocycle_day_id'] = Variable<int>(mesocycleDayId);
    }
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
      dayId: dayId == null && nullToAbsent
          ? const Value.absent()
          : Value(dayId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      mesocycleId: mesocycleId == null && nullToAbsent
          ? const Value.absent()
          : Value(mesocycleId),
      mesocycleWeekId: mesocycleWeekId == null && nullToAbsent
          ? const Value.absent()
          : Value(mesocycleWeekId),
      mesocycleDayId: mesocycleDayId == null && nullToAbsent
          ? const Value.absent()
          : Value(mesocycleDayId),
    );
  }

  factory Workout.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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
      mesocycleId: serializer.fromJson<int?>(json['mesocycleId']),
      mesocycleWeekId: serializer.fromJson<int?>(json['mesocycleWeekId']),
      mesocycleDayId: serializer.fromJson<int?>(json['mesocycleDayId']),
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
      'mesocycleId': serializer.toJson<int?>(mesocycleId),
      'mesocycleWeekId': serializer.toJson<int?>(mesocycleWeekId),
      'mesocycleDayId': serializer.toJson<int?>(mesocycleDayId),
    };
  }

  Workout copyWith({
    int? id,
    String? name,
    DateTime? date,
    Value<DateTime?> startTime = const Value.absent(),
    Value<DateTime?> endTime = const Value.absent(),
    Value<int?> duration = const Value.absent(),
    Value<int?> templateId = const Value.absent(),
    Value<int?> dayId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? status,
    Value<int?> mesocycleId = const Value.absent(),
    Value<int?> mesocycleWeekId = const Value.absent(),
    Value<int?> mesocycleDayId = const Value.absent(),
  }) => Workout(
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
    mesocycleId: mesocycleId.present ? mesocycleId.value : this.mesocycleId,
    mesocycleWeekId: mesocycleWeekId.present
        ? mesocycleWeekId.value
        : this.mesocycleWeekId,
    mesocycleDayId: mesocycleDayId.present
        ? mesocycleDayId.value
        : this.mesocycleDayId,
  );
  Workout copyWithCompanion(WorkoutsCompanion data) {
    return Workout(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      date: data.date.present ? data.date.value : this.date,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      duration: data.duration.present ? data.duration.value : this.duration,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      dayId: data.dayId.present ? data.dayId.value : this.dayId,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      mesocycleId: data.mesocycleId.present
          ? data.mesocycleId.value
          : this.mesocycleId,
      mesocycleWeekId: data.mesocycleWeekId.present
          ? data.mesocycleWeekId.value
          : this.mesocycleWeekId,
      mesocycleDayId: data.mesocycleDayId.present
          ? data.mesocycleDayId.value
          : this.mesocycleDayId,
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
          ..write('status: $status, ')
          ..write('mesocycleId: $mesocycleId, ')
          ..write('mesocycleWeekId: $mesocycleWeekId, ')
          ..write('mesocycleDayId: $mesocycleDayId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    date,
    startTime,
    endTime,
    duration,
    templateId,
    dayId,
    notes,
    status,
    mesocycleId,
    mesocycleWeekId,
    mesocycleDayId,
  );
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
          other.status == this.status &&
          other.mesocycleId == this.mesocycleId &&
          other.mesocycleWeekId == this.mesocycleWeekId &&
          other.mesocycleDayId == this.mesocycleDayId);
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
  final Value<int?> mesocycleId;
  final Value<int?> mesocycleWeekId;
  final Value<int?> mesocycleDayId;
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
    this.mesocycleId = const Value.absent(),
    this.mesocycleWeekId = const Value.absent(),
    this.mesocycleDayId = const Value.absent(),
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
    this.mesocycleId = const Value.absent(),
    this.mesocycleWeekId = const Value.absent(),
    this.mesocycleDayId = const Value.absent(),
  }) : name = Value(name),
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
    Expression<int>? mesocycleId,
    Expression<int>? mesocycleWeekId,
    Expression<int>? mesocycleDayId,
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
      if (mesocycleId != null) 'mesocycle_id': mesocycleId,
      if (mesocycleWeekId != null) 'mesocycle_week_id': mesocycleWeekId,
      if (mesocycleDayId != null) 'mesocycle_day_id': mesocycleDayId,
    });
  }

  WorkoutsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? date,
    Value<DateTime?>? startTime,
    Value<DateTime?>? endTime,
    Value<int?>? duration,
    Value<int?>? templateId,
    Value<int?>? dayId,
    Value<String?>? notes,
    Value<String>? status,
    Value<int?>? mesocycleId,
    Value<int?>? mesocycleWeekId,
    Value<int?>? mesocycleDayId,
  }) {
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
      mesocycleId: mesocycleId ?? this.mesocycleId,
      mesocycleWeekId: mesocycleWeekId ?? this.mesocycleWeekId,
      mesocycleDayId: mesocycleDayId ?? this.mesocycleDayId,
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
    if (mesocycleId.present) {
      map['mesocycle_id'] = Variable<int>(mesocycleId.value);
    }
    if (mesocycleWeekId.present) {
      map['mesocycle_week_id'] = Variable<int>(mesocycleWeekId.value);
    }
    if (mesocycleDayId.present) {
      map['mesocycle_day_id'] = Variable<int>(mesocycleDayId.value);
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
          ..write('status: $status, ')
          ..write('mesocycleId: $mesocycleId, ')
          ..write('mesocycleWeekId: $mesocycleWeekId, ')
          ..write('mesocycleDayId: $mesocycleDayId')
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _workoutIdMeta = const VerificationMeta(
    'workoutId',
  );
  @override
  late final GeneratedColumn<int> workoutId = GeneratedColumn<int>(
    'workout_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workouts (id)',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _exerciseOrderMeta = const VerificationMeta(
    'exerciseOrder',
  );
  @override
  late final GeneratedColumn<int> exerciseOrder = GeneratedColumn<int>(
    'exercise_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setNumberMeta = const VerificationMeta(
    'setNumber',
  );
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
    'set_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<double> reps = GeneratedColumn<double>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<double> rpe = GeneratedColumn<double>(
    'rpe',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rirMeta = const VerificationMeta('rir');
  @override
  late final GeneratedColumn<int> rir = GeneratedColumn<int>(
    'rir',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SetType, int> setType =
      GeneratedColumn<int>(
        'set_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<SetType>($WorkoutSetsTable.$convertersetType);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPrMeta = const VerificationMeta('isPr');
  @override
  late final GeneratedColumn<bool> isPr = GeneratedColumn<bool>(
    'is_pr',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pr" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _supersetGroupIdMeta = const VerificationMeta(
    'supersetGroupId',
  );
  @override
  late final GeneratedColumn<String> supersetGroupId = GeneratedColumn<String>(
    'superset_group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subSetsJsonMeta = const VerificationMeta(
    'subSetsJson',
  );
  @override
  late final GeneratedColumn<String> subSetsJson = GeneratedColumn<String>(
    'sub_sets_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
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
    rir,
    setType,
    notes,
    completed,
    completedAt,
    isPr,
    supersetGroupId,
    subSetsJson,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('workout_id')) {
      context.handle(
        _workoutIdMeta,
        workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workoutIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('exercise_order')) {
      context.handle(
        _exerciseOrderMeta,
        exerciseOrder.isAcceptableOrUnknown(
          data['exercise_order']!,
          _exerciseOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseOrderMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(
        _setNumberMeta,
        setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('rpe')) {
      context.handle(
        _rpeMeta,
        rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta),
      );
    }
    if (data.containsKey('rir')) {
      context.handle(
        _rirMeta,
        rir.isAcceptableOrUnknown(data['rir']!, _rirMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('is_pr')) {
      context.handle(
        _isPrMeta,
        isPr.isAcceptableOrUnknown(data['is_pr']!, _isPrMeta),
      );
    }
    if (data.containsKey('superset_group_id')) {
      context.handle(
        _supersetGroupIdMeta,
        supersetGroupId.isAcceptableOrUnknown(
          data['superset_group_id']!,
          _supersetGroupIdMeta,
        ),
      );
    }
    if (data.containsKey('sub_sets_json')) {
      context.handle(
        _subSetsJsonMeta,
        subSetsJson.isAcceptableOrUnknown(
          data['sub_sets_json']!,
          _subSetsJsonMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      workoutId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workout_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      exerciseOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_order'],
      )!,
      setNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_number'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reps'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      rpe: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rpe'],
      ),
      rir: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rir'],
      ),
      setType: $WorkoutSetsTable.$convertersetType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}set_type'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      isPr: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pr'],
      )!,
      supersetGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}superset_group_id'],
      ),
      subSetsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_sets_json'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
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
  final int? rir;
  final SetType setType;
  final String? notes;
  final bool completed;
  final DateTime? completedAt;
  final bool isPr;
  final String? supersetGroupId;
  final String? subSetsJson;
  final bool isFavorite;
  const WorkoutSet({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    required this.exerciseOrder,
    required this.setNumber,
    required this.reps,
    required this.weight,
    this.rpe,
    this.rir,
    required this.setType,
    this.notes,
    required this.completed,
    this.completedAt,
    required this.isPr,
    this.supersetGroupId,
    this.subSetsJson,
    required this.isFavorite,
  });
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
    if (!nullToAbsent || rir != null) {
      map['rir'] = Variable<int>(rir);
    }
    {
      map['set_type'] = Variable<int>(
        $WorkoutSetsTable.$convertersetType.toSql(setType),
      );
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
    map['is_favorite'] = Variable<bool>(isFavorite);
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
      rir: rir == null && nullToAbsent ? const Value.absent() : Value(rir),
      setType: Value(setType),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
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
      isFavorite: Value(isFavorite),
    );
  }

  factory WorkoutSet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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
      rir: serializer.fromJson<int?>(json['rir']),
      setType: $WorkoutSetsTable.$convertersetType.fromJson(
        serializer.fromJson<int>(json['setType']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      completed: serializer.fromJson<bool>(json['completed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      isPr: serializer.fromJson<bool>(json['isPr']),
      supersetGroupId: serializer.fromJson<String?>(json['supersetGroupId']),
      subSetsJson: serializer.fromJson<String?>(json['subSetsJson']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
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
      'rir': serializer.toJson<int?>(rir),
      'setType': serializer.toJson<int>(
        $WorkoutSetsTable.$convertersetType.toJson(setType),
      ),
      'notes': serializer.toJson<String?>(notes),
      'completed': serializer.toJson<bool>(completed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'isPr': serializer.toJson<bool>(isPr),
      'supersetGroupId': serializer.toJson<String?>(supersetGroupId),
      'subSetsJson': serializer.toJson<String?>(subSetsJson),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  WorkoutSet copyWith({
    int? id,
    int? workoutId,
    int? exerciseId,
    int? exerciseOrder,
    int? setNumber,
    double? reps,
    double? weight,
    Value<double?> rpe = const Value.absent(),
    Value<int?> rir = const Value.absent(),
    SetType? setType,
    Value<String?> notes = const Value.absent(),
    bool? completed,
    Value<DateTime?> completedAt = const Value.absent(),
    bool? isPr,
    Value<String?> supersetGroupId = const Value.absent(),
    Value<String?> subSetsJson = const Value.absent(),
    bool? isFavorite,
  }) => WorkoutSet(
    id: id ?? this.id,
    workoutId: workoutId ?? this.workoutId,
    exerciseId: exerciseId ?? this.exerciseId,
    exerciseOrder: exerciseOrder ?? this.exerciseOrder,
    setNumber: setNumber ?? this.setNumber,
    reps: reps ?? this.reps,
    weight: weight ?? this.weight,
    rpe: rpe.present ? rpe.value : this.rpe,
    rir: rir.present ? rir.value : this.rir,
    setType: setType ?? this.setType,
    notes: notes.present ? notes.value : this.notes,
    completed: completed ?? this.completed,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    isPr: isPr ?? this.isPr,
    supersetGroupId: supersetGroupId.present
        ? supersetGroupId.value
        : this.supersetGroupId,
    subSetsJson: subSetsJson.present ? subSetsJson.value : this.subSetsJson,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  WorkoutSet copyWithCompanion(WorkoutSetsCompanion data) {
    return WorkoutSet(
      id: data.id.present ? data.id.value : this.id,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      exerciseOrder: data.exerciseOrder.present
          ? data.exerciseOrder.value
          : this.exerciseOrder,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      reps: data.reps.present ? data.reps.value : this.reps,
      weight: data.weight.present ? data.weight.value : this.weight,
      rpe: data.rpe.present ? data.rpe.value : this.rpe,
      rir: data.rir.present ? data.rir.value : this.rir,
      setType: data.setType.present ? data.setType.value : this.setType,
      notes: data.notes.present ? data.notes.value : this.notes,
      completed: data.completed.present ? data.completed.value : this.completed,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      isPr: data.isPr.present ? data.isPr.value : this.isPr,
      supersetGroupId: data.supersetGroupId.present
          ? data.supersetGroupId.value
          : this.supersetGroupId,
      subSetsJson: data.subSetsJson.present
          ? data.subSetsJson.value
          : this.subSetsJson,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
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
          ..write('rir: $rir, ')
          ..write('setType: $setType, ')
          ..write('notes: $notes, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('isPr: $isPr, ')
          ..write('supersetGroupId: $supersetGroupId, ')
          ..write('subSetsJson: $subSetsJson, ')
          ..write('isFavorite: $isFavorite')
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
    rir,
    setType,
    notes,
    completed,
    completedAt,
    isPr,
    supersetGroupId,
    subSetsJson,
    isFavorite,
  );
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
          other.rir == this.rir &&
          other.setType == this.setType &&
          other.notes == this.notes &&
          other.completed == this.completed &&
          other.completedAt == this.completedAt &&
          other.isPr == this.isPr &&
          other.supersetGroupId == this.supersetGroupId &&
          other.subSetsJson == this.subSetsJson &&
          other.isFavorite == this.isFavorite);
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
  final Value<int?> rir;
  final Value<SetType> setType;
  final Value<String?> notes;
  final Value<bool> completed;
  final Value<DateTime?> completedAt;
  final Value<bool> isPr;
  final Value<String?> supersetGroupId;
  final Value<String?> subSetsJson;
  final Value<bool> isFavorite;
  const WorkoutSetsCompanion({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.exerciseOrder = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.reps = const Value.absent(),
    this.weight = const Value.absent(),
    this.rpe = const Value.absent(),
    this.rir = const Value.absent(),
    this.setType = const Value.absent(),
    this.notes = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isPr = const Value.absent(),
    this.supersetGroupId = const Value.absent(),
    this.subSetsJson = const Value.absent(),
    this.isFavorite = const Value.absent(),
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
    this.rir = const Value.absent(),
    this.setType = const Value.absent(),
    this.notes = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isPr = const Value.absent(),
    this.supersetGroupId = const Value.absent(),
    this.subSetsJson = const Value.absent(),
    this.isFavorite = const Value.absent(),
  }) : workoutId = Value(workoutId),
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
    Expression<int>? rir,
    Expression<int>? setType,
    Expression<String>? notes,
    Expression<bool>? completed,
    Expression<DateTime>? completedAt,
    Expression<bool>? isPr,
    Expression<String>? supersetGroupId,
    Expression<String>? subSetsJson,
    Expression<bool>? isFavorite,
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
      if (rir != null) 'rir': rir,
      if (setType != null) 'set_type': setType,
      if (notes != null) 'notes': notes,
      if (completed != null) 'completed': completed,
      if (completedAt != null) 'completed_at': completedAt,
      if (isPr != null) 'is_pr': isPr,
      if (supersetGroupId != null) 'superset_group_id': supersetGroupId,
      if (subSetsJson != null) 'sub_sets_json': subSetsJson,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  WorkoutSetsCompanion copyWith({
    Value<int>? id,
    Value<int>? workoutId,
    Value<int>? exerciseId,
    Value<int>? exerciseOrder,
    Value<int>? setNumber,
    Value<double>? reps,
    Value<double>? weight,
    Value<double?>? rpe,
    Value<int?>? rir,
    Value<SetType>? setType,
    Value<String?>? notes,
    Value<bool>? completed,
    Value<DateTime?>? completedAt,
    Value<bool>? isPr,
    Value<String?>? supersetGroupId,
    Value<String?>? subSetsJson,
    Value<bool>? isFavorite,
  }) {
    return WorkoutSetsCompanion(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseOrder: exerciseOrder ?? this.exerciseOrder,
      setNumber: setNumber ?? this.setNumber,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      rpe: rpe ?? this.rpe,
      rir: rir ?? this.rir,
      setType: setType ?? this.setType,
      notes: notes ?? this.notes,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
      isPr: isPr ?? this.isPr,
      supersetGroupId: supersetGroupId ?? this.supersetGroupId,
      subSetsJson: subSetsJson ?? this.subSetsJson,
      isFavorite: isFavorite ?? this.isFavorite,
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
    if (rir.present) {
      map['rir'] = Variable<int>(rir.value);
    }
    if (setType.present) {
      map['set_type'] = Variable<int>(
        $WorkoutSetsTable.$convertersetType.toSql(setType.value),
      );
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
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
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
          ..write('rir: $rir, ')
          ..write('setType: $setType, ')
          ..write('notes: $notes, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('isPr: $isPr, ')
          ..write('supersetGroupId: $supersetGroupId, ')
          ..write('subSetsJson: $subSetsJson, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $BodyMeasurementsTable extends BodyMeasurements
    with TableInfo<$BodyMeasurementsTable, BodyMeasurementTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyMeasurementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyFatMeta = const VerificationMeta(
    'bodyFat',
  );
  @override
  late final GeneratedColumn<double> bodyFat = GeneratedColumn<double>(
    'body_fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _neckMeta = const VerificationMeta('neck');
  @override
  late final GeneratedColumn<double> neck = GeneratedColumn<double>(
    'neck',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chestMeta = const VerificationMeta('chest');
  @override
  late final GeneratedColumn<double> chest = GeneratedColumn<double>(
    'chest',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shouldersMeta = const VerificationMeta(
    'shoulders',
  );
  @override
  late final GeneratedColumn<double> shoulders = GeneratedColumn<double>(
    'shoulders',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _armLeftMeta = const VerificationMeta(
    'armLeft',
  );
  @override
  late final GeneratedColumn<double> armLeft = GeneratedColumn<double>(
    'arm_left',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _armRightMeta = const VerificationMeta(
    'armRight',
  );
  @override
  late final GeneratedColumn<double> armRight = GeneratedColumn<double>(
    'arm_right',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _forearmLeftMeta = const VerificationMeta(
    'forearmLeft',
  );
  @override
  late final GeneratedColumn<double> forearmLeft = GeneratedColumn<double>(
    'forearm_left',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _forearmRightMeta = const VerificationMeta(
    'forearmRight',
  );
  @override
  late final GeneratedColumn<double> forearmRight = GeneratedColumn<double>(
    'forearm_right',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waistMeta = const VerificationMeta('waist');
  @override
  late final GeneratedColumn<double> waist = GeneratedColumn<double>(
    'waist',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waistNavalMeta = const VerificationMeta(
    'waistNaval',
  );
  @override
  late final GeneratedColumn<double> waistNaval = GeneratedColumn<double>(
    'waist_naval',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hipsMeta = const VerificationMeta('hips');
  @override
  late final GeneratedColumn<double> hips = GeneratedColumn<double>(
    'hips',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thighLeftMeta = const VerificationMeta(
    'thighLeft',
  );
  @override
  late final GeneratedColumn<double> thighLeft = GeneratedColumn<double>(
    'thigh_left',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thighRightMeta = const VerificationMeta(
    'thighRight',
  );
  @override
  late final GeneratedColumn<double> thighRight = GeneratedColumn<double>(
    'thigh_right',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _calfLeftMeta = const VerificationMeta(
    'calfLeft',
  );
  @override
  late final GeneratedColumn<double> calfLeft = GeneratedColumn<double>(
    'calf_left',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _calfRightMeta = const VerificationMeta(
    'calfRight',
  );
  @override
  late final GeneratedColumn<double> calfRight = GeneratedColumn<double>(
    'calf_right',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subcutaneousFatMeta = const VerificationMeta(
    'subcutaneousFat',
  );
  @override
  late final GeneratedColumn<double> subcutaneousFat = GeneratedColumn<double>(
    'subcutaneous_fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _visceralFatMeta = const VerificationMeta(
    'visceralFat',
  );
  @override
  late final GeneratedColumn<double> visceralFat = GeneratedColumn<double>(
    'visceral_fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customValuesMeta = const VerificationMeta(
    'customValues',
  );
  @override
  late final GeneratedColumn<String> customValues = GeneratedColumn<String>(
    'custom_values',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    weight,
    bodyFat,
    neck,
    chest,
    shoulders,
    armLeft,
    armRight,
    forearmLeft,
    forearmRight,
    waist,
    waistNaval,
    hips,
    thighLeft,
    thighRight,
    calfLeft,
    calfRight,
    height,
    subcutaneousFat,
    visceralFat,
    customValues,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_measurements';
  @override
  VerificationContext validateIntegrity(
    Insertable<BodyMeasurementTable> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('body_fat')) {
      context.handle(
        _bodyFatMeta,
        bodyFat.isAcceptableOrUnknown(data['body_fat']!, _bodyFatMeta),
      );
    }
    if (data.containsKey('neck')) {
      context.handle(
        _neckMeta,
        neck.isAcceptableOrUnknown(data['neck']!, _neckMeta),
      );
    }
    if (data.containsKey('chest')) {
      context.handle(
        _chestMeta,
        chest.isAcceptableOrUnknown(data['chest']!, _chestMeta),
      );
    }
    if (data.containsKey('shoulders')) {
      context.handle(
        _shouldersMeta,
        shoulders.isAcceptableOrUnknown(data['shoulders']!, _shouldersMeta),
      );
    }
    if (data.containsKey('arm_left')) {
      context.handle(
        _armLeftMeta,
        armLeft.isAcceptableOrUnknown(data['arm_left']!, _armLeftMeta),
      );
    }
    if (data.containsKey('arm_right')) {
      context.handle(
        _armRightMeta,
        armRight.isAcceptableOrUnknown(data['arm_right']!, _armRightMeta),
      );
    }
    if (data.containsKey('forearm_left')) {
      context.handle(
        _forearmLeftMeta,
        forearmLeft.isAcceptableOrUnknown(
          data['forearm_left']!,
          _forearmLeftMeta,
        ),
      );
    }
    if (data.containsKey('forearm_right')) {
      context.handle(
        _forearmRightMeta,
        forearmRight.isAcceptableOrUnknown(
          data['forearm_right']!,
          _forearmRightMeta,
        ),
      );
    }
    if (data.containsKey('waist')) {
      context.handle(
        _waistMeta,
        waist.isAcceptableOrUnknown(data['waist']!, _waistMeta),
      );
    }
    if (data.containsKey('waist_naval')) {
      context.handle(
        _waistNavalMeta,
        waistNaval.isAcceptableOrUnknown(data['waist_naval']!, _waistNavalMeta),
      );
    }
    if (data.containsKey('hips')) {
      context.handle(
        _hipsMeta,
        hips.isAcceptableOrUnknown(data['hips']!, _hipsMeta),
      );
    }
    if (data.containsKey('thigh_left')) {
      context.handle(
        _thighLeftMeta,
        thighLeft.isAcceptableOrUnknown(data['thigh_left']!, _thighLeftMeta),
      );
    }
    if (data.containsKey('thigh_right')) {
      context.handle(
        _thighRightMeta,
        thighRight.isAcceptableOrUnknown(data['thigh_right']!, _thighRightMeta),
      );
    }
    if (data.containsKey('calf_left')) {
      context.handle(
        _calfLeftMeta,
        calfLeft.isAcceptableOrUnknown(data['calf_left']!, _calfLeftMeta),
      );
    }
    if (data.containsKey('calf_right')) {
      context.handle(
        _calfRightMeta,
        calfRight.isAcceptableOrUnknown(data['calf_right']!, _calfRightMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('subcutaneous_fat')) {
      context.handle(
        _subcutaneousFatMeta,
        subcutaneousFat.isAcceptableOrUnknown(
          data['subcutaneous_fat']!,
          _subcutaneousFatMeta,
        ),
      );
    }
    if (data.containsKey('visceral_fat')) {
      context.handle(
        _visceralFatMeta,
        visceralFat.isAcceptableOrUnknown(
          data['visceral_fat']!,
          _visceralFatMeta,
        ),
      );
    }
    if (data.containsKey('custom_values')) {
      context.handle(
        _customValuesMeta,
        customValues.isAcceptableOrUnknown(
          data['custom_values']!,
          _customValuesMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BodyMeasurementTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyMeasurementTable(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      ),
      bodyFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}body_fat'],
      ),
      neck: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}neck'],
      ),
      chest: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}chest'],
      ),
      shoulders: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shoulders'],
      ),
      armLeft: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}arm_left'],
      ),
      armRight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}arm_right'],
      ),
      forearmLeft: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}forearm_left'],
      ),
      forearmRight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}forearm_right'],
      ),
      waist: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}waist'],
      ),
      waistNaval: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}waist_naval'],
      ),
      hips: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hips'],
      ),
      thighLeft: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}thigh_left'],
      ),
      thighRight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}thigh_right'],
      ),
      calfLeft: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calf_left'],
      ),
      calfRight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calf_right'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      ),
      subcutaneousFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subcutaneous_fat'],
      ),
      visceralFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}visceral_fat'],
      ),
      customValues: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_values'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $BodyMeasurementsTable createAlias(String alias) {
    return $BodyMeasurementsTable(attachedDatabase, alias);
  }
}

class BodyMeasurementTable extends DataClass
    implements Insertable<BodyMeasurementTable> {
  final int id;
  final DateTime date;
  final double? weight;
  final double? bodyFat;
  final double? neck;
  final double? chest;
  final double? shoulders;
  final double? armLeft;
  final double? armRight;
  final double? forearmLeft;
  final double? forearmRight;
  final double? waist;
  final double? waistNaval;
  final double? hips;
  final double? thighLeft;
  final double? thighRight;
  final double? calfLeft;
  final double? calfRight;
  final double? height;
  final double? subcutaneousFat;
  final double? visceralFat;
  final String? customValues;
  final String? notes;
  const BodyMeasurementTable({
    required this.id,
    required this.date,
    this.weight,
    this.bodyFat,
    this.neck,
    this.chest,
    this.shoulders,
    this.armLeft,
    this.armRight,
    this.forearmLeft,
    this.forearmRight,
    this.waist,
    this.waistNaval,
    this.hips,
    this.thighLeft,
    this.thighRight,
    this.calfLeft,
    this.calfRight,
    this.height,
    this.subcutaneousFat,
    this.visceralFat,
    this.customValues,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || bodyFat != null) {
      map['body_fat'] = Variable<double>(bodyFat);
    }
    if (!nullToAbsent || neck != null) {
      map['neck'] = Variable<double>(neck);
    }
    if (!nullToAbsent || chest != null) {
      map['chest'] = Variable<double>(chest);
    }
    if (!nullToAbsent || shoulders != null) {
      map['shoulders'] = Variable<double>(shoulders);
    }
    if (!nullToAbsent || armLeft != null) {
      map['arm_left'] = Variable<double>(armLeft);
    }
    if (!nullToAbsent || armRight != null) {
      map['arm_right'] = Variable<double>(armRight);
    }
    if (!nullToAbsent || forearmLeft != null) {
      map['forearm_left'] = Variable<double>(forearmLeft);
    }
    if (!nullToAbsent || forearmRight != null) {
      map['forearm_right'] = Variable<double>(forearmRight);
    }
    if (!nullToAbsent || waist != null) {
      map['waist'] = Variable<double>(waist);
    }
    if (!nullToAbsent || waistNaval != null) {
      map['waist_naval'] = Variable<double>(waistNaval);
    }
    if (!nullToAbsent || hips != null) {
      map['hips'] = Variable<double>(hips);
    }
    if (!nullToAbsent || thighLeft != null) {
      map['thigh_left'] = Variable<double>(thighLeft);
    }
    if (!nullToAbsent || thighRight != null) {
      map['thigh_right'] = Variable<double>(thighRight);
    }
    if (!nullToAbsent || calfLeft != null) {
      map['calf_left'] = Variable<double>(calfLeft);
    }
    if (!nullToAbsent || calfRight != null) {
      map['calf_right'] = Variable<double>(calfRight);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    if (!nullToAbsent || subcutaneousFat != null) {
      map['subcutaneous_fat'] = Variable<double>(subcutaneousFat);
    }
    if (!nullToAbsent || visceralFat != null) {
      map['visceral_fat'] = Variable<double>(visceralFat);
    }
    if (!nullToAbsent || customValues != null) {
      map['custom_values'] = Variable<String>(customValues);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  BodyMeasurementsCompanion toCompanion(bool nullToAbsent) {
    return BodyMeasurementsCompanion(
      id: Value(id),
      date: Value(date),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      bodyFat: bodyFat == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFat),
      neck: neck == null && nullToAbsent ? const Value.absent() : Value(neck),
      chest: chest == null && nullToAbsent
          ? const Value.absent()
          : Value(chest),
      shoulders: shoulders == null && nullToAbsent
          ? const Value.absent()
          : Value(shoulders),
      armLeft: armLeft == null && nullToAbsent
          ? const Value.absent()
          : Value(armLeft),
      armRight: armRight == null && nullToAbsent
          ? const Value.absent()
          : Value(armRight),
      forearmLeft: forearmLeft == null && nullToAbsent
          ? const Value.absent()
          : Value(forearmLeft),
      forearmRight: forearmRight == null && nullToAbsent
          ? const Value.absent()
          : Value(forearmRight),
      waist: waist == null && nullToAbsent
          ? const Value.absent()
          : Value(waist),
      waistNaval: waistNaval == null && nullToAbsent
          ? const Value.absent()
          : Value(waistNaval),
      hips: hips == null && nullToAbsent ? const Value.absent() : Value(hips),
      thighLeft: thighLeft == null && nullToAbsent
          ? const Value.absent()
          : Value(thighLeft),
      thighRight: thighRight == null && nullToAbsent
          ? const Value.absent()
          : Value(thighRight),
      calfLeft: calfLeft == null && nullToAbsent
          ? const Value.absent()
          : Value(calfLeft),
      calfRight: calfRight == null && nullToAbsent
          ? const Value.absent()
          : Value(calfRight),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      subcutaneousFat: subcutaneousFat == null && nullToAbsent
          ? const Value.absent()
          : Value(subcutaneousFat),
      visceralFat: visceralFat == null && nullToAbsent
          ? const Value.absent()
          : Value(visceralFat),
      customValues: customValues == null && nullToAbsent
          ? const Value.absent()
          : Value(customValues),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory BodyMeasurementTable.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyMeasurementTable(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double?>(json['weight']),
      bodyFat: serializer.fromJson<double?>(json['bodyFat']),
      neck: serializer.fromJson<double?>(json['neck']),
      chest: serializer.fromJson<double?>(json['chest']),
      shoulders: serializer.fromJson<double?>(json['shoulders']),
      armLeft: serializer.fromJson<double?>(json['armLeft']),
      armRight: serializer.fromJson<double?>(json['armRight']),
      forearmLeft: serializer.fromJson<double?>(json['forearmLeft']),
      forearmRight: serializer.fromJson<double?>(json['forearmRight']),
      waist: serializer.fromJson<double?>(json['waist']),
      waistNaval: serializer.fromJson<double?>(json['waistNaval']),
      hips: serializer.fromJson<double?>(json['hips']),
      thighLeft: serializer.fromJson<double?>(json['thighLeft']),
      thighRight: serializer.fromJson<double?>(json['thighRight']),
      calfLeft: serializer.fromJson<double?>(json['calfLeft']),
      calfRight: serializer.fromJson<double?>(json['calfRight']),
      height: serializer.fromJson<double?>(json['height']),
      subcutaneousFat: serializer.fromJson<double?>(json['subcutaneousFat']),
      visceralFat: serializer.fromJson<double?>(json['visceralFat']),
      customValues: serializer.fromJson<String?>(json['customValues']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double?>(weight),
      'bodyFat': serializer.toJson<double?>(bodyFat),
      'neck': serializer.toJson<double?>(neck),
      'chest': serializer.toJson<double?>(chest),
      'shoulders': serializer.toJson<double?>(shoulders),
      'armLeft': serializer.toJson<double?>(armLeft),
      'armRight': serializer.toJson<double?>(armRight),
      'forearmLeft': serializer.toJson<double?>(forearmLeft),
      'forearmRight': serializer.toJson<double?>(forearmRight),
      'waist': serializer.toJson<double?>(waist),
      'waistNaval': serializer.toJson<double?>(waistNaval),
      'hips': serializer.toJson<double?>(hips),
      'thighLeft': serializer.toJson<double?>(thighLeft),
      'thighRight': serializer.toJson<double?>(thighRight),
      'calfLeft': serializer.toJson<double?>(calfLeft),
      'calfRight': serializer.toJson<double?>(calfRight),
      'height': serializer.toJson<double?>(height),
      'subcutaneousFat': serializer.toJson<double?>(subcutaneousFat),
      'visceralFat': serializer.toJson<double?>(visceralFat),
      'customValues': serializer.toJson<String?>(customValues),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  BodyMeasurementTable copyWith({
    int? id,
    DateTime? date,
    Value<double?> weight = const Value.absent(),
    Value<double?> bodyFat = const Value.absent(),
    Value<double?> neck = const Value.absent(),
    Value<double?> chest = const Value.absent(),
    Value<double?> shoulders = const Value.absent(),
    Value<double?> armLeft = const Value.absent(),
    Value<double?> armRight = const Value.absent(),
    Value<double?> forearmLeft = const Value.absent(),
    Value<double?> forearmRight = const Value.absent(),
    Value<double?> waist = const Value.absent(),
    Value<double?> waistNaval = const Value.absent(),
    Value<double?> hips = const Value.absent(),
    Value<double?> thighLeft = const Value.absent(),
    Value<double?> thighRight = const Value.absent(),
    Value<double?> calfLeft = const Value.absent(),
    Value<double?> calfRight = const Value.absent(),
    Value<double?> height = const Value.absent(),
    Value<double?> subcutaneousFat = const Value.absent(),
    Value<double?> visceralFat = const Value.absent(),
    Value<String?> customValues = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => BodyMeasurementTable(
    id: id ?? this.id,
    date: date ?? this.date,
    weight: weight.present ? weight.value : this.weight,
    bodyFat: bodyFat.present ? bodyFat.value : this.bodyFat,
    neck: neck.present ? neck.value : this.neck,
    chest: chest.present ? chest.value : this.chest,
    shoulders: shoulders.present ? shoulders.value : this.shoulders,
    armLeft: armLeft.present ? armLeft.value : this.armLeft,
    armRight: armRight.present ? armRight.value : this.armRight,
    forearmLeft: forearmLeft.present ? forearmLeft.value : this.forearmLeft,
    forearmRight: forearmRight.present ? forearmRight.value : this.forearmRight,
    waist: waist.present ? waist.value : this.waist,
    waistNaval: waistNaval.present ? waistNaval.value : this.waistNaval,
    hips: hips.present ? hips.value : this.hips,
    thighLeft: thighLeft.present ? thighLeft.value : this.thighLeft,
    thighRight: thighRight.present ? thighRight.value : this.thighRight,
    calfLeft: calfLeft.present ? calfLeft.value : this.calfLeft,
    calfRight: calfRight.present ? calfRight.value : this.calfRight,
    height: height.present ? height.value : this.height,
    subcutaneousFat: subcutaneousFat.present
        ? subcutaneousFat.value
        : this.subcutaneousFat,
    visceralFat: visceralFat.present ? visceralFat.value : this.visceralFat,
    customValues: customValues.present ? customValues.value : this.customValues,
    notes: notes.present ? notes.value : this.notes,
  );
  BodyMeasurementTable copyWithCompanion(BodyMeasurementsCompanion data) {
    return BodyMeasurementTable(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
      bodyFat: data.bodyFat.present ? data.bodyFat.value : this.bodyFat,
      neck: data.neck.present ? data.neck.value : this.neck,
      chest: data.chest.present ? data.chest.value : this.chest,
      shoulders: data.shoulders.present ? data.shoulders.value : this.shoulders,
      armLeft: data.armLeft.present ? data.armLeft.value : this.armLeft,
      armRight: data.armRight.present ? data.armRight.value : this.armRight,
      forearmLeft: data.forearmLeft.present
          ? data.forearmLeft.value
          : this.forearmLeft,
      forearmRight: data.forearmRight.present
          ? data.forearmRight.value
          : this.forearmRight,
      waist: data.waist.present ? data.waist.value : this.waist,
      waistNaval: data.waistNaval.present
          ? data.waistNaval.value
          : this.waistNaval,
      hips: data.hips.present ? data.hips.value : this.hips,
      thighLeft: data.thighLeft.present ? data.thighLeft.value : this.thighLeft,
      thighRight: data.thighRight.present
          ? data.thighRight.value
          : this.thighRight,
      calfLeft: data.calfLeft.present ? data.calfLeft.value : this.calfLeft,
      calfRight: data.calfRight.present ? data.calfRight.value : this.calfRight,
      height: data.height.present ? data.height.value : this.height,
      subcutaneousFat: data.subcutaneousFat.present
          ? data.subcutaneousFat.value
          : this.subcutaneousFat,
      visceralFat: data.visceralFat.present
          ? data.visceralFat.value
          : this.visceralFat,
      customValues: data.customValues.present
          ? data.customValues.value
          : this.customValues,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyMeasurementTable(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('bodyFat: $bodyFat, ')
          ..write('neck: $neck, ')
          ..write('chest: $chest, ')
          ..write('shoulders: $shoulders, ')
          ..write('armLeft: $armLeft, ')
          ..write('armRight: $armRight, ')
          ..write('forearmLeft: $forearmLeft, ')
          ..write('forearmRight: $forearmRight, ')
          ..write('waist: $waist, ')
          ..write('waistNaval: $waistNaval, ')
          ..write('hips: $hips, ')
          ..write('thighLeft: $thighLeft, ')
          ..write('thighRight: $thighRight, ')
          ..write('calfLeft: $calfLeft, ')
          ..write('calfRight: $calfRight, ')
          ..write('height: $height, ')
          ..write('subcutaneousFat: $subcutaneousFat, ')
          ..write('visceralFat: $visceralFat, ')
          ..write('customValues: $customValues, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    date,
    weight,
    bodyFat,
    neck,
    chest,
    shoulders,
    armLeft,
    armRight,
    forearmLeft,
    forearmRight,
    waist,
    waistNaval,
    hips,
    thighLeft,
    thighRight,
    calfLeft,
    calfRight,
    height,
    subcutaneousFat,
    visceralFat,
    customValues,
    notes,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyMeasurementTable &&
          other.id == this.id &&
          other.date == this.date &&
          other.weight == this.weight &&
          other.bodyFat == this.bodyFat &&
          other.neck == this.neck &&
          other.chest == this.chest &&
          other.shoulders == this.shoulders &&
          other.armLeft == this.armLeft &&
          other.armRight == this.armRight &&
          other.forearmLeft == this.forearmLeft &&
          other.forearmRight == this.forearmRight &&
          other.waist == this.waist &&
          other.waistNaval == this.waistNaval &&
          other.hips == this.hips &&
          other.thighLeft == this.thighLeft &&
          other.thighRight == this.thighRight &&
          other.calfLeft == this.calfLeft &&
          other.calfRight == this.calfRight &&
          other.height == this.height &&
          other.subcutaneousFat == this.subcutaneousFat &&
          other.visceralFat == this.visceralFat &&
          other.customValues == this.customValues &&
          other.notes == this.notes);
}

class BodyMeasurementsCompanion extends UpdateCompanion<BodyMeasurementTable> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<double?> weight;
  final Value<double?> bodyFat;
  final Value<double?> neck;
  final Value<double?> chest;
  final Value<double?> shoulders;
  final Value<double?> armLeft;
  final Value<double?> armRight;
  final Value<double?> forearmLeft;
  final Value<double?> forearmRight;
  final Value<double?> waist;
  final Value<double?> waistNaval;
  final Value<double?> hips;
  final Value<double?> thighLeft;
  final Value<double?> thighRight;
  final Value<double?> calfLeft;
  final Value<double?> calfRight;
  final Value<double?> height;
  final Value<double?> subcutaneousFat;
  final Value<double?> visceralFat;
  final Value<String?> customValues;
  final Value<String?> notes;
  const BodyMeasurementsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.bodyFat = const Value.absent(),
    this.neck = const Value.absent(),
    this.chest = const Value.absent(),
    this.shoulders = const Value.absent(),
    this.armLeft = const Value.absent(),
    this.armRight = const Value.absent(),
    this.forearmLeft = const Value.absent(),
    this.forearmRight = const Value.absent(),
    this.waist = const Value.absent(),
    this.waistNaval = const Value.absent(),
    this.hips = const Value.absent(),
    this.thighLeft = const Value.absent(),
    this.thighRight = const Value.absent(),
    this.calfLeft = const Value.absent(),
    this.calfRight = const Value.absent(),
    this.height = const Value.absent(),
    this.subcutaneousFat = const Value.absent(),
    this.visceralFat = const Value.absent(),
    this.customValues = const Value.absent(),
    this.notes = const Value.absent(),
  });
  BodyMeasurementsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.weight = const Value.absent(),
    this.bodyFat = const Value.absent(),
    this.neck = const Value.absent(),
    this.chest = const Value.absent(),
    this.shoulders = const Value.absent(),
    this.armLeft = const Value.absent(),
    this.armRight = const Value.absent(),
    this.forearmLeft = const Value.absent(),
    this.forearmRight = const Value.absent(),
    this.waist = const Value.absent(),
    this.waistNaval = const Value.absent(),
    this.hips = const Value.absent(),
    this.thighLeft = const Value.absent(),
    this.thighRight = const Value.absent(),
    this.calfLeft = const Value.absent(),
    this.calfRight = const Value.absent(),
    this.height = const Value.absent(),
    this.subcutaneousFat = const Value.absent(),
    this.visceralFat = const Value.absent(),
    this.customValues = const Value.absent(),
    this.notes = const Value.absent(),
  }) : date = Value(date);
  static Insertable<BodyMeasurementTable> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<double>? weight,
    Expression<double>? bodyFat,
    Expression<double>? neck,
    Expression<double>? chest,
    Expression<double>? shoulders,
    Expression<double>? armLeft,
    Expression<double>? armRight,
    Expression<double>? forearmLeft,
    Expression<double>? forearmRight,
    Expression<double>? waist,
    Expression<double>? waistNaval,
    Expression<double>? hips,
    Expression<double>? thighLeft,
    Expression<double>? thighRight,
    Expression<double>? calfLeft,
    Expression<double>? calfRight,
    Expression<double>? height,
    Expression<double>? subcutaneousFat,
    Expression<double>? visceralFat,
    Expression<String>? customValues,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
      if (bodyFat != null) 'body_fat': bodyFat,
      if (neck != null) 'neck': neck,
      if (chest != null) 'chest': chest,
      if (shoulders != null) 'shoulders': shoulders,
      if (armLeft != null) 'arm_left': armLeft,
      if (armRight != null) 'arm_right': armRight,
      if (forearmLeft != null) 'forearm_left': forearmLeft,
      if (forearmRight != null) 'forearm_right': forearmRight,
      if (waist != null) 'waist': waist,
      if (waistNaval != null) 'waist_naval': waistNaval,
      if (hips != null) 'hips': hips,
      if (thighLeft != null) 'thigh_left': thighLeft,
      if (thighRight != null) 'thigh_right': thighRight,
      if (calfLeft != null) 'calf_left': calfLeft,
      if (calfRight != null) 'calf_right': calfRight,
      if (height != null) 'height': height,
      if (subcutaneousFat != null) 'subcutaneous_fat': subcutaneousFat,
      if (visceralFat != null) 'visceral_fat': visceralFat,
      if (customValues != null) 'custom_values': customValues,
      if (notes != null) 'notes': notes,
    });
  }

  BodyMeasurementsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<double?>? weight,
    Value<double?>? bodyFat,
    Value<double?>? neck,
    Value<double?>? chest,
    Value<double?>? shoulders,
    Value<double?>? armLeft,
    Value<double?>? armRight,
    Value<double?>? forearmLeft,
    Value<double?>? forearmRight,
    Value<double?>? waist,
    Value<double?>? waistNaval,
    Value<double?>? hips,
    Value<double?>? thighLeft,
    Value<double?>? thighRight,
    Value<double?>? calfLeft,
    Value<double?>? calfRight,
    Value<double?>? height,
    Value<double?>? subcutaneousFat,
    Value<double?>? visceralFat,
    Value<String?>? customValues,
    Value<String?>? notes,
  }) {
    return BodyMeasurementsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      bodyFat: bodyFat ?? this.bodyFat,
      neck: neck ?? this.neck,
      chest: chest ?? this.chest,
      shoulders: shoulders ?? this.shoulders,
      armLeft: armLeft ?? this.armLeft,
      armRight: armRight ?? this.armRight,
      forearmLeft: forearmLeft ?? this.forearmLeft,
      forearmRight: forearmRight ?? this.forearmRight,
      waist: waist ?? this.waist,
      waistNaval: waistNaval ?? this.waistNaval,
      hips: hips ?? this.hips,
      thighLeft: thighLeft ?? this.thighLeft,
      thighRight: thighRight ?? this.thighRight,
      calfLeft: calfLeft ?? this.calfLeft,
      calfRight: calfRight ?? this.calfRight,
      height: height ?? this.height,
      subcutaneousFat: subcutaneousFat ?? this.subcutaneousFat,
      visceralFat: visceralFat ?? this.visceralFat,
      customValues: customValues ?? this.customValues,
      notes: notes ?? this.notes,
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
    if (bodyFat.present) {
      map['body_fat'] = Variable<double>(bodyFat.value);
    }
    if (neck.present) {
      map['neck'] = Variable<double>(neck.value);
    }
    if (chest.present) {
      map['chest'] = Variable<double>(chest.value);
    }
    if (shoulders.present) {
      map['shoulders'] = Variable<double>(shoulders.value);
    }
    if (armLeft.present) {
      map['arm_left'] = Variable<double>(armLeft.value);
    }
    if (armRight.present) {
      map['arm_right'] = Variable<double>(armRight.value);
    }
    if (forearmLeft.present) {
      map['forearm_left'] = Variable<double>(forearmLeft.value);
    }
    if (forearmRight.present) {
      map['forearm_right'] = Variable<double>(forearmRight.value);
    }
    if (waist.present) {
      map['waist'] = Variable<double>(waist.value);
    }
    if (waistNaval.present) {
      map['waist_naval'] = Variable<double>(waistNaval.value);
    }
    if (hips.present) {
      map['hips'] = Variable<double>(hips.value);
    }
    if (thighLeft.present) {
      map['thigh_left'] = Variable<double>(thighLeft.value);
    }
    if (thighRight.present) {
      map['thigh_right'] = Variable<double>(thighRight.value);
    }
    if (calfLeft.present) {
      map['calf_left'] = Variable<double>(calfLeft.value);
    }
    if (calfRight.present) {
      map['calf_right'] = Variable<double>(calfRight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (subcutaneousFat.present) {
      map['subcutaneous_fat'] = Variable<double>(subcutaneousFat.value);
    }
    if (visceralFat.present) {
      map['visceral_fat'] = Variable<double>(visceralFat.value);
    }
    if (customValues.present) {
      map['custom_values'] = Variable<String>(customValues.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyMeasurementsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('bodyFat: $bodyFat, ')
          ..write('neck: $neck, ')
          ..write('chest: $chest, ')
          ..write('shoulders: $shoulders, ')
          ..write('armLeft: $armLeft, ')
          ..write('armRight: $armRight, ')
          ..write('forearmLeft: $forearmLeft, ')
          ..write('forearmRight: $forearmRight, ')
          ..write('waist: $waist, ')
          ..write('waistNaval: $waistNaval, ')
          ..write('hips: $hips, ')
          ..write('thighLeft: $thighLeft, ')
          ..write('thighRight: $thighRight, ')
          ..write('calfLeft: $calfLeft, ')
          ..write('calfRight: $calfRight, ')
          ..write('height: $height, ')
          ..write('subcutaneousFat: $subcutaneousFat, ')
          ..write('visceralFat: $visceralFat, ')
          ..write('customValues: $customValues, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $BodyTargetsTable extends BodyTargets
    with TableInfo<$BodyTargetsTable, BodyTarget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyTargetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _metricMeta = const VerificationMeta('metric');
  @override
  late final GeneratedColumn<String> metric = GeneratedColumn<String>(
    'metric',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<double> targetValue = GeneratedColumn<double>(
    'target_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    metric,
    targetValue,
    deadline,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_targets';
  @override
  VerificationContext validateIntegrity(
    Insertable<BodyTarget> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('metric')) {
      context.handle(
        _metricMeta,
        metric.isAcceptableOrUnknown(data['metric']!, _metricMeta),
      );
    } else if (isInserting) {
      context.missing(_metricMeta);
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetValueMeta);
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BodyTarget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyTarget(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      metric: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metric'],
      )!,
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_value'],
      )!,
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BodyTargetsTable createAlias(String alias) {
    return $BodyTargetsTable(attachedDatabase, alias);
  }
}

class BodyTarget extends DataClass implements Insertable<BodyTarget> {
  final int id;
  final String metric;
  final double targetValue;
  final DateTime? deadline;
  final DateTime createdAt;
  const BodyTarget({
    required this.id,
    required this.metric,
    required this.targetValue,
    this.deadline,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['metric'] = Variable<String>(metric);
    map['target_value'] = Variable<double>(targetValue);
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BodyTargetsCompanion toCompanion(bool nullToAbsent) {
    return BodyTargetsCompanion(
      id: Value(id),
      metric: Value(metric),
      targetValue: Value(targetValue),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      createdAt: Value(createdAt),
    );
  }

  factory BodyTarget.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyTarget(
      id: serializer.fromJson<int>(json['id']),
      metric: serializer.fromJson<String>(json['metric']),
      targetValue: serializer.fromJson<double>(json['targetValue']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'metric': serializer.toJson<String>(metric),
      'targetValue': serializer.toJson<double>(targetValue),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BodyTarget copyWith({
    int? id,
    String? metric,
    double? targetValue,
    Value<DateTime?> deadline = const Value.absent(),
    DateTime? createdAt,
  }) => BodyTarget(
    id: id ?? this.id,
    metric: metric ?? this.metric,
    targetValue: targetValue ?? this.targetValue,
    deadline: deadline.present ? deadline.value : this.deadline,
    createdAt: createdAt ?? this.createdAt,
  );
  BodyTarget copyWithCompanion(BodyTargetsCompanion data) {
    return BodyTarget(
      id: data.id.present ? data.id.value : this.id,
      metric: data.metric.present ? data.metric.value : this.metric,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyTarget(')
          ..write('id: $id, ')
          ..write('metric: $metric, ')
          ..write('targetValue: $targetValue, ')
          ..write('deadline: $deadline, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, metric, targetValue, deadline, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyTarget &&
          other.id == this.id &&
          other.metric == this.metric &&
          other.targetValue == this.targetValue &&
          other.deadline == this.deadline &&
          other.createdAt == this.createdAt);
}

class BodyTargetsCompanion extends UpdateCompanion<BodyTarget> {
  final Value<int> id;
  final Value<String> metric;
  final Value<double> targetValue;
  final Value<DateTime?> deadline;
  final Value<DateTime> createdAt;
  const BodyTargetsCompanion({
    this.id = const Value.absent(),
    this.metric = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.deadline = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BodyTargetsCompanion.insert({
    this.id = const Value.absent(),
    required String metric,
    required double targetValue,
    this.deadline = const Value.absent(),
    required DateTime createdAt,
  }) : metric = Value(metric),
       targetValue = Value(targetValue),
       createdAt = Value(createdAt);
  static Insertable<BodyTarget> custom({
    Expression<int>? id,
    Expression<String>? metric,
    Expression<double>? targetValue,
    Expression<DateTime>? deadline,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (metric != null) 'metric': metric,
      if (targetValue != null) 'target_value': targetValue,
      if (deadline != null) 'deadline': deadline,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BodyTargetsCompanion copyWith({
    Value<int>? id,
    Value<String>? metric,
    Value<double>? targetValue,
    Value<DateTime?>? deadline,
    Value<DateTime>? createdAt,
  }) {
    return BodyTargetsCompanion(
      id: id ?? this.id,
      metric: metric ?? this.metric,
      targetValue: targetValue ?? this.targetValue,
      deadline: deadline ?? this.deadline,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (metric.present) {
      map['metric'] = Variable<String>(metric.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<double>(targetValue.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyTargetsCompanion(')
          ..write('id: $id, ')
          ..write('metric: $metric, ')
          ..write('targetValue: $targetValue, ')
          ..write('deadline: $deadline, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProgressPhotosTable extends ProgressPhotos
    with TableInfo<$ProgressPhotosTable, ProgressPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgressPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('front'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, imagePath, category, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progress_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressPhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgressPhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressPhoto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ProgressPhotosTable createAlias(String alias) {
    return $ProgressPhotosTable(attachedDatabase, alias);
  }
}

class ProgressPhoto extends DataClass implements Insertable<ProgressPhoto> {
  final int id;
  final DateTime date;
  final String imagePath;
  final String category;
  final String? notes;
  const ProgressPhoto({
    required this.id,
    required this.date,
    required this.imagePath,
    required this.category,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['image_path'] = Variable<String>(imagePath);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ProgressPhotosCompanion toCompanion(bool nullToAbsent) {
    return ProgressPhotosCompanion(
      id: Value(id),
      date: Value(date),
      imagePath: Value(imagePath),
      category: Value(category),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory ProgressPhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressPhoto(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      category: serializer.fromJson<String>(json['category']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'imagePath': serializer.toJson<String>(imagePath),
      'category': serializer.toJson<String>(category),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  ProgressPhoto copyWith({
    int? id,
    DateTime? date,
    String? imagePath,
    String? category,
    Value<String?> notes = const Value.absent(),
  }) => ProgressPhoto(
    id: id ?? this.id,
    date: date ?? this.date,
    imagePath: imagePath ?? this.imagePath,
    category: category ?? this.category,
    notes: notes.present ? notes.value : this.notes,
  );
  ProgressPhoto copyWithCompanion(ProgressPhotosCompanion data) {
    return ProgressPhoto(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      category: data.category.present ? data.category.value : this.category,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressPhoto(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('imagePath: $imagePath, ')
          ..write('category: $category, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, imagePath, category, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressPhoto &&
          other.id == this.id &&
          other.date == this.date &&
          other.imagePath == this.imagePath &&
          other.category == this.category &&
          other.notes == this.notes);
}

class ProgressPhotosCompanion extends UpdateCompanion<ProgressPhoto> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> imagePath;
  final Value<String> category;
  final Value<String?> notes;
  const ProgressPhotosCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.category = const Value.absent(),
    this.notes = const Value.absent(),
  });
  ProgressPhotosCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String imagePath,
    this.category = const Value.absent(),
    this.notes = const Value.absent(),
  }) : date = Value(date),
       imagePath = Value(imagePath);
  static Insertable<ProgressPhoto> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? imagePath,
    Expression<String>? category,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (imagePath != null) 'image_path': imagePath,
      if (category != null) 'category': category,
      if (notes != null) 'notes': notes,
    });
  }

  ProgressPhotosCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? imagePath,
    Value<String>? category,
    Value<String?>? notes,
  }) {
    return ProgressPhotosCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      notes: notes ?? this.notes,
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
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgressPhotosCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('imagePath: $imagePath, ')
          ..write('category: $category, ')
          ..write('notes: $notes')
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _workoutIdMeta = const VerificationMeta(
    'workoutId',
  );
  @override
  late final GeneratedColumn<int> workoutId = GeneratedColumn<int>(
    'workout_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workouts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _measurementIdMeta = const VerificationMeta(
    'measurementId',
  );
  @override
  late final GeneratedColumn<int> measurementId = GeneratedColumn<int>(
    'measurement_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES body_measurements (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
    'error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workoutId,
    measurementId,
    type,
    status,
    createdAt,
    attempts,
    error,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('workout_id')) {
      context.handle(
        _workoutIdMeta,
        workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta),
      );
    }
    if (data.containsKey('measurement_id')) {
      context.handle(
        _measurementIdMeta,
        measurementId.isAcceptableOrUnknown(
          data['measurement_id']!,
          _measurementIdMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('error')) {
      context.handle(
        _errorMeta,
        error.isAcceptableOrUnknown(data['error']!, _errorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      workoutId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workout_id'],
      ),
      measurementId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}measurement_id'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      error: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error'],
      ),
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
  const SyncQueueData({
    required this.id,
    this.workoutId,
    this.measurementId,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.attempts,
    this.error,
  });
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
      error: error == null && nullToAbsent
          ? const Value.absent()
          : Value(error),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  SyncQueueData copyWith({
    int? id,
    Value<int?> workoutId = const Value.absent(),
    Value<int?> measurementId = const Value.absent(),
    String? type,
    String? status,
    DateTime? createdAt,
    int? attempts,
    Value<String?> error = const Value.absent(),
  }) => SyncQueueData(
    id: id ?? this.id,
    workoutId: workoutId.present ? workoutId.value : this.workoutId,
    measurementId: measurementId.present
        ? measurementId.value
        : this.measurementId,
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
    id,
    workoutId,
    measurementId,
    type,
    status,
    createdAt,
    attempts,
    error,
  );
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
  }) : type = Value(type),
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

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<int?>? workoutId,
    Value<int?>? measurementId,
    Value<String>? type,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? attempts,
    Value<String?>? error,
  }) {
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
        TableInfo<
          $ExerciseProgressionSettingsTable,
          ExerciseProgressionSetting
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseProgressionSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _incrementOverrideMeta = const VerificationMeta(
    'incrementOverride',
  );
  @override
  late final GeneratedColumn<double> incrementOverride =
      GeneratedColumn<double>(
        'increment_override',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _targetRepsMeta = const VerificationMeta(
    'targetReps',
  );
  @override
  late final GeneratedColumn<int> targetReps = GeneratedColumn<int>(
    'target_reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _targetSetsMeta = const VerificationMeta(
    'targetSets',
  );
  @override
  late final GeneratedColumn<int> targetSets = GeneratedColumn<int>(
    'target_sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _autoSuggestMeta = const VerificationMeta(
    'autoSuggest',
  );
  @override
  late final GeneratedColumn<bool> autoSuggest = GeneratedColumn<bool>(
    'auto_suggest',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_suggest" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    incrementOverride,
    targetReps,
    targetSets,
    autoSuggest,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_progression_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseProgressionSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('increment_override')) {
      context.handle(
        _incrementOverrideMeta,
        incrementOverride.isAcceptableOrUnknown(
          data['increment_override']!,
          _incrementOverrideMeta,
        ),
      );
    }
    if (data.containsKey('target_reps')) {
      context.handle(
        _targetRepsMeta,
        targetReps.isAcceptableOrUnknown(data['target_reps']!, _targetRepsMeta),
      );
    }
    if (data.containsKey('target_sets')) {
      context.handle(
        _targetSetsMeta,
        targetSets.isAcceptableOrUnknown(data['target_sets']!, _targetSetsMeta),
      );
    }
    if (data.containsKey('auto_suggest')) {
      context.handle(
        _autoSuggestMeta,
        autoSuggest.isAcceptableOrUnknown(
          data['auto_suggest']!,
          _autoSuggestMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseProgressionSetting map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseProgressionSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      incrementOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}increment_override'],
      ),
      targetReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_reps'],
      )!,
      targetSets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_sets'],
      )!,
      autoSuggest: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_suggest'],
      )!,
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
  const ExerciseProgressionSetting({
    required this.id,
    required this.exerciseId,
    this.incrementOverride,
    required this.targetReps,
    required this.targetSets,
    required this.autoSuggest,
  });
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

  factory ExerciseProgressionSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseProgressionSetting(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      incrementOverride: serializer.fromJson<double?>(
        json['incrementOverride'],
      ),
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

  ExerciseProgressionSetting copyWith({
    int? id,
    int? exerciseId,
    Value<double?> incrementOverride = const Value.absent(),
    int? targetReps,
    int? targetSets,
    bool? autoSuggest,
  }) => ExerciseProgressionSetting(
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
    ExerciseProgressionSettingsCompanion data,
  ) {
    return ExerciseProgressionSetting(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      incrementOverride: data.incrementOverride.present
          ? data.incrementOverride.value
          : this.incrementOverride,
      targetReps: data.targetReps.present
          ? data.targetReps.value
          : this.targetReps,
      targetSets: data.targetSets.present
          ? data.targetSets.value
          : this.targetSets,
      autoSuggest: data.autoSuggest.present
          ? data.autoSuggest.value
          : this.autoSuggest,
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
    id,
    exerciseId,
    incrementOverride,
    targetReps,
    targetSets,
    autoSuggest,
  );
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

  ExerciseProgressionSettingsCompanion copyWith({
    Value<int>? id,
    Value<int>? exerciseId,
    Value<double?>? incrementOverride,
    Value<int>? targetReps,
    Value<int>? targetSets,
    Value<bool>? autoSuggest,
  }) {
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

class $ExerciseMusclesTable extends ExerciseMuscles
    with TableInfo<$ExerciseMusclesTable, ExerciseMuscle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseMusclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _muscleNameMeta = const VerificationMeta(
    'muscleName',
  );
  @override
  late final GeneratedColumn<String> muscleName = GeneratedColumn<String>(
    'muscle_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPrimaryMeta = const VerificationMeta(
    'isPrimary',
  );
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
    'is_primary',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_primary" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, exerciseId, muscleName, isPrimary];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_muscles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseMuscle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('muscle_name')) {
      context.handle(
        _muscleNameMeta,
        muscleName.isAcceptableOrUnknown(data['muscle_name']!, _muscleNameMeta),
      );
    } else if (isInserting) {
      context.missing(_muscleNameMeta);
    }
    if (data.containsKey('is_primary')) {
      context.handle(
        _isPrimaryMeta,
        isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseMuscle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseMuscle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      muscleName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_name'],
      )!,
      isPrimary: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_primary'],
      )!,
    );
  }

  @override
  $ExerciseMusclesTable createAlias(String alias) {
    return $ExerciseMusclesTable(attachedDatabase, alias);
  }
}

class ExerciseMuscle extends DataClass implements Insertable<ExerciseMuscle> {
  final int id;
  final int exerciseId;
  final String muscleName;
  final bool isPrimary;
  const ExerciseMuscle({
    required this.id,
    required this.exerciseId,
    required this.muscleName,
    required this.isPrimary,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['muscle_name'] = Variable<String>(muscleName);
    map['is_primary'] = Variable<bool>(isPrimary);
    return map;
  }

  ExerciseMusclesCompanion toCompanion(bool nullToAbsent) {
    return ExerciseMusclesCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      muscleName: Value(muscleName),
      isPrimary: Value(isPrimary),
    );
  }

  factory ExerciseMuscle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseMuscle(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      muscleName: serializer.fromJson<String>(json['muscleName']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'muscleName': serializer.toJson<String>(muscleName),
      'isPrimary': serializer.toJson<bool>(isPrimary),
    };
  }

  ExerciseMuscle copyWith({
    int? id,
    int? exerciseId,
    String? muscleName,
    bool? isPrimary,
  }) => ExerciseMuscle(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    muscleName: muscleName ?? this.muscleName,
    isPrimary: isPrimary ?? this.isPrimary,
  );
  ExerciseMuscle copyWithCompanion(ExerciseMusclesCompanion data) {
    return ExerciseMuscle(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      muscleName: data.muscleName.present
          ? data.muscleName.value
          : this.muscleName,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseMuscle(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('muscleName: $muscleName, ')
          ..write('isPrimary: $isPrimary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseId, muscleName, isPrimary);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseMuscle &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.muscleName == this.muscleName &&
          other.isPrimary == this.isPrimary);
}

class ExerciseMusclesCompanion extends UpdateCompanion<ExerciseMuscle> {
  final Value<int> id;
  final Value<int> exerciseId;
  final Value<String> muscleName;
  final Value<bool> isPrimary;
  const ExerciseMusclesCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.muscleName = const Value.absent(),
    this.isPrimary = const Value.absent(),
  });
  ExerciseMusclesCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseId,
    required String muscleName,
    this.isPrimary = const Value.absent(),
  }) : exerciseId = Value(exerciseId),
       muscleName = Value(muscleName);
  static Insertable<ExerciseMuscle> custom({
    Expression<int>? id,
    Expression<int>? exerciseId,
    Expression<String>? muscleName,
    Expression<bool>? isPrimary,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (muscleName != null) 'muscle_name': muscleName,
      if (isPrimary != null) 'is_primary': isPrimary,
    });
  }

  ExerciseMusclesCompanion copyWith({
    Value<int>? id,
    Value<int>? exerciseId,
    Value<String>? muscleName,
    Value<bool>? isPrimary,
  }) {
    return ExerciseMusclesCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      muscleName: muscleName ?? this.muscleName,
      isPrimary: isPrimary ?? this.isPrimary,
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
    if (muscleName.present) {
      map['muscle_name'] = Variable<String>(muscleName.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseMusclesCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('muscleName: $muscleName, ')
          ..write('isPrimary: $isPrimary')
          ..write(')'))
        .toString();
  }
}

class $ExerciseBodyPartsTable extends ExerciseBodyParts
    with TableInfo<$ExerciseBodyPartsTable, ExerciseBodyPart> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseBodyPartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _bodyPartMeta = const VerificationMeta(
    'bodyPart',
  );
  @override
  late final GeneratedColumn<String> bodyPart = GeneratedColumn<String>(
    'body_part',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, exerciseId, bodyPart];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_body_parts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseBodyPart> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('body_part')) {
      context.handle(
        _bodyPartMeta,
        bodyPart.isAcceptableOrUnknown(data['body_part']!, _bodyPartMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyPartMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseBodyPart map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseBodyPart(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      bodyPart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_part'],
      )!,
    );
  }

  @override
  $ExerciseBodyPartsTable createAlias(String alias) {
    return $ExerciseBodyPartsTable(attachedDatabase, alias);
  }
}

class ExerciseBodyPart extends DataClass
    implements Insertable<ExerciseBodyPart> {
  final int id;
  final int exerciseId;
  final String bodyPart;
  const ExerciseBodyPart({
    required this.id,
    required this.exerciseId,
    required this.bodyPart,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['body_part'] = Variable<String>(bodyPart);
    return map;
  }

  ExerciseBodyPartsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseBodyPartsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      bodyPart: Value(bodyPart),
    );
  }

  factory ExerciseBodyPart.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseBodyPart(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      bodyPart: serializer.fromJson<String>(json['bodyPart']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'bodyPart': serializer.toJson<String>(bodyPart),
    };
  }

  ExerciseBodyPart copyWith({int? id, int? exerciseId, String? bodyPart}) =>
      ExerciseBodyPart(
        id: id ?? this.id,
        exerciseId: exerciseId ?? this.exerciseId,
        bodyPart: bodyPart ?? this.bodyPart,
      );
  ExerciseBodyPart copyWithCompanion(ExerciseBodyPartsCompanion data) {
    return ExerciseBodyPart(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      bodyPart: data.bodyPart.present ? data.bodyPart.value : this.bodyPart,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseBodyPart(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('bodyPart: $bodyPart')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseId, bodyPart);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseBodyPart &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.bodyPart == this.bodyPart);
}

class ExerciseBodyPartsCompanion extends UpdateCompanion<ExerciseBodyPart> {
  final Value<int> id;
  final Value<int> exerciseId;
  final Value<String> bodyPart;
  const ExerciseBodyPartsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.bodyPart = const Value.absent(),
  });
  ExerciseBodyPartsCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseId,
    required String bodyPart,
  }) : exerciseId = Value(exerciseId),
       bodyPart = Value(bodyPart);
  static Insertable<ExerciseBodyPart> custom({
    Expression<int>? id,
    Expression<int>? exerciseId,
    Expression<String>? bodyPart,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (bodyPart != null) 'body_part': bodyPart,
    });
  }

  ExerciseBodyPartsCompanion copyWith({
    Value<int>? id,
    Value<int>? exerciseId,
    Value<String>? bodyPart,
  }) {
    return ExerciseBodyPartsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      bodyPart: bodyPart ?? this.bodyPart,
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
    if (bodyPart.present) {
      map['body_part'] = Variable<String>(bodyPart.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseBodyPartsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('bodyPart: $bodyPart')
          ..write(')'))
        .toString();
  }
}

class $ExerciseEnrichedContentTable extends ExerciseEnrichedContent
    with TableInfo<$ExerciseEnrichedContentTable, ExerciseEnrichedContentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseEnrichedContentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _safetyTipsMeta = const VerificationMeta(
    'safetyTips',
  );
  @override
  late final GeneratedColumn<String> safetyTips = GeneratedColumn<String>(
    'safety_tips',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commonMistakesMeta = const VerificationMeta(
    'commonMistakes',
  );
  @override
  late final GeneratedColumn<String> commonMistakes = GeneratedColumn<String>(
    'common_mistakes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _variationsMeta = const VerificationMeta(
    'variations',
  );
  @override
  late final GeneratedColumn<String> variations = GeneratedColumn<String>(
    'variations',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enrichedOverviewMeta = const VerificationMeta(
    'enrichedOverview',
  );
  @override
  late final GeneratedColumn<String> enrichedOverview = GeneratedColumn<String>(
    'enriched_overview',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enrichedAtMeta = const VerificationMeta(
    'enrichedAt',
  );
  @override
  late final GeneratedColumn<DateTime> enrichedAt = GeneratedColumn<DateTime>(
    'enriched_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enrichmentSourceMeta = const VerificationMeta(
    'enrichmentSource',
  );
  @override
  late final GeneratedColumn<String> enrichmentSource = GeneratedColumn<String>(
    'enrichment_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    exerciseId,
    safetyTips,
    commonMistakes,
    variations,
    enrichedOverview,
    enrichedAt,
    enrichmentSource,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_enriched_content';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseEnrichedContentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    }
    if (data.containsKey('safety_tips')) {
      context.handle(
        _safetyTipsMeta,
        safetyTips.isAcceptableOrUnknown(data['safety_tips']!, _safetyTipsMeta),
      );
    }
    if (data.containsKey('common_mistakes')) {
      context.handle(
        _commonMistakesMeta,
        commonMistakes.isAcceptableOrUnknown(
          data['common_mistakes']!,
          _commonMistakesMeta,
        ),
      );
    }
    if (data.containsKey('variations')) {
      context.handle(
        _variationsMeta,
        variations.isAcceptableOrUnknown(data['variations']!, _variationsMeta),
      );
    }
    if (data.containsKey('enriched_overview')) {
      context.handle(
        _enrichedOverviewMeta,
        enrichedOverview.isAcceptableOrUnknown(
          data['enriched_overview']!,
          _enrichedOverviewMeta,
        ),
      );
    }
    if (data.containsKey('enriched_at')) {
      context.handle(
        _enrichedAtMeta,
        enrichedAt.isAcceptableOrUnknown(data['enriched_at']!, _enrichedAtMeta),
      );
    }
    if (data.containsKey('enrichment_source')) {
      context.handle(
        _enrichmentSourceMeta,
        enrichmentSource.isAcceptableOrUnknown(
          data['enrichment_source']!,
          _enrichmentSourceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {exerciseId};
  @override
  ExerciseEnrichedContentData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseEnrichedContentData(
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      safetyTips: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}safety_tips'],
      ),
      commonMistakes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}common_mistakes'],
      ),
      variations: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variations'],
      ),
      enrichedOverview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enriched_overview'],
      ),
      enrichedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}enriched_at'],
      ),
      enrichmentSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enrichment_source'],
      ),
    );
  }

  @override
  $ExerciseEnrichedContentTable createAlias(String alias) {
    return $ExerciseEnrichedContentTable(attachedDatabase, alias);
  }
}

class ExerciseEnrichedContentData extends DataClass
    implements Insertable<ExerciseEnrichedContentData> {
  final int exerciseId;
  final String? safetyTips;
  final String? commonMistakes;
  final String? variations;
  final String? enrichedOverview;
  final DateTime? enrichedAt;
  final String? enrichmentSource;
  const ExerciseEnrichedContentData({
    required this.exerciseId,
    this.safetyTips,
    this.commonMistakes,
    this.variations,
    this.enrichedOverview,
    this.enrichedAt,
    this.enrichmentSource,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exercise_id'] = Variable<int>(exerciseId);
    if (!nullToAbsent || safetyTips != null) {
      map['safety_tips'] = Variable<String>(safetyTips);
    }
    if (!nullToAbsent || commonMistakes != null) {
      map['common_mistakes'] = Variable<String>(commonMistakes);
    }
    if (!nullToAbsent || variations != null) {
      map['variations'] = Variable<String>(variations);
    }
    if (!nullToAbsent || enrichedOverview != null) {
      map['enriched_overview'] = Variable<String>(enrichedOverview);
    }
    if (!nullToAbsent || enrichedAt != null) {
      map['enriched_at'] = Variable<DateTime>(enrichedAt);
    }
    if (!nullToAbsent || enrichmentSource != null) {
      map['enrichment_source'] = Variable<String>(enrichmentSource);
    }
    return map;
  }

  ExerciseEnrichedContentCompanion toCompanion(bool nullToAbsent) {
    return ExerciseEnrichedContentCompanion(
      exerciseId: Value(exerciseId),
      safetyTips: safetyTips == null && nullToAbsent
          ? const Value.absent()
          : Value(safetyTips),
      commonMistakes: commonMistakes == null && nullToAbsent
          ? const Value.absent()
          : Value(commonMistakes),
      variations: variations == null && nullToAbsent
          ? const Value.absent()
          : Value(variations),
      enrichedOverview: enrichedOverview == null && nullToAbsent
          ? const Value.absent()
          : Value(enrichedOverview),
      enrichedAt: enrichedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(enrichedAt),
      enrichmentSource: enrichmentSource == null && nullToAbsent
          ? const Value.absent()
          : Value(enrichmentSource),
    );
  }

  factory ExerciseEnrichedContentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseEnrichedContentData(
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      safetyTips: serializer.fromJson<String?>(json['safetyTips']),
      commonMistakes: serializer.fromJson<String?>(json['commonMistakes']),
      variations: serializer.fromJson<String?>(json['variations']),
      enrichedOverview: serializer.fromJson<String?>(json['enrichedOverview']),
      enrichedAt: serializer.fromJson<DateTime?>(json['enrichedAt']),
      enrichmentSource: serializer.fromJson<String?>(json['enrichmentSource']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exerciseId': serializer.toJson<int>(exerciseId),
      'safetyTips': serializer.toJson<String?>(safetyTips),
      'commonMistakes': serializer.toJson<String?>(commonMistakes),
      'variations': serializer.toJson<String?>(variations),
      'enrichedOverview': serializer.toJson<String?>(enrichedOverview),
      'enrichedAt': serializer.toJson<DateTime?>(enrichedAt),
      'enrichmentSource': serializer.toJson<String?>(enrichmentSource),
    };
  }

  ExerciseEnrichedContentData copyWith({
    int? exerciseId,
    Value<String?> safetyTips = const Value.absent(),
    Value<String?> commonMistakes = const Value.absent(),
    Value<String?> variations = const Value.absent(),
    Value<String?> enrichedOverview = const Value.absent(),
    Value<DateTime?> enrichedAt = const Value.absent(),
    Value<String?> enrichmentSource = const Value.absent(),
  }) => ExerciseEnrichedContentData(
    exerciseId: exerciseId ?? this.exerciseId,
    safetyTips: safetyTips.present ? safetyTips.value : this.safetyTips,
    commonMistakes: commonMistakes.present
        ? commonMistakes.value
        : this.commonMistakes,
    variations: variations.present ? variations.value : this.variations,
    enrichedOverview: enrichedOverview.present
        ? enrichedOverview.value
        : this.enrichedOverview,
    enrichedAt: enrichedAt.present ? enrichedAt.value : this.enrichedAt,
    enrichmentSource: enrichmentSource.present
        ? enrichmentSource.value
        : this.enrichmentSource,
  );
  ExerciseEnrichedContentData copyWithCompanion(
    ExerciseEnrichedContentCompanion data,
  ) {
    return ExerciseEnrichedContentData(
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      safetyTips: data.safetyTips.present
          ? data.safetyTips.value
          : this.safetyTips,
      commonMistakes: data.commonMistakes.present
          ? data.commonMistakes.value
          : this.commonMistakes,
      variations: data.variations.present
          ? data.variations.value
          : this.variations,
      enrichedOverview: data.enrichedOverview.present
          ? data.enrichedOverview.value
          : this.enrichedOverview,
      enrichedAt: data.enrichedAt.present
          ? data.enrichedAt.value
          : this.enrichedAt,
      enrichmentSource: data.enrichmentSource.present
          ? data.enrichmentSource.value
          : this.enrichmentSource,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseEnrichedContentData(')
          ..write('exerciseId: $exerciseId, ')
          ..write('safetyTips: $safetyTips, ')
          ..write('commonMistakes: $commonMistakes, ')
          ..write('variations: $variations, ')
          ..write('enrichedOverview: $enrichedOverview, ')
          ..write('enrichedAt: $enrichedAt, ')
          ..write('enrichmentSource: $enrichmentSource')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    exerciseId,
    safetyTips,
    commonMistakes,
    variations,
    enrichedOverview,
    enrichedAt,
    enrichmentSource,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseEnrichedContentData &&
          other.exerciseId == this.exerciseId &&
          other.safetyTips == this.safetyTips &&
          other.commonMistakes == this.commonMistakes &&
          other.variations == this.variations &&
          other.enrichedOverview == this.enrichedOverview &&
          other.enrichedAt == this.enrichedAt &&
          other.enrichmentSource == this.enrichmentSource);
}

class ExerciseEnrichedContentCompanion
    extends UpdateCompanion<ExerciseEnrichedContentData> {
  final Value<int> exerciseId;
  final Value<String?> safetyTips;
  final Value<String?> commonMistakes;
  final Value<String?> variations;
  final Value<String?> enrichedOverview;
  final Value<DateTime?> enrichedAt;
  final Value<String?> enrichmentSource;
  const ExerciseEnrichedContentCompanion({
    this.exerciseId = const Value.absent(),
    this.safetyTips = const Value.absent(),
    this.commonMistakes = const Value.absent(),
    this.variations = const Value.absent(),
    this.enrichedOverview = const Value.absent(),
    this.enrichedAt = const Value.absent(),
    this.enrichmentSource = const Value.absent(),
  });
  ExerciseEnrichedContentCompanion.insert({
    this.exerciseId = const Value.absent(),
    this.safetyTips = const Value.absent(),
    this.commonMistakes = const Value.absent(),
    this.variations = const Value.absent(),
    this.enrichedOverview = const Value.absent(),
    this.enrichedAt = const Value.absent(),
    this.enrichmentSource = const Value.absent(),
  });
  static Insertable<ExerciseEnrichedContentData> custom({
    Expression<int>? exerciseId,
    Expression<String>? safetyTips,
    Expression<String>? commonMistakes,
    Expression<String>? variations,
    Expression<String>? enrichedOverview,
    Expression<DateTime>? enrichedAt,
    Expression<String>? enrichmentSource,
  }) {
    return RawValuesInsertable({
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (safetyTips != null) 'safety_tips': safetyTips,
      if (commonMistakes != null) 'common_mistakes': commonMistakes,
      if (variations != null) 'variations': variations,
      if (enrichedOverview != null) 'enriched_overview': enrichedOverview,
      if (enrichedAt != null) 'enriched_at': enrichedAt,
      if (enrichmentSource != null) 'enrichment_source': enrichmentSource,
    });
  }

  ExerciseEnrichedContentCompanion copyWith({
    Value<int>? exerciseId,
    Value<String?>? safetyTips,
    Value<String?>? commonMistakes,
    Value<String?>? variations,
    Value<String?>? enrichedOverview,
    Value<DateTime?>? enrichedAt,
    Value<String?>? enrichmentSource,
  }) {
    return ExerciseEnrichedContentCompanion(
      exerciseId: exerciseId ?? this.exerciseId,
      safetyTips: safetyTips ?? this.safetyTips,
      commonMistakes: commonMistakes ?? this.commonMistakes,
      variations: variations ?? this.variations,
      enrichedOverview: enrichedOverview ?? this.enrichedOverview,
      enrichedAt: enrichedAt ?? this.enrichedAt,
      enrichmentSource: enrichmentSource ?? this.enrichmentSource,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (safetyTips.present) {
      map['safety_tips'] = Variable<String>(safetyTips.value);
    }
    if (commonMistakes.present) {
      map['common_mistakes'] = Variable<String>(commonMistakes.value);
    }
    if (variations.present) {
      map['variations'] = Variable<String>(variations.value);
    }
    if (enrichedOverview.present) {
      map['enriched_overview'] = Variable<String>(enrichedOverview.value);
    }
    if (enrichedAt.present) {
      map['enriched_at'] = Variable<DateTime>(enrichedAt.value);
    }
    if (enrichmentSource.present) {
      map['enrichment_source'] = Variable<String>(enrichmentSource.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseEnrichedContentCompanion(')
          ..write('exerciseId: $exerciseId, ')
          ..write('safetyTips: $safetyTips, ')
          ..write('commonMistakes: $commonMistakes, ')
          ..write('variations: $variations, ')
          ..write('enrichedOverview: $enrichedOverview, ')
          ..write('enrichedAt: $enrichedAt, ')
          ..write('enrichmentSource: $enrichmentSource')
          ..write(')'))
        .toString();
  }
}

class $RecentExercisesTable extends RecentExercises
    with TableInfo<$RecentExercisesTable, RecentExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _viewedAtMeta = const VerificationMeta(
    'viewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> viewedAt = GeneratedColumn<DateTime>(
    'viewed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [exerciseId, viewedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recent_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecentExercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    }
    if (data.containsKey('viewed_at')) {
      context.handle(
        _viewedAtMeta,
        viewedAt.isAcceptableOrUnknown(data['viewed_at']!, _viewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_viewedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {exerciseId};
  @override
  RecentExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentExercise(
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      viewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}viewed_at'],
      )!,
    );
  }

  @override
  $RecentExercisesTable createAlias(String alias) {
    return $RecentExercisesTable(attachedDatabase, alias);
  }
}

class RecentExercise extends DataClass implements Insertable<RecentExercise> {
  final int exerciseId;
  final DateTime viewedAt;
  const RecentExercise({required this.exerciseId, required this.viewedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exercise_id'] = Variable<int>(exerciseId);
    map['viewed_at'] = Variable<DateTime>(viewedAt);
    return map;
  }

  RecentExercisesCompanion toCompanion(bool nullToAbsent) {
    return RecentExercisesCompanion(
      exerciseId: Value(exerciseId),
      viewedAt: Value(viewedAt),
    );
  }

  factory RecentExercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentExercise(
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      viewedAt: serializer.fromJson<DateTime>(json['viewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exerciseId': serializer.toJson<int>(exerciseId),
      'viewedAt': serializer.toJson<DateTime>(viewedAt),
    };
  }

  RecentExercise copyWith({int? exerciseId, DateTime? viewedAt}) =>
      RecentExercise(
        exerciseId: exerciseId ?? this.exerciseId,
        viewedAt: viewedAt ?? this.viewedAt,
      );
  RecentExercise copyWithCompanion(RecentExercisesCompanion data) {
    return RecentExercise(
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      viewedAt: data.viewedAt.present ? data.viewedAt.value : this.viewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentExercise(')
          ..write('exerciseId: $exerciseId, ')
          ..write('viewedAt: $viewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(exerciseId, viewedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentExercise &&
          other.exerciseId == this.exerciseId &&
          other.viewedAt == this.viewedAt);
}

class RecentExercisesCompanion extends UpdateCompanion<RecentExercise> {
  final Value<int> exerciseId;
  final Value<DateTime> viewedAt;
  const RecentExercisesCompanion({
    this.exerciseId = const Value.absent(),
    this.viewedAt = const Value.absent(),
  });
  RecentExercisesCompanion.insert({
    this.exerciseId = const Value.absent(),
    required DateTime viewedAt,
  }) : viewedAt = Value(viewedAt);
  static Insertable<RecentExercise> custom({
    Expression<int>? exerciseId,
    Expression<DateTime>? viewedAt,
  }) {
    return RawValuesInsertable({
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (viewedAt != null) 'viewed_at': viewedAt,
    });
  }

  RecentExercisesCompanion copyWith({
    Value<int>? exerciseId,
    Value<DateTime>? viewedAt,
  }) {
    return RecentExercisesCompanion(
      exerciseId: exerciseId ?? this.exerciseId,
      viewedAt: viewedAt ?? this.viewedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (viewedAt.present) {
      map['viewed_at'] = Variable<DateTime>(viewedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentExercisesCompanion(')
          ..write('exerciseId: $exerciseId, ')
          ..write('viewedAt: $viewedAt')
          ..write(')'))
        .toString();
  }
}

class $ExerciseProgressionsTable extends ExerciseProgressions
    with TableInfo<$ExerciseProgressionsTable, ExerciseProgression> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseProgressionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _progressionExerciseIdMeta =
      const VerificationMeta('progressionExerciseId');
  @override
  late final GeneratedColumn<int> progressionExerciseId = GeneratedColumn<int>(
    'progression_exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    progressionExerciseId,
    position,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_progressions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseProgression> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('progression_exercise_id')) {
      context.handle(
        _progressionExerciseIdMeta,
        progressionExerciseId.isAcceptableOrUnknown(
          data['progression_exercise_id']!,
          _progressionExerciseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_progressionExerciseIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseProgression map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseProgression(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      progressionExerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progression_exercise_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $ExerciseProgressionsTable createAlias(String alias) {
    return $ExerciseProgressionsTable(attachedDatabase, alias);
  }
}

class ExerciseProgression extends DataClass
    implements Insertable<ExerciseProgression> {
  final int id;
  final int exerciseId;
  final int progressionExerciseId;
  final int position;
  const ExerciseProgression({
    required this.id,
    required this.exerciseId,
    required this.progressionExerciseId,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['progression_exercise_id'] = Variable<int>(progressionExerciseId);
    map['position'] = Variable<int>(position);
    return map;
  }

  ExerciseProgressionsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseProgressionsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      progressionExerciseId: Value(progressionExerciseId),
      position: Value(position),
    );
  }

  factory ExerciseProgression.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseProgression(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      progressionExerciseId: serializer.fromJson<int>(
        json['progressionExerciseId'],
      ),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'progressionExerciseId': serializer.toJson<int>(progressionExerciseId),
      'position': serializer.toJson<int>(position),
    };
  }

  ExerciseProgression copyWith({
    int? id,
    int? exerciseId,
    int? progressionExerciseId,
    int? position,
  }) => ExerciseProgression(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    progressionExerciseId: progressionExerciseId ?? this.progressionExerciseId,
    position: position ?? this.position,
  );
  ExerciseProgression copyWithCompanion(ExerciseProgressionsCompanion data) {
    return ExerciseProgression(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      progressionExerciseId: data.progressionExerciseId.present
          ? data.progressionExerciseId.value
          : this.progressionExerciseId,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseProgression(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('progressionExerciseId: $progressionExerciseId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, exerciseId, progressionExerciseId, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseProgression &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.progressionExerciseId == this.progressionExerciseId &&
          other.position == this.position);
}

class ExerciseProgressionsCompanion
    extends UpdateCompanion<ExerciseProgression> {
  final Value<int> id;
  final Value<int> exerciseId;
  final Value<int> progressionExerciseId;
  final Value<int> position;
  const ExerciseProgressionsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.progressionExerciseId = const Value.absent(),
    this.position = const Value.absent(),
  });
  ExerciseProgressionsCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseId,
    required int progressionExerciseId,
    required int position,
  }) : exerciseId = Value(exerciseId),
       progressionExerciseId = Value(progressionExerciseId),
       position = Value(position);
  static Insertable<ExerciseProgression> custom({
    Expression<int>? id,
    Expression<int>? exerciseId,
    Expression<int>? progressionExerciseId,
    Expression<int>? position,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (progressionExerciseId != null)
        'progression_exercise_id': progressionExerciseId,
      if (position != null) 'position': position,
    });
  }

  ExerciseProgressionsCompanion copyWith({
    Value<int>? id,
    Value<int>? exerciseId,
    Value<int>? progressionExerciseId,
    Value<int>? position,
  }) {
    return ExerciseProgressionsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      progressionExerciseId:
          progressionExerciseId ?? this.progressionExerciseId,
      position: position ?? this.position,
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
    if (progressionExerciseId.present) {
      map['progression_exercise_id'] = Variable<int>(
        progressionExerciseId.value,
      );
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseProgressionsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('progressionExerciseId: $progressionExerciseId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }
}

class $ExerciseInstructionsTable extends ExerciseInstructions
    with TableInfo<$ExerciseInstructionsTable, ExerciseInstruction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseInstructionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _stepNumberMeta = const VerificationMeta(
    'stepNumber',
  );
  @override
  late final GeneratedColumn<int> stepNumber = GeneratedColumn<int>(
    'step_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _instructionTextMeta = const VerificationMeta(
    'instructionText',
  );
  @override
  late final GeneratedColumn<String> instructionText = GeneratedColumn<String>(
    'instruction_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    stepNumber,
    instructionText,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_instructions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseInstruction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('step_number')) {
      context.handle(
        _stepNumberMeta,
        stepNumber.isAcceptableOrUnknown(data['step_number']!, _stepNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_stepNumberMeta);
    }
    if (data.containsKey('instruction_text')) {
      context.handle(
        _instructionTextMeta,
        instructionText.isAcceptableOrUnknown(
          data['instruction_text']!,
          _instructionTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_instructionTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseInstruction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseInstruction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      stepNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_number'],
      )!,
      instructionText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instruction_text'],
      )!,
    );
  }

  @override
  $ExerciseInstructionsTable createAlias(String alias) {
    return $ExerciseInstructionsTable(attachedDatabase, alias);
  }
}

class ExerciseInstruction extends DataClass
    implements Insertable<ExerciseInstruction> {
  final int id;
  final int exerciseId;
  final int stepNumber;
  final String instructionText;
  const ExerciseInstruction({
    required this.id,
    required this.exerciseId,
    required this.stepNumber,
    required this.instructionText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['step_number'] = Variable<int>(stepNumber);
    map['instruction_text'] = Variable<String>(instructionText);
    return map;
  }

  ExerciseInstructionsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseInstructionsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      stepNumber: Value(stepNumber),
      instructionText: Value(instructionText),
    );
  }

  factory ExerciseInstruction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseInstruction(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      stepNumber: serializer.fromJson<int>(json['stepNumber']),
      instructionText: serializer.fromJson<String>(json['instructionText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'stepNumber': serializer.toJson<int>(stepNumber),
      'instructionText': serializer.toJson<String>(instructionText),
    };
  }

  ExerciseInstruction copyWith({
    int? id,
    int? exerciseId,
    int? stepNumber,
    String? instructionText,
  }) => ExerciseInstruction(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    stepNumber: stepNumber ?? this.stepNumber,
    instructionText: instructionText ?? this.instructionText,
  );
  ExerciseInstruction copyWithCompanion(ExerciseInstructionsCompanion data) {
    return ExerciseInstruction(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      stepNumber: data.stepNumber.present
          ? data.stepNumber.value
          : this.stepNumber,
      instructionText: data.instructionText.present
          ? data.instructionText.value
          : this.instructionText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseInstruction(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('stepNumber: $stepNumber, ')
          ..write('instructionText: $instructionText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseId, stepNumber, instructionText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseInstruction &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.stepNumber == this.stepNumber &&
          other.instructionText == this.instructionText);
}

class ExerciseInstructionsCompanion
    extends UpdateCompanion<ExerciseInstruction> {
  final Value<int> id;
  final Value<int> exerciseId;
  final Value<int> stepNumber;
  final Value<String> instructionText;
  const ExerciseInstructionsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.stepNumber = const Value.absent(),
    this.instructionText = const Value.absent(),
  });
  ExerciseInstructionsCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseId,
    required int stepNumber,
    required String instructionText,
  }) : exerciseId = Value(exerciseId),
       stepNumber = Value(stepNumber),
       instructionText = Value(instructionText);
  static Insertable<ExerciseInstruction> custom({
    Expression<int>? id,
    Expression<int>? exerciseId,
    Expression<int>? stepNumber,
    Expression<String>? instructionText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (stepNumber != null) 'step_number': stepNumber,
      if (instructionText != null) 'instruction_text': instructionText,
    });
  }

  ExerciseInstructionsCompanion copyWith({
    Value<int>? id,
    Value<int>? exerciseId,
    Value<int>? stepNumber,
    Value<String>? instructionText,
  }) {
    return ExerciseInstructionsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      stepNumber: stepNumber ?? this.stepNumber,
      instructionText: instructionText ?? this.instructionText,
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
    if (stepNumber.present) {
      map['step_number'] = Variable<int>(stepNumber.value);
    }
    if (instructionText.present) {
      map['instruction_text'] = Variable<String>(instructionText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseInstructionsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('stepNumber: $stepNumber, ')
          ..write('instructionText: $instructionText')
          ..write(')'))
        .toString();
  }
}

class $ExerciseMuscleMapTable extends ExerciseMuscleMap
    with TableInfo<$ExerciseMuscleMapTable, ExerciseMuscleMapData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseMuscleMapTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _primaryMuscleMeta = const VerificationMeta(
    'primaryMuscle',
  );
  @override
  late final GeneratedColumn<String> primaryMuscle = GeneratedColumn<String>(
    'primary_muscle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secondaryMuscleMeta = const VerificationMeta(
    'secondaryMuscle',
  );
  @override
  late final GeneratedColumn<String> secondaryMuscle = GeneratedColumn<String>(
    'secondary_muscle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    primaryMuscle,
    secondaryMuscle,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_muscle_map';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseMuscleMapData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('primary_muscle')) {
      context.handle(
        _primaryMuscleMeta,
        primaryMuscle.isAcceptableOrUnknown(
          data['primary_muscle']!,
          _primaryMuscleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryMuscleMeta);
    }
    if (data.containsKey('secondary_muscle')) {
      context.handle(
        _secondaryMuscleMeta,
        secondaryMuscle.isAcceptableOrUnknown(
          data['secondary_muscle']!,
          _secondaryMuscleMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseMuscleMapData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseMuscleMapData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      primaryMuscle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_muscle'],
      )!,
      secondaryMuscle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_muscle'],
      ),
    );
  }

  @override
  $ExerciseMuscleMapTable createAlias(String alias) {
    return $ExerciseMuscleMapTable(attachedDatabase, alias);
  }
}

class ExerciseMuscleMapData extends DataClass
    implements Insertable<ExerciseMuscleMapData> {
  final int id;
  final int exerciseId;
  final String primaryMuscle;
  final String? secondaryMuscle;
  const ExerciseMuscleMapData({
    required this.id,
    required this.exerciseId,
    required this.primaryMuscle,
    this.secondaryMuscle,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['primary_muscle'] = Variable<String>(primaryMuscle);
    if (!nullToAbsent || secondaryMuscle != null) {
      map['secondary_muscle'] = Variable<String>(secondaryMuscle);
    }
    return map;
  }

  ExerciseMuscleMapCompanion toCompanion(bool nullToAbsent) {
    return ExerciseMuscleMapCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      primaryMuscle: Value(primaryMuscle),
      secondaryMuscle: secondaryMuscle == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryMuscle),
    );
  }

  factory ExerciseMuscleMapData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseMuscleMapData(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      primaryMuscle: serializer.fromJson<String>(json['primaryMuscle']),
      secondaryMuscle: serializer.fromJson<String?>(json['secondaryMuscle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'primaryMuscle': serializer.toJson<String>(primaryMuscle),
      'secondaryMuscle': serializer.toJson<String?>(secondaryMuscle),
    };
  }

  ExerciseMuscleMapData copyWith({
    int? id,
    int? exerciseId,
    String? primaryMuscle,
    Value<String?> secondaryMuscle = const Value.absent(),
  }) => ExerciseMuscleMapData(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    primaryMuscle: primaryMuscle ?? this.primaryMuscle,
    secondaryMuscle: secondaryMuscle.present
        ? secondaryMuscle.value
        : this.secondaryMuscle,
  );
  ExerciseMuscleMapData copyWithCompanion(ExerciseMuscleMapCompanion data) {
    return ExerciseMuscleMapData(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      primaryMuscle: data.primaryMuscle.present
          ? data.primaryMuscle.value
          : this.primaryMuscle,
      secondaryMuscle: data.secondaryMuscle.present
          ? data.secondaryMuscle.value
          : this.secondaryMuscle,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseMuscleMapData(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('primaryMuscle: $primaryMuscle, ')
          ..write('secondaryMuscle: $secondaryMuscle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, exerciseId, primaryMuscle, secondaryMuscle);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseMuscleMapData &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.primaryMuscle == this.primaryMuscle &&
          other.secondaryMuscle == this.secondaryMuscle);
}

class ExerciseMuscleMapCompanion
    extends UpdateCompanion<ExerciseMuscleMapData> {
  final Value<int> id;
  final Value<int> exerciseId;
  final Value<String> primaryMuscle;
  final Value<String?> secondaryMuscle;
  const ExerciseMuscleMapCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.primaryMuscle = const Value.absent(),
    this.secondaryMuscle = const Value.absent(),
  });
  ExerciseMuscleMapCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseId,
    required String primaryMuscle,
    this.secondaryMuscle = const Value.absent(),
  }) : exerciseId = Value(exerciseId),
       primaryMuscle = Value(primaryMuscle);
  static Insertable<ExerciseMuscleMapData> custom({
    Expression<int>? id,
    Expression<int>? exerciseId,
    Expression<String>? primaryMuscle,
    Expression<String>? secondaryMuscle,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (primaryMuscle != null) 'primary_muscle': primaryMuscle,
      if (secondaryMuscle != null) 'secondary_muscle': secondaryMuscle,
    });
  }

  ExerciseMuscleMapCompanion copyWith({
    Value<int>? id,
    Value<int>? exerciseId,
    Value<String>? primaryMuscle,
    Value<String?>? secondaryMuscle,
  }) {
    return ExerciseMuscleMapCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      primaryMuscle: primaryMuscle ?? this.primaryMuscle,
      secondaryMuscle: secondaryMuscle ?? this.secondaryMuscle,
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
    if (primaryMuscle.present) {
      map['primary_muscle'] = Variable<String>(primaryMuscle.value);
    }
    if (secondaryMuscle.present) {
      map['secondary_muscle'] = Variable<String>(secondaryMuscle.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseMuscleMapCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('primaryMuscle: $primaryMuscle, ')
          ..write('secondaryMuscle: $secondaryMuscle')
          ..write(')'))
        .toString();
  }
}

class $MesocycleExercisesTable extends MesocycleExercises
    with TableInfo<$MesocycleExercisesTable, MesocycleExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MesocycleExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mesocycleDayIdMeta = const VerificationMeta(
    'mesocycleDayId',
  );
  @override
  late final GeneratedColumn<int> mesocycleDayId = GeneratedColumn<int>(
    'mesocycle_day_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mesocycle_days (id)',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _exerciseOrderMeta = const VerificationMeta(
    'exerciseOrder',
  );
  @override
  late final GeneratedColumn<int> exerciseOrder = GeneratedColumn<int>(
    'exercise_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetSetsMeta = const VerificationMeta(
    'targetSets',
  );
  @override
  late final GeneratedColumn<int> targetSets = GeneratedColumn<int>(
    'target_sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minRepsMeta = const VerificationMeta(
    'minReps',
  );
  @override
  late final GeneratedColumn<int> minReps = GeneratedColumn<int>(
    'min_reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxRepsMeta = const VerificationMeta(
    'maxReps',
  );
  @override
  late final GeneratedColumn<int> maxReps = GeneratedColumn<int>(
    'max_reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetRpeMeta = const VerificationMeta(
    'targetRpe',
  );
  @override
  late final GeneratedColumn<double> targetRpe = GeneratedColumn<double>(
    'target_rpe',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _progressionTypeMeta = const VerificationMeta(
    'progressionType',
  );
  @override
  late final GeneratedColumn<String> progressionType = GeneratedColumn<String>(
    'progression_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _progressionValueMeta = const VerificationMeta(
    'progressionValue',
  );
  @override
  late final GeneratedColumn<double> progressionValue = GeneratedColumn<double>(
    'progression_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mesocycleDayId,
    exerciseId,
    exerciseOrder,
    targetSets,
    minReps,
    maxReps,
    targetRpe,
    progressionType,
    progressionValue,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mesocycle_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<MesocycleExercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mesocycle_day_id')) {
      context.handle(
        _mesocycleDayIdMeta,
        mesocycleDayId.isAcceptableOrUnknown(
          data['mesocycle_day_id']!,
          _mesocycleDayIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mesocycleDayIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('exercise_order')) {
      context.handle(
        _exerciseOrderMeta,
        exerciseOrder.isAcceptableOrUnknown(
          data['exercise_order']!,
          _exerciseOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseOrderMeta);
    }
    if (data.containsKey('target_sets')) {
      context.handle(
        _targetSetsMeta,
        targetSets.isAcceptableOrUnknown(data['target_sets']!, _targetSetsMeta),
      );
    } else if (isInserting) {
      context.missing(_targetSetsMeta);
    }
    if (data.containsKey('min_reps')) {
      context.handle(
        _minRepsMeta,
        minReps.isAcceptableOrUnknown(data['min_reps']!, _minRepsMeta),
      );
    } else if (isInserting) {
      context.missing(_minRepsMeta);
    }
    if (data.containsKey('max_reps')) {
      context.handle(
        _maxRepsMeta,
        maxReps.isAcceptableOrUnknown(data['max_reps']!, _maxRepsMeta),
      );
    } else if (isInserting) {
      context.missing(_maxRepsMeta);
    }
    if (data.containsKey('target_rpe')) {
      context.handle(
        _targetRpeMeta,
        targetRpe.isAcceptableOrUnknown(data['target_rpe']!, _targetRpeMeta),
      );
    }
    if (data.containsKey('progression_type')) {
      context.handle(
        _progressionTypeMeta,
        progressionType.isAcceptableOrUnknown(
          data['progression_type']!,
          _progressionTypeMeta,
        ),
      );
    }
    if (data.containsKey('progression_value')) {
      context.handle(
        _progressionValueMeta,
        progressionValue.isAcceptableOrUnknown(
          data['progression_value']!,
          _progressionValueMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MesocycleExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MesocycleExercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mesocycleDayId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mesocycle_day_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      exerciseOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_order'],
      )!,
      targetSets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_sets'],
      )!,
      minReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_reps'],
      )!,
      maxReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_reps'],
      )!,
      targetRpe: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_rpe'],
      ),
      progressionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}progression_type'],
      )!,
      progressionValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progression_value'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $MesocycleExercisesTable createAlias(String alias) {
    return $MesocycleExercisesTable(attachedDatabase, alias);
  }
}

class MesocycleExercise extends DataClass
    implements Insertable<MesocycleExercise> {
  final int id;
  final int mesocycleDayId;
  final int exerciseId;
  final int exerciseOrder;
  final int targetSets;
  final int minReps;
  final int maxReps;
  final double? targetRpe;
  final String progressionType;
  final double? progressionValue;
  final String? notes;
  const MesocycleExercise({
    required this.id,
    required this.mesocycleDayId,
    required this.exerciseId,
    required this.exerciseOrder,
    required this.targetSets,
    required this.minReps,
    required this.maxReps,
    this.targetRpe,
    required this.progressionType,
    this.progressionValue,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mesocycle_day_id'] = Variable<int>(mesocycleDayId);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['exercise_order'] = Variable<int>(exerciseOrder);
    map['target_sets'] = Variable<int>(targetSets);
    map['min_reps'] = Variable<int>(minReps);
    map['max_reps'] = Variable<int>(maxReps);
    if (!nullToAbsent || targetRpe != null) {
      map['target_rpe'] = Variable<double>(targetRpe);
    }
    map['progression_type'] = Variable<String>(progressionType);
    if (!nullToAbsent || progressionValue != null) {
      map['progression_value'] = Variable<double>(progressionValue);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MesocycleExercisesCompanion toCompanion(bool nullToAbsent) {
    return MesocycleExercisesCompanion(
      id: Value(id),
      mesocycleDayId: Value(mesocycleDayId),
      exerciseId: Value(exerciseId),
      exerciseOrder: Value(exerciseOrder),
      targetSets: Value(targetSets),
      minReps: Value(minReps),
      maxReps: Value(maxReps),
      targetRpe: targetRpe == null && nullToAbsent
          ? const Value.absent()
          : Value(targetRpe),
      progressionType: Value(progressionType),
      progressionValue: progressionValue == null && nullToAbsent
          ? const Value.absent()
          : Value(progressionValue),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory MesocycleExercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MesocycleExercise(
      id: serializer.fromJson<int>(json['id']),
      mesocycleDayId: serializer.fromJson<int>(json['mesocycleDayId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      exerciseOrder: serializer.fromJson<int>(json['exerciseOrder']),
      targetSets: serializer.fromJson<int>(json['targetSets']),
      minReps: serializer.fromJson<int>(json['minReps']),
      maxReps: serializer.fromJson<int>(json['maxReps']),
      targetRpe: serializer.fromJson<double?>(json['targetRpe']),
      progressionType: serializer.fromJson<String>(json['progressionType']),
      progressionValue: serializer.fromJson<double?>(json['progressionValue']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mesocycleDayId': serializer.toJson<int>(mesocycleDayId),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'exerciseOrder': serializer.toJson<int>(exerciseOrder),
      'targetSets': serializer.toJson<int>(targetSets),
      'minReps': serializer.toJson<int>(minReps),
      'maxReps': serializer.toJson<int>(maxReps),
      'targetRpe': serializer.toJson<double?>(targetRpe),
      'progressionType': serializer.toJson<String>(progressionType),
      'progressionValue': serializer.toJson<double?>(progressionValue),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MesocycleExercise copyWith({
    int? id,
    int? mesocycleDayId,
    int? exerciseId,
    int? exerciseOrder,
    int? targetSets,
    int? minReps,
    int? maxReps,
    Value<double?> targetRpe = const Value.absent(),
    String? progressionType,
    Value<double?> progressionValue = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => MesocycleExercise(
    id: id ?? this.id,
    mesocycleDayId: mesocycleDayId ?? this.mesocycleDayId,
    exerciseId: exerciseId ?? this.exerciseId,
    exerciseOrder: exerciseOrder ?? this.exerciseOrder,
    targetSets: targetSets ?? this.targetSets,
    minReps: minReps ?? this.minReps,
    maxReps: maxReps ?? this.maxReps,
    targetRpe: targetRpe.present ? targetRpe.value : this.targetRpe,
    progressionType: progressionType ?? this.progressionType,
    progressionValue: progressionValue.present
        ? progressionValue.value
        : this.progressionValue,
    notes: notes.present ? notes.value : this.notes,
  );
  MesocycleExercise copyWithCompanion(MesocycleExercisesCompanion data) {
    return MesocycleExercise(
      id: data.id.present ? data.id.value : this.id,
      mesocycleDayId: data.mesocycleDayId.present
          ? data.mesocycleDayId.value
          : this.mesocycleDayId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      exerciseOrder: data.exerciseOrder.present
          ? data.exerciseOrder.value
          : this.exerciseOrder,
      targetSets: data.targetSets.present
          ? data.targetSets.value
          : this.targetSets,
      minReps: data.minReps.present ? data.minReps.value : this.minReps,
      maxReps: data.maxReps.present ? data.maxReps.value : this.maxReps,
      targetRpe: data.targetRpe.present ? data.targetRpe.value : this.targetRpe,
      progressionType: data.progressionType.present
          ? data.progressionType.value
          : this.progressionType,
      progressionValue: data.progressionValue.present
          ? data.progressionValue.value
          : this.progressionValue,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MesocycleExercise(')
          ..write('id: $id, ')
          ..write('mesocycleDayId: $mesocycleDayId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('exerciseOrder: $exerciseOrder, ')
          ..write('targetSets: $targetSets, ')
          ..write('minReps: $minReps, ')
          ..write('maxReps: $maxReps, ')
          ..write('targetRpe: $targetRpe, ')
          ..write('progressionType: $progressionType, ')
          ..write('progressionValue: $progressionValue, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mesocycleDayId,
    exerciseId,
    exerciseOrder,
    targetSets,
    minReps,
    maxReps,
    targetRpe,
    progressionType,
    progressionValue,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MesocycleExercise &&
          other.id == this.id &&
          other.mesocycleDayId == this.mesocycleDayId &&
          other.exerciseId == this.exerciseId &&
          other.exerciseOrder == this.exerciseOrder &&
          other.targetSets == this.targetSets &&
          other.minReps == this.minReps &&
          other.maxReps == this.maxReps &&
          other.targetRpe == this.targetRpe &&
          other.progressionType == this.progressionType &&
          other.progressionValue == this.progressionValue &&
          other.notes == this.notes);
}

class MesocycleExercisesCompanion extends UpdateCompanion<MesocycleExercise> {
  final Value<int> id;
  final Value<int> mesocycleDayId;
  final Value<int> exerciseId;
  final Value<int> exerciseOrder;
  final Value<int> targetSets;
  final Value<int> minReps;
  final Value<int> maxReps;
  final Value<double?> targetRpe;
  final Value<String> progressionType;
  final Value<double?> progressionValue;
  final Value<String?> notes;
  const MesocycleExercisesCompanion({
    this.id = const Value.absent(),
    this.mesocycleDayId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.exerciseOrder = const Value.absent(),
    this.targetSets = const Value.absent(),
    this.minReps = const Value.absent(),
    this.maxReps = const Value.absent(),
    this.targetRpe = const Value.absent(),
    this.progressionType = const Value.absent(),
    this.progressionValue = const Value.absent(),
    this.notes = const Value.absent(),
  });
  MesocycleExercisesCompanion.insert({
    this.id = const Value.absent(),
    required int mesocycleDayId,
    required int exerciseId,
    required int exerciseOrder,
    required int targetSets,
    required int minReps,
    required int maxReps,
    this.targetRpe = const Value.absent(),
    this.progressionType = const Value.absent(),
    this.progressionValue = const Value.absent(),
    this.notes = const Value.absent(),
  }) : mesocycleDayId = Value(mesocycleDayId),
       exerciseId = Value(exerciseId),
       exerciseOrder = Value(exerciseOrder),
       targetSets = Value(targetSets),
       minReps = Value(minReps),
       maxReps = Value(maxReps);
  static Insertable<MesocycleExercise> custom({
    Expression<int>? id,
    Expression<int>? mesocycleDayId,
    Expression<int>? exerciseId,
    Expression<int>? exerciseOrder,
    Expression<int>? targetSets,
    Expression<int>? minReps,
    Expression<int>? maxReps,
    Expression<double>? targetRpe,
    Expression<String>? progressionType,
    Expression<double>? progressionValue,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mesocycleDayId != null) 'mesocycle_day_id': mesocycleDayId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (exerciseOrder != null) 'exercise_order': exerciseOrder,
      if (targetSets != null) 'target_sets': targetSets,
      if (minReps != null) 'min_reps': minReps,
      if (maxReps != null) 'max_reps': maxReps,
      if (targetRpe != null) 'target_rpe': targetRpe,
      if (progressionType != null) 'progression_type': progressionType,
      if (progressionValue != null) 'progression_value': progressionValue,
      if (notes != null) 'notes': notes,
    });
  }

  MesocycleExercisesCompanion copyWith({
    Value<int>? id,
    Value<int>? mesocycleDayId,
    Value<int>? exerciseId,
    Value<int>? exerciseOrder,
    Value<int>? targetSets,
    Value<int>? minReps,
    Value<int>? maxReps,
    Value<double?>? targetRpe,
    Value<String>? progressionType,
    Value<double?>? progressionValue,
    Value<String?>? notes,
  }) {
    return MesocycleExercisesCompanion(
      id: id ?? this.id,
      mesocycleDayId: mesocycleDayId ?? this.mesocycleDayId,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseOrder: exerciseOrder ?? this.exerciseOrder,
      targetSets: targetSets ?? this.targetSets,
      minReps: minReps ?? this.minReps,
      maxReps: maxReps ?? this.maxReps,
      targetRpe: targetRpe ?? this.targetRpe,
      progressionType: progressionType ?? this.progressionType,
      progressionValue: progressionValue ?? this.progressionValue,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mesocycleDayId.present) {
      map['mesocycle_day_id'] = Variable<int>(mesocycleDayId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (exerciseOrder.present) {
      map['exercise_order'] = Variable<int>(exerciseOrder.value);
    }
    if (targetSets.present) {
      map['target_sets'] = Variable<int>(targetSets.value);
    }
    if (minReps.present) {
      map['min_reps'] = Variable<int>(minReps.value);
    }
    if (maxReps.present) {
      map['max_reps'] = Variable<int>(maxReps.value);
    }
    if (targetRpe.present) {
      map['target_rpe'] = Variable<double>(targetRpe.value);
    }
    if (progressionType.present) {
      map['progression_type'] = Variable<String>(progressionType.value);
    }
    if (progressionValue.present) {
      map['progression_value'] = Variable<double>(progressionValue.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MesocycleExercisesCompanion(')
          ..write('id: $id, ')
          ..write('mesocycleDayId: $mesocycleDayId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('exerciseOrder: $exerciseOrder, ')
          ..write('targetSets: $targetSets, ')
          ..write('minReps: $minReps, ')
          ..write('maxReps: $maxReps, ')
          ..write('targetRpe: $targetRpe, ')
          ..write('progressionType: $progressionType, ')
          ..write('progressionValue: $progressionValue, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $UserProgramProgressTable extends UserProgramProgress
    with TableInfo<$UserProgramProgressTable, UserProgramProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProgramProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mesocycleIdMeta = const VerificationMeta(
    'mesocycleId',
  );
  @override
  late final GeneratedColumn<int> mesocycleId = GeneratedColumn<int>(
    'mesocycle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mesocycles (id)',
    ),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentPhaseIndexMeta = const VerificationMeta(
    'currentPhaseIndex',
  );
  @override
  late final GeneratedColumn<int> currentPhaseIndex = GeneratedColumn<int>(
    'current_phase_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastPhaseAlertAtMeta = const VerificationMeta(
    'lastPhaseAlertAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastPhaseAlertAt =
      GeneratedColumn<DateTime>(
        'last_phase_alert_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mesocycleId,
    startDate,
    currentPhaseIndex,
    isCompleted,
    lastPhaseAlertAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_program_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProgramProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mesocycle_id')) {
      context.handle(
        _mesocycleIdMeta,
        mesocycleId.isAcceptableOrUnknown(
          data['mesocycle_id']!,
          _mesocycleIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mesocycleIdMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('current_phase_index')) {
      context.handle(
        _currentPhaseIndexMeta,
        currentPhaseIndex.isAcceptableOrUnknown(
          data['current_phase_index']!,
          _currentPhaseIndexMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('last_phase_alert_at')) {
      context.handle(
        _lastPhaseAlertAtMeta,
        lastPhaseAlertAt.isAcceptableOrUnknown(
          data['last_phase_alert_at']!,
          _lastPhaseAlertAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProgramProgressData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProgramProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mesocycleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mesocycle_id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      currentPhaseIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_phase_index'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      lastPhaseAlertAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_phase_alert_at'],
      ),
    );
  }

  @override
  $UserProgramProgressTable createAlias(String alias) {
    return $UserProgramProgressTable(attachedDatabase, alias);
  }
}

class UserProgramProgressData extends DataClass
    implements Insertable<UserProgramProgressData> {
  final int id;
  final int mesocycleId;
  final DateTime startDate;
  final int currentPhaseIndex;
  final bool isCompleted;
  final DateTime? lastPhaseAlertAt;
  const UserProgramProgressData({
    required this.id,
    required this.mesocycleId,
    required this.startDate,
    required this.currentPhaseIndex,
    required this.isCompleted,
    this.lastPhaseAlertAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mesocycle_id'] = Variable<int>(mesocycleId);
    map['start_date'] = Variable<DateTime>(startDate);
    map['current_phase_index'] = Variable<int>(currentPhaseIndex);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || lastPhaseAlertAt != null) {
      map['last_phase_alert_at'] = Variable<DateTime>(lastPhaseAlertAt);
    }
    return map;
  }

  UserProgramProgressCompanion toCompanion(bool nullToAbsent) {
    return UserProgramProgressCompanion(
      id: Value(id),
      mesocycleId: Value(mesocycleId),
      startDate: Value(startDate),
      currentPhaseIndex: Value(currentPhaseIndex),
      isCompleted: Value(isCompleted),
      lastPhaseAlertAt: lastPhaseAlertAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPhaseAlertAt),
    );
  }

  factory UserProgramProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProgramProgressData(
      id: serializer.fromJson<int>(json['id']),
      mesocycleId: serializer.fromJson<int>(json['mesocycleId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      currentPhaseIndex: serializer.fromJson<int>(json['currentPhaseIndex']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      lastPhaseAlertAt: serializer.fromJson<DateTime?>(
        json['lastPhaseAlertAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mesocycleId': serializer.toJson<int>(mesocycleId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'currentPhaseIndex': serializer.toJson<int>(currentPhaseIndex),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'lastPhaseAlertAt': serializer.toJson<DateTime?>(lastPhaseAlertAt),
    };
  }

  UserProgramProgressData copyWith({
    int? id,
    int? mesocycleId,
    DateTime? startDate,
    int? currentPhaseIndex,
    bool? isCompleted,
    Value<DateTime?> lastPhaseAlertAt = const Value.absent(),
  }) => UserProgramProgressData(
    id: id ?? this.id,
    mesocycleId: mesocycleId ?? this.mesocycleId,
    startDate: startDate ?? this.startDate,
    currentPhaseIndex: currentPhaseIndex ?? this.currentPhaseIndex,
    isCompleted: isCompleted ?? this.isCompleted,
    lastPhaseAlertAt: lastPhaseAlertAt.present
        ? lastPhaseAlertAt.value
        : this.lastPhaseAlertAt,
  );
  UserProgramProgressData copyWithCompanion(UserProgramProgressCompanion data) {
    return UserProgramProgressData(
      id: data.id.present ? data.id.value : this.id,
      mesocycleId: data.mesocycleId.present
          ? data.mesocycleId.value
          : this.mesocycleId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      currentPhaseIndex: data.currentPhaseIndex.present
          ? data.currentPhaseIndex.value
          : this.currentPhaseIndex,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      lastPhaseAlertAt: data.lastPhaseAlertAt.present
          ? data.lastPhaseAlertAt.value
          : this.lastPhaseAlertAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProgramProgressData(')
          ..write('id: $id, ')
          ..write('mesocycleId: $mesocycleId, ')
          ..write('startDate: $startDate, ')
          ..write('currentPhaseIndex: $currentPhaseIndex, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('lastPhaseAlertAt: $lastPhaseAlertAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mesocycleId,
    startDate,
    currentPhaseIndex,
    isCompleted,
    lastPhaseAlertAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProgramProgressData &&
          other.id == this.id &&
          other.mesocycleId == this.mesocycleId &&
          other.startDate == this.startDate &&
          other.currentPhaseIndex == this.currentPhaseIndex &&
          other.isCompleted == this.isCompleted &&
          other.lastPhaseAlertAt == this.lastPhaseAlertAt);
}

class UserProgramProgressCompanion
    extends UpdateCompanion<UserProgramProgressData> {
  final Value<int> id;
  final Value<int> mesocycleId;
  final Value<DateTime> startDate;
  final Value<int> currentPhaseIndex;
  final Value<bool> isCompleted;
  final Value<DateTime?> lastPhaseAlertAt;
  const UserProgramProgressCompanion({
    this.id = const Value.absent(),
    this.mesocycleId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.currentPhaseIndex = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.lastPhaseAlertAt = const Value.absent(),
  });
  UserProgramProgressCompanion.insert({
    this.id = const Value.absent(),
    required int mesocycleId,
    required DateTime startDate,
    this.currentPhaseIndex = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.lastPhaseAlertAt = const Value.absent(),
  }) : mesocycleId = Value(mesocycleId),
       startDate = Value(startDate);
  static Insertable<UserProgramProgressData> custom({
    Expression<int>? id,
    Expression<int>? mesocycleId,
    Expression<DateTime>? startDate,
    Expression<int>? currentPhaseIndex,
    Expression<bool>? isCompleted,
    Expression<DateTime>? lastPhaseAlertAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mesocycleId != null) 'mesocycle_id': mesocycleId,
      if (startDate != null) 'start_date': startDate,
      if (currentPhaseIndex != null) 'current_phase_index': currentPhaseIndex,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (lastPhaseAlertAt != null) 'last_phase_alert_at': lastPhaseAlertAt,
    });
  }

  UserProgramProgressCompanion copyWith({
    Value<int>? id,
    Value<int>? mesocycleId,
    Value<DateTime>? startDate,
    Value<int>? currentPhaseIndex,
    Value<bool>? isCompleted,
    Value<DateTime?>? lastPhaseAlertAt,
  }) {
    return UserProgramProgressCompanion(
      id: id ?? this.id,
      mesocycleId: mesocycleId ?? this.mesocycleId,
      startDate: startDate ?? this.startDate,
      currentPhaseIndex: currentPhaseIndex ?? this.currentPhaseIndex,
      isCompleted: isCompleted ?? this.isCompleted,
      lastPhaseAlertAt: lastPhaseAlertAt ?? this.lastPhaseAlertAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mesocycleId.present) {
      map['mesocycle_id'] = Variable<int>(mesocycleId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (currentPhaseIndex.present) {
      map['current_phase_index'] = Variable<int>(currentPhaseIndex.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (lastPhaseAlertAt.present) {
      map['last_phase_alert_at'] = Variable<DateTime>(lastPhaseAlertAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProgramProgressCompanion(')
          ..write('id: $id, ')
          ..write('mesocycleId: $mesocycleId, ')
          ..write('startDate: $startDate, ')
          ..write('currentPhaseIndex: $currentPhaseIndex, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('lastPhaseAlertAt: $lastPhaseAlertAt')
          ..write(')'))
        .toString();
  }
}

class $Exercise1RmSnapshotsTable extends Exercise1RmSnapshots
    with TableInfo<$Exercise1RmSnapshotsTable, Exercise1RmSnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Exercise1RmSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _workoutIdMeta = const VerificationMeta(
    'workoutId',
  );
  @override
  late final GeneratedColumn<int> workoutId = GeneratedColumn<int>(
    'workout_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workouts (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<double> reps = GeneratedColumn<double>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimated1RmMeta = const VerificationMeta(
    'estimated1Rm',
  );
  @override
  late final GeneratedColumn<double> estimated1Rm = GeneratedColumn<double>(
    'estimated1_rm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formulaMeta = const VerificationMeta(
    'formula',
  );
  @override
  late final GeneratedColumn<String> formula = GeneratedColumn<String>(
    'formula',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPrMeta = const VerificationMeta('isPr');
  @override
  late final GeneratedColumn<bool> isPr = GeneratedColumn<bool>(
    'is_pr',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pr" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    workoutId,
    date,
    weight,
    reps,
    estimated1Rm,
    formula,
    isPr,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise1_rm_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exercise1RmSnapshot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('workout_id')) {
      context.handle(
        _workoutIdMeta,
        workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('estimated1_rm')) {
      context.handle(
        _estimated1RmMeta,
        estimated1Rm.isAcceptableOrUnknown(
          data['estimated1_rm']!,
          _estimated1RmMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimated1RmMeta);
    }
    if (data.containsKey('formula')) {
      context.handle(
        _formulaMeta,
        formula.isAcceptableOrUnknown(data['formula']!, _formulaMeta),
      );
    } else if (isInserting) {
      context.missing(_formulaMeta);
    }
    if (data.containsKey('is_pr')) {
      context.handle(
        _isPrMeta,
        isPr.isAcceptableOrUnknown(data['is_pr']!, _isPrMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise1RmSnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise1RmSnapshot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      workoutId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workout_id'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reps'],
      )!,
      estimated1Rm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated1_rm'],
      )!,
      formula: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formula'],
      )!,
      isPr: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pr'],
      )!,
    );
  }

  @override
  $Exercise1RmSnapshotsTable createAlias(String alias) {
    return $Exercise1RmSnapshotsTable(attachedDatabase, alias);
  }
}

class Exercise1RmSnapshot extends DataClass
    implements Insertable<Exercise1RmSnapshot> {
  final int id;
  final int exerciseId;
  final int? workoutId;
  final DateTime date;
  final double weight;
  final double reps;
  final double estimated1Rm;
  final String formula;
  final bool isPr;
  const Exercise1RmSnapshot({
    required this.id,
    required this.exerciseId,
    this.workoutId,
    required this.date,
    required this.weight,
    required this.reps,
    required this.estimated1Rm,
    required this.formula,
    required this.isPr,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<int>(exerciseId);
    if (!nullToAbsent || workoutId != null) {
      map['workout_id'] = Variable<int>(workoutId);
    }
    map['date'] = Variable<DateTime>(date);
    map['weight'] = Variable<double>(weight);
    map['reps'] = Variable<double>(reps);
    map['estimated1_rm'] = Variable<double>(estimated1Rm);
    map['formula'] = Variable<String>(formula);
    map['is_pr'] = Variable<bool>(isPr);
    return map;
  }

  Exercise1RmSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return Exercise1RmSnapshotsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      workoutId: workoutId == null && nullToAbsent
          ? const Value.absent()
          : Value(workoutId),
      date: Value(date),
      weight: Value(weight),
      reps: Value(reps),
      estimated1Rm: Value(estimated1Rm),
      formula: Value(formula),
      isPr: Value(isPr),
    );
  }

  factory Exercise1RmSnapshot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise1RmSnapshot(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      workoutId: serializer.fromJson<int?>(json['workoutId']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double>(json['weight']),
      reps: serializer.fromJson<double>(json['reps']),
      estimated1Rm: serializer.fromJson<double>(json['estimated1Rm']),
      formula: serializer.fromJson<String>(json['formula']),
      isPr: serializer.fromJson<bool>(json['isPr']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'workoutId': serializer.toJson<int?>(workoutId),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double>(weight),
      'reps': serializer.toJson<double>(reps),
      'estimated1Rm': serializer.toJson<double>(estimated1Rm),
      'formula': serializer.toJson<String>(formula),
      'isPr': serializer.toJson<bool>(isPr),
    };
  }

  Exercise1RmSnapshot copyWith({
    int? id,
    int? exerciseId,
    Value<int?> workoutId = const Value.absent(),
    DateTime? date,
    double? weight,
    double? reps,
    double? estimated1Rm,
    String? formula,
    bool? isPr,
  }) => Exercise1RmSnapshot(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    workoutId: workoutId.present ? workoutId.value : this.workoutId,
    date: date ?? this.date,
    weight: weight ?? this.weight,
    reps: reps ?? this.reps,
    estimated1Rm: estimated1Rm ?? this.estimated1Rm,
    formula: formula ?? this.formula,
    isPr: isPr ?? this.isPr,
  );
  Exercise1RmSnapshot copyWithCompanion(Exercise1RmSnapshotsCompanion data) {
    return Exercise1RmSnapshot(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
      reps: data.reps.present ? data.reps.value : this.reps,
      estimated1Rm: data.estimated1Rm.present
          ? data.estimated1Rm.value
          : this.estimated1Rm,
      formula: data.formula.present ? data.formula.value : this.formula,
      isPr: data.isPr.present ? data.isPr.value : this.isPr,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise1RmSnapshot(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('workoutId: $workoutId, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps, ')
          ..write('estimated1Rm: $estimated1Rm, ')
          ..write('formula: $formula, ')
          ..write('isPr: $isPr')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    exerciseId,
    workoutId,
    date,
    weight,
    reps,
    estimated1Rm,
    formula,
    isPr,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise1RmSnapshot &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.workoutId == this.workoutId &&
          other.date == this.date &&
          other.weight == this.weight &&
          other.reps == this.reps &&
          other.estimated1Rm == this.estimated1Rm &&
          other.formula == this.formula &&
          other.isPr == this.isPr);
}

class Exercise1RmSnapshotsCompanion
    extends UpdateCompanion<Exercise1RmSnapshot> {
  final Value<int> id;
  final Value<int> exerciseId;
  final Value<int?> workoutId;
  final Value<DateTime> date;
  final Value<double> weight;
  final Value<double> reps;
  final Value<double> estimated1Rm;
  final Value<String> formula;
  final Value<bool> isPr;
  const Exercise1RmSnapshotsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.reps = const Value.absent(),
    this.estimated1Rm = const Value.absent(),
    this.formula = const Value.absent(),
    this.isPr = const Value.absent(),
  });
  Exercise1RmSnapshotsCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseId,
    this.workoutId = const Value.absent(),
    required DateTime date,
    required double weight,
    required double reps,
    required double estimated1Rm,
    required String formula,
    this.isPr = const Value.absent(),
  }) : exerciseId = Value(exerciseId),
       date = Value(date),
       weight = Value(weight),
       reps = Value(reps),
       estimated1Rm = Value(estimated1Rm),
       formula = Value(formula);
  static Insertable<Exercise1RmSnapshot> custom({
    Expression<int>? id,
    Expression<int>? exerciseId,
    Expression<int>? workoutId,
    Expression<DateTime>? date,
    Expression<double>? weight,
    Expression<double>? reps,
    Expression<double>? estimated1Rm,
    Expression<String>? formula,
    Expression<bool>? isPr,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (workoutId != null) 'workout_id': workoutId,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
      if (reps != null) 'reps': reps,
      if (estimated1Rm != null) 'estimated1_rm': estimated1Rm,
      if (formula != null) 'formula': formula,
      if (isPr != null) 'is_pr': isPr,
    });
  }

  Exercise1RmSnapshotsCompanion copyWith({
    Value<int>? id,
    Value<int>? exerciseId,
    Value<int?>? workoutId,
    Value<DateTime>? date,
    Value<double>? weight,
    Value<double>? reps,
    Value<double>? estimated1Rm,
    Value<String>? formula,
    Value<bool>? isPr,
  }) {
    return Exercise1RmSnapshotsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      workoutId: workoutId ?? this.workoutId,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      estimated1Rm: estimated1Rm ?? this.estimated1Rm,
      formula: formula ?? this.formula,
      isPr: isPr ?? this.isPr,
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
    if (workoutId.present) {
      map['workout_id'] = Variable<int>(workoutId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (reps.present) {
      map['reps'] = Variable<double>(reps.value);
    }
    if (estimated1Rm.present) {
      map['estimated1_rm'] = Variable<double>(estimated1Rm.value);
    }
    if (formula.present) {
      map['formula'] = Variable<String>(formula.value);
    }
    if (isPr.present) {
      map['is_pr'] = Variable<bool>(isPr.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Exercise1RmSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('workoutId: $workoutId, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps, ')
          ..write('estimated1Rm: $estimated1Rm, ')
          ..write('formula: $formula, ')
          ..write('isPr: $isPr')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $WorkoutTemplatesTable workoutTemplates = $WorkoutTemplatesTable(
    this,
  );
  late final $TemplateDaysTable templateDays = $TemplateDaysTable(this);
  late final $TemplateExercisesTable templateExercises =
      $TemplateExercisesTable(this);
  late final $MesocyclesTable mesocycles = $MesocyclesTable(this);
  late final $MesocycleWeeksTable mesocycleWeeks = $MesocycleWeeksTable(this);
  late final $MesocycleDaysTable mesocycleDays = $MesocycleDaysTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $WorkoutSetsTable workoutSets = $WorkoutSetsTable(this);
  late final $BodyMeasurementsTable bodyMeasurements = $BodyMeasurementsTable(
    this,
  );
  late final $BodyTargetsTable bodyTargets = $BodyTargetsTable(this);
  late final $ProgressPhotosTable progressPhotos = $ProgressPhotosTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $ExerciseProgressionSettingsTable exerciseProgressionSettings =
      $ExerciseProgressionSettingsTable(this);
  late final $ExerciseMusclesTable exerciseMuscles = $ExerciseMusclesTable(
    this,
  );
  late final $ExerciseBodyPartsTable exerciseBodyParts =
      $ExerciseBodyPartsTable(this);
  late final $ExerciseEnrichedContentTable exerciseEnrichedContent =
      $ExerciseEnrichedContentTable(this);
  late final $RecentExercisesTable recentExercises = $RecentExercisesTable(
    this,
  );
  late final $ExerciseProgressionsTable exerciseProgressions =
      $ExerciseProgressionsTable(this);
  late final $ExerciseInstructionsTable exerciseInstructions =
      $ExerciseInstructionsTable(this);
  late final $ExerciseMuscleMapTable exerciseMuscleMap =
      $ExerciseMuscleMapTable(this);
  late final $MesocycleExercisesTable mesocycleExercises =
      $MesocycleExercisesTable(this);
  late final $UserProgramProgressTable userProgramProgress =
      $UserProgramProgressTable(this);
  late final $Exercise1RmSnapshotsTable exercise1RmSnapshots =
      $Exercise1RmSnapshotsTable(this);
  late final BodyMapDao bodyMapDao = BodyMapDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    exercises,
    workoutTemplates,
    templateDays,
    templateExercises,
    mesocycles,
    mesocycleWeeks,
    mesocycleDays,
    workouts,
    workoutSets,
    bodyMeasurements,
    bodyTargets,
    progressPhotos,
    syncQueue,
    exerciseProgressionSettings,
    exerciseMuscles,
    exerciseBodyParts,
    exerciseEnrichedContent,
    recentExercises,
    exerciseProgressions,
    exerciseInstructions,
    exerciseMuscleMap,
    mesocycleExercises,
    userProgramProgress,
    exercise1RmSnapshots,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'workouts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sync_queue', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'body_measurements',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sync_queue', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      Value<String?> exerciseId,
      required String name,
      Value<String?> description,
      Value<String> category,
      Value<String> difficulty,
      required String primaryMuscle,
      Value<String?> secondaryMuscle,
      required String equipment,
      required String setType,
      Value<int> restTime,
      Value<String?> instructions,
      Value<String?> gifUrl,
      Value<String?> imageUrl,
      Value<String?> videoUrl,
      Value<String?> mechanic,
      Value<String?> force,
      Value<String> source,
      Value<bool> isCustom,
      Value<bool> isFavorite,
      Value<bool> isEnriched,
      Value<String?> nameHi,
      Value<String?> nameMr,
      Value<DateTime?> lastUsed,
      Value<int> usageCount,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      Value<String?> exerciseId,
      Value<String> name,
      Value<String?> description,
      Value<String> category,
      Value<String> difficulty,
      Value<String> primaryMuscle,
      Value<String?> secondaryMuscle,
      Value<String> equipment,
      Value<String> setType,
      Value<int> restTime,
      Value<String?> instructions,
      Value<String?> gifUrl,
      Value<String?> imageUrl,
      Value<String?> videoUrl,
      Value<String?> mechanic,
      Value<String?> force,
      Value<String> source,
      Value<bool> isCustom,
      Value<bool> isFavorite,
      Value<bool> isEnriched,
      Value<String?> nameHi,
      Value<String?> nameMr,
      Value<DateTime?> lastUsed,
      Value<int> usageCount,
    });

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseTable> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TemplateExercisesTable, List<TemplateExercise>>
  _templateExercisesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.templateExercises,
        aliasName: $_aliasNameGenerator(
          db.exercises.id,
          db.templateExercises.exerciseId,
        ),
      );

  $$TemplateExercisesTableProcessedTableManager get templateExercisesRefs {
    final manager = $$TemplateExercisesTableTableManager(
      $_db,
      $_db.templateExercises,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _templateExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutSetsTable, List<WorkoutSet>>
  _workoutSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutSets,
    aliasName: $_aliasNameGenerator(db.exercises.id, db.workoutSets.exerciseId),
  );

  $$WorkoutSetsTableProcessedTableManager get workoutSetsRefs {
    final manager = $$WorkoutSetsTableTableManager(
      $_db,
      $_db.workoutSets,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutSetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ExerciseProgressionSettingsTable,
    List<ExerciseProgressionSetting>
  >
  _exerciseProgressionSettingsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.exerciseProgressionSettings,
        aliasName: $_aliasNameGenerator(
          db.exercises.id,
          db.exerciseProgressionSettings.exerciseId,
        ),
      );

  $$ExerciseProgressionSettingsTableProcessedTableManager
  get exerciseProgressionSettingsRefs {
    final manager = $$ExerciseProgressionSettingsTableTableManager(
      $_db,
      $_db.exerciseProgressionSettings,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseProgressionSettingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExerciseMusclesTable, List<ExerciseMuscle>>
  _exerciseMusclesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exerciseMuscles,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.exerciseMuscles.exerciseId,
    ),
  );

  $$ExerciseMusclesTableProcessedTableManager get exerciseMusclesRefs {
    final manager = $$ExerciseMusclesTableTableManager(
      $_db,
      $_db.exerciseMuscles,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseMusclesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExerciseBodyPartsTable, List<ExerciseBodyPart>>
  _exerciseBodyPartsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.exerciseBodyParts,
        aliasName: $_aliasNameGenerator(
          db.exercises.id,
          db.exerciseBodyParts.exerciseId,
        ),
      );

  $$ExerciseBodyPartsTableProcessedTableManager get exerciseBodyPartsRefs {
    final manager = $$ExerciseBodyPartsTableTableManager(
      $_db,
      $_db.exerciseBodyParts,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseBodyPartsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ExerciseEnrichedContentTable,
    List<ExerciseEnrichedContentData>
  >
  _exerciseEnrichedContentRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.exerciseEnrichedContent,
        aliasName: $_aliasNameGenerator(
          db.exercises.id,
          db.exerciseEnrichedContent.exerciseId,
        ),
      );

  $$ExerciseEnrichedContentTableProcessedTableManager
  get exerciseEnrichedContentRefs {
    final manager = $$ExerciseEnrichedContentTableTableManager(
      $_db,
      $_db.exerciseEnrichedContent,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseEnrichedContentRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecentExercisesTable, List<RecentExercise>>
  _recentExercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recentExercises,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.recentExercises.exerciseId,
    ),
  );

  $$RecentExercisesTableProcessedTableManager get recentExercisesRefs {
    final manager = $$RecentExercisesTableTableManager(
      $_db,
      $_db.recentExercises,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recentExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ExerciseInstructionsTable,
    List<ExerciseInstruction>
  >
  _exerciseInstructionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.exerciseInstructions,
        aliasName: $_aliasNameGenerator(
          db.exercises.id,
          db.exerciseInstructions.exerciseId,
        ),
      );

  $$ExerciseInstructionsTableProcessedTableManager
  get exerciseInstructionsRefs {
    final manager = $$ExerciseInstructionsTableTableManager(
      $_db,
      $_db.exerciseInstructions,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseInstructionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ExerciseMuscleMapTable,
    List<ExerciseMuscleMapData>
  >
  _exerciseMuscleMapRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.exerciseMuscleMap,
        aliasName: $_aliasNameGenerator(
          db.exercises.id,
          db.exerciseMuscleMap.exerciseId,
        ),
      );

  $$ExerciseMuscleMapTableProcessedTableManager get exerciseMuscleMapRefs {
    final manager = $$ExerciseMuscleMapTableTableManager(
      $_db,
      $_db.exerciseMuscleMap,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseMuscleMapRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MesocycleExercisesTable, List<MesocycleExercise>>
  _mesocycleExercisesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.mesocycleExercises,
        aliasName: $_aliasNameGenerator(
          db.exercises.id,
          db.mesocycleExercises.exerciseId,
        ),
      );

  $$MesocycleExercisesTableProcessedTableManager get mesocycleExercisesRefs {
    final manager = $$MesocycleExercisesTableTableManager(
      $_db,
      $_db.mesocycleExercises,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mesocycleExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $Exercise1RmSnapshotsTable,
    List<Exercise1RmSnapshot>
  >
  _exercise1RmSnapshotsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.exercise1RmSnapshots,
        aliasName: $_aliasNameGenerator(
          db.exercises.id,
          db.exercise1RmSnapshots.exerciseId,
        ),
      );

  $$Exercise1RmSnapshotsTableProcessedTableManager
  get exercise1RmSnapshotsRefs {
    final manager = $$Exercise1RmSnapshotsTableTableManager(
      $_db,
      $_db.exercise1RmSnapshots,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exercise1RmSnapshotsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryMuscle => $composableBuilder(
    column: $table.primaryMuscle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryMuscle => $composableBuilder(
    column: $table.secondaryMuscle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get setType => $composableBuilder(
    column: $table.setType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restTime => $composableBuilder(
    column: $table.restTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gifUrl => $composableBuilder(
    column: $table.gifUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get videoUrl => $composableBuilder(
    column: $table.videoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mechanic => $composableBuilder(
    column: $table.mechanic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get force => $composableBuilder(
    column: $table.force,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnriched => $composableBuilder(
    column: $table.isEnriched,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameHi => $composableBuilder(
    column: $table.nameHi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameMr => $composableBuilder(
    column: $table.nameMr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> templateExercisesRefs(
    Expression<bool> Function($$TemplateExercisesTableFilterComposer f) f,
  ) {
    final $$TemplateExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateExercises,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateExercisesTableFilterComposer(
            $db: $db,
            $table: $db.templateExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutSetsRefs(
    Expression<bool> Function($$WorkoutSetsTableFilterComposer f) f,
  ) {
    final $$WorkoutSetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSets,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSetsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> exerciseProgressionSettingsRefs(
    Expression<bool> Function(
      $$ExerciseProgressionSettingsTableFilterComposer f,
    )
    f,
  ) {
    final $$ExerciseProgressionSettingsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exerciseProgressionSettings,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseProgressionSettingsTableFilterComposer(
                $db: $db,
                $table: $db.exerciseProgressionSettings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> exerciseMusclesRefs(
    Expression<bool> Function($$ExerciseMusclesTableFilterComposer f) f,
  ) {
    final $$ExerciseMusclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseMuscles,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseMusclesTableFilterComposer(
            $db: $db,
            $table: $db.exerciseMuscles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> exerciseBodyPartsRefs(
    Expression<bool> Function($$ExerciseBodyPartsTableFilterComposer f) f,
  ) {
    final $$ExerciseBodyPartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseBodyParts,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseBodyPartsTableFilterComposer(
            $db: $db,
            $table: $db.exerciseBodyParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> exerciseEnrichedContentRefs(
    Expression<bool> Function($$ExerciseEnrichedContentTableFilterComposer f) f,
  ) {
    final $$ExerciseEnrichedContentTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exerciseEnrichedContent,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseEnrichedContentTableFilterComposer(
                $db: $db,
                $table: $db.exerciseEnrichedContent,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> recentExercisesRefs(
    Expression<bool> Function($$RecentExercisesTableFilterComposer f) f,
  ) {
    final $$RecentExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recentExercises,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecentExercisesTableFilterComposer(
            $db: $db,
            $table: $db.recentExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> exerciseInstructionsRefs(
    Expression<bool> Function($$ExerciseInstructionsTableFilterComposer f) f,
  ) {
    final $$ExerciseInstructionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseInstructions,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseInstructionsTableFilterComposer(
            $db: $db,
            $table: $db.exerciseInstructions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> exerciseMuscleMapRefs(
    Expression<bool> Function($$ExerciseMuscleMapTableFilterComposer f) f,
  ) {
    final $$ExerciseMuscleMapTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseMuscleMap,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseMuscleMapTableFilterComposer(
            $db: $db,
            $table: $db.exerciseMuscleMap,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mesocycleExercisesRefs(
    Expression<bool> Function($$MesocycleExercisesTableFilterComposer f) f,
  ) {
    final $$MesocycleExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mesocycleExercises,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleExercisesTableFilterComposer(
            $db: $db,
            $table: $db.mesocycleExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> exercise1RmSnapshotsRefs(
    Expression<bool> Function($$Exercise1RmSnapshotsTableFilterComposer f) f,
  ) {
    final $$Exercise1RmSnapshotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercise1RmSnapshots,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$Exercise1RmSnapshotsTableFilterComposer(
            $db: $db,
            $table: $db.exercise1RmSnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryMuscle => $composableBuilder(
    column: $table.primaryMuscle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryMuscle => $composableBuilder(
    column: $table.secondaryMuscle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setType => $composableBuilder(
    column: $table.setType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restTime => $composableBuilder(
    column: $table.restTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gifUrl => $composableBuilder(
    column: $table.gifUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get videoUrl => $composableBuilder(
    column: $table.videoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mechanic => $composableBuilder(
    column: $table.mechanic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get force => $composableBuilder(
    column: $table.force,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnriched => $composableBuilder(
    column: $table.isEnriched,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameHi => $composableBuilder(
    column: $table.nameHi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameMr => $composableBuilder(
    column: $table.nameMr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryMuscle => $composableBuilder(
    column: $table.primaryMuscle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryMuscle => $composableBuilder(
    column: $table.secondaryMuscle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);

  GeneratedColumn<String> get setType =>
      $composableBuilder(column: $table.setType, builder: (column) => column);

  GeneratedColumn<int> get restTime =>
      $composableBuilder(column: $table.restTime, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gifUrl =>
      $composableBuilder(column: $table.gifUrl, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get videoUrl =>
      $composableBuilder(column: $table.videoUrl, builder: (column) => column);

  GeneratedColumn<String> get mechanic =>
      $composableBuilder(column: $table.mechanic, builder: (column) => column);

  GeneratedColumn<String> get force =>
      $composableBuilder(column: $table.force, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnriched => $composableBuilder(
    column: $table.isEnriched,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameHi =>
      $composableBuilder(column: $table.nameHi, builder: (column) => column);

  GeneratedColumn<String> get nameMr =>
      $composableBuilder(column: $table.nameMr, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsed =>
      $composableBuilder(column: $table.lastUsed, builder: (column) => column);

  GeneratedColumn<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => column,
  );

  Expression<T> templateExercisesRefs<T extends Object>(
    Expression<T> Function($$TemplateExercisesTableAnnotationComposer a) f,
  ) {
    final $$TemplateExercisesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.templateExercises,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TemplateExercisesTableAnnotationComposer(
                $db: $db,
                $table: $db.templateExercises,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> workoutSetsRefs<T extends Object>(
    Expression<T> Function($$WorkoutSetsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutSetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSets,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSetsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> exerciseProgressionSettingsRefs<T extends Object>(
    Expression<T> Function(
      $$ExerciseProgressionSettingsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$ExerciseProgressionSettingsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exerciseProgressionSettings,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseProgressionSettingsTableAnnotationComposer(
                $db: $db,
                $table: $db.exerciseProgressionSettings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> exerciseMusclesRefs<T extends Object>(
    Expression<T> Function($$ExerciseMusclesTableAnnotationComposer a) f,
  ) {
    final $$ExerciseMusclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseMuscles,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseMusclesTableAnnotationComposer(
            $db: $db,
            $table: $db.exerciseMuscles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> exerciseBodyPartsRefs<T extends Object>(
    Expression<T> Function($$ExerciseBodyPartsTableAnnotationComposer a) f,
  ) {
    final $$ExerciseBodyPartsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exerciseBodyParts,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseBodyPartsTableAnnotationComposer(
                $db: $db,
                $table: $db.exerciseBodyParts,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> exerciseEnrichedContentRefs<T extends Object>(
    Expression<T> Function($$ExerciseEnrichedContentTableAnnotationComposer a)
    f,
  ) {
    final $$ExerciseEnrichedContentTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exerciseEnrichedContent,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseEnrichedContentTableAnnotationComposer(
                $db: $db,
                $table: $db.exerciseEnrichedContent,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> recentExercisesRefs<T extends Object>(
    Expression<T> Function($$RecentExercisesTableAnnotationComposer a) f,
  ) {
    final $$RecentExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recentExercises,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecentExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.recentExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> exerciseInstructionsRefs<T extends Object>(
    Expression<T> Function($$ExerciseInstructionsTableAnnotationComposer a) f,
  ) {
    final $$ExerciseInstructionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exerciseInstructions,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseInstructionsTableAnnotationComposer(
                $db: $db,
                $table: $db.exerciseInstructions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> exerciseMuscleMapRefs<T extends Object>(
    Expression<T> Function($$ExerciseMuscleMapTableAnnotationComposer a) f,
  ) {
    final $$ExerciseMuscleMapTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exerciseMuscleMap,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseMuscleMapTableAnnotationComposer(
                $db: $db,
                $table: $db.exerciseMuscleMap,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> mesocycleExercisesRefs<T extends Object>(
    Expression<T> Function($$MesocycleExercisesTableAnnotationComposer a) f,
  ) {
    final $$MesocycleExercisesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.mesocycleExercises,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MesocycleExercisesTableAnnotationComposer(
                $db: $db,
                $table: $db.mesocycleExercises,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> exercise1RmSnapshotsRefs<T extends Object>(
    Expression<T> Function($$Exercise1RmSnapshotsTableAnnotationComposer a) f,
  ) {
    final $$Exercise1RmSnapshotsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exercise1RmSnapshots,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$Exercise1RmSnapshotsTableAnnotationComposer(
                $db: $db,
                $table: $db.exercise1RmSnapshots,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          ExerciseTable,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (ExerciseTable, $$ExercisesTableReferences),
          ExerciseTable,
          PrefetchHooks Function({
            bool templateExercisesRefs,
            bool workoutSetsRefs,
            bool exerciseProgressionSettingsRefs,
            bool exerciseMusclesRefs,
            bool exerciseBodyPartsRefs,
            bool exerciseEnrichedContentRefs,
            bool recentExercisesRefs,
            bool exerciseInstructionsRefs,
            bool exerciseMuscleMapRefs,
            bool mesocycleExercisesRefs,
            bool exercise1RmSnapshotsRefs,
          })
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> exerciseId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> primaryMuscle = const Value.absent(),
                Value<String?> secondaryMuscle = const Value.absent(),
                Value<String> equipment = const Value.absent(),
                Value<String> setType = const Value.absent(),
                Value<int> restTime = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<String?> gifUrl = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> videoUrl = const Value.absent(),
                Value<String?> mechanic = const Value.absent(),
                Value<String?> force = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isEnriched = const Value.absent(),
                Value<String?> nameHi = const Value.absent(),
                Value<String?> nameMr = const Value.absent(),
                Value<DateTime?> lastUsed = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                exerciseId: exerciseId,
                name: name,
                description: description,
                category: category,
                difficulty: difficulty,
                primaryMuscle: primaryMuscle,
                secondaryMuscle: secondaryMuscle,
                equipment: equipment,
                setType: setType,
                restTime: restTime,
                instructions: instructions,
                gifUrl: gifUrl,
                imageUrl: imageUrl,
                videoUrl: videoUrl,
                mechanic: mechanic,
                force: force,
                source: source,
                isCustom: isCustom,
                isFavorite: isFavorite,
                isEnriched: isEnriched,
                nameHi: nameHi,
                nameMr: nameMr,
                lastUsed: lastUsed,
                usageCount: usageCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> exerciseId = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                required String primaryMuscle,
                Value<String?> secondaryMuscle = const Value.absent(),
                required String equipment,
                required String setType,
                Value<int> restTime = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<String?> gifUrl = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> videoUrl = const Value.absent(),
                Value<String?> mechanic = const Value.absent(),
                Value<String?> force = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isEnriched = const Value.absent(),
                Value<String?> nameHi = const Value.absent(),
                Value<String?> nameMr = const Value.absent(),
                Value<DateTime?> lastUsed = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                name: name,
                description: description,
                category: category,
                difficulty: difficulty,
                primaryMuscle: primaryMuscle,
                secondaryMuscle: secondaryMuscle,
                equipment: equipment,
                setType: setType,
                restTime: restTime,
                instructions: instructions,
                gifUrl: gifUrl,
                imageUrl: imageUrl,
                videoUrl: videoUrl,
                mechanic: mechanic,
                force: force,
                source: source,
                isCustom: isCustom,
                isFavorite: isFavorite,
                isEnriched: isEnriched,
                nameHi: nameHi,
                nameMr: nameMr,
                lastUsed: lastUsed,
                usageCount: usageCount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                templateExercisesRefs = false,
                workoutSetsRefs = false,
                exerciseProgressionSettingsRefs = false,
                exerciseMusclesRefs = false,
                exerciseBodyPartsRefs = false,
                exerciseEnrichedContentRefs = false,
                recentExercisesRefs = false,
                exerciseInstructionsRefs = false,
                exerciseMuscleMapRefs = false,
                mesocycleExercisesRefs = false,
                exercise1RmSnapshotsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (templateExercisesRefs) db.templateExercises,
                    if (workoutSetsRefs) db.workoutSets,
                    if (exerciseProgressionSettingsRefs)
                      db.exerciseProgressionSettings,
                    if (exerciseMusclesRefs) db.exerciseMuscles,
                    if (exerciseBodyPartsRefs) db.exerciseBodyParts,
                    if (exerciseEnrichedContentRefs) db.exerciseEnrichedContent,
                    if (recentExercisesRefs) db.recentExercises,
                    if (exerciseInstructionsRefs) db.exerciseInstructions,
                    if (exerciseMuscleMapRefs) db.exerciseMuscleMap,
                    if (mesocycleExercisesRefs) db.mesocycleExercises,
                    if (exercise1RmSnapshotsRefs) db.exercise1RmSnapshots,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (templateExercisesRefs)
                        await $_getPrefetchedData<
                          ExerciseTable,
                          $ExercisesTable,
                          TemplateExercise
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._templateExercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).templateExercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutSetsRefs)
                        await $_getPrefetchedData<
                          ExerciseTable,
                          $ExercisesTable,
                          WorkoutSet
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._workoutSetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutSetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (exerciseProgressionSettingsRefs)
                        await $_getPrefetchedData<
                          ExerciseTable,
                          $ExercisesTable,
                          ExerciseProgressionSetting
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._exerciseProgressionSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseProgressionSettingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (exerciseMusclesRefs)
                        await $_getPrefetchedData<
                          ExerciseTable,
                          $ExercisesTable,
                          ExerciseMuscle
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._exerciseMusclesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseMusclesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (exerciseBodyPartsRefs)
                        await $_getPrefetchedData<
                          ExerciseTable,
                          $ExercisesTable,
                          ExerciseBodyPart
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._exerciseBodyPartsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseBodyPartsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (exerciseEnrichedContentRefs)
                        await $_getPrefetchedData<
                          ExerciseTable,
                          $ExercisesTable,
                          ExerciseEnrichedContentData
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._exerciseEnrichedContentRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseEnrichedContentRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recentExercisesRefs)
                        await $_getPrefetchedData<
                          ExerciseTable,
                          $ExercisesTable,
                          RecentExercise
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._recentExercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).recentExercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (exerciseInstructionsRefs)
                        await $_getPrefetchedData<
                          ExerciseTable,
                          $ExercisesTable,
                          ExerciseInstruction
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._exerciseInstructionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseInstructionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (exerciseMuscleMapRefs)
                        await $_getPrefetchedData<
                          ExerciseTable,
                          $ExercisesTable,
                          ExerciseMuscleMapData
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._exerciseMuscleMapRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseMuscleMapRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mesocycleExercisesRefs)
                        await $_getPrefetchedData<
                          ExerciseTable,
                          $ExercisesTable,
                          MesocycleExercise
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._mesocycleExercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).mesocycleExercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (exercise1RmSnapshotsRefs)
                        await $_getPrefetchedData<
                          ExerciseTable,
                          $ExercisesTable,
                          Exercise1RmSnapshot
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._exercise1RmSnapshotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).exercise1RmSnapshotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      ExerciseTable,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (ExerciseTable, $$ExercisesTableReferences),
      ExerciseTable,
      PrefetchHooks Function({
        bool templateExercisesRefs,
        bool workoutSetsRefs,
        bool exerciseProgressionSettingsRefs,
        bool exerciseMusclesRefs,
        bool exerciseBodyPartsRefs,
        bool exerciseEnrichedContentRefs,
        bool recentExercisesRefs,
        bool exerciseInstructionsRefs,
        bool exerciseMuscleMapRefs,
        bool mesocycleExercisesRefs,
        bool exercise1RmSnapshotsRefs,
      })
    >;
typedef $$WorkoutTemplatesTableCreateCompanionBuilder =
    WorkoutTemplatesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String?> goal,
      Value<String?> duration,
      Value<DateTime?> lastUsed,
      Value<bool> isSelected,
    });
typedef $$WorkoutTemplatesTableUpdateCompanionBuilder =
    WorkoutTemplatesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> goal,
      Value<String?> duration,
      Value<DateTime?> lastUsed,
      Value<bool> isSelected,
    });

final class $$WorkoutTemplatesTableReferences
    extends
        BaseReferences<_$AppDatabase, $WorkoutTemplatesTable, WorkoutTemplate> {
  $$WorkoutTemplatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TemplateDaysTable, List<TemplateDay>>
  _templateDaysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.templateDays,
    aliasName: $_aliasNameGenerator(
      db.workoutTemplates.id,
      db.templateDays.templateId,
    ),
  );

  $$TemplateDaysTableProcessedTableManager get templateDaysRefs {
    final manager = $$TemplateDaysTableTableManager(
      $_db,
      $_db.templateDays,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_templateDaysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutsTable, List<Workout>> _workoutsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.workouts,
    aliasName: $_aliasNameGenerator(
      db.workoutTemplates.id,
      db.workouts.templateId,
    ),
  );

  $$WorkoutsTableProcessedTableManager get workoutsRefs {
    final manager = $$WorkoutsTableTableManager(
      $_db,
      $_db.workouts,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> templateDaysRefs(
    Expression<bool> Function($$TemplateDaysTableFilterComposer f) f,
  ) {
    final $$TemplateDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateDays,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateDaysTableFilterComposer(
            $db: $db,
            $table: $db.templateDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutsRefs(
    Expression<bool> Function($$WorkoutsTableFilterComposer f) f,
  ) {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableFilterComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<String> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsed =>
      $composableBuilder(column: $table.lastUsed, builder: (column) => column);

  GeneratedColumn<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => column,
  );

  Expression<T> templateDaysRefs<T extends Object>(
    Expression<T> Function($$TemplateDaysTableAnnotationComposer a) f,
  ) {
    final $$TemplateDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateDays,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.templateDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workoutsRefs<T extends Object>(
    Expression<T> Function($$WorkoutsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableAnnotationComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutTemplatesTableTableManager
    extends
        RootTableManager<
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
          PrefetchHooks Function({bool templateDaysRefs, bool workoutsRefs})
        > {
  $$WorkoutTemplatesTableTableManager(
    _$AppDatabase db,
    $WorkoutTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> goal = const Value.absent(),
                Value<String?> duration = const Value.absent(),
                Value<DateTime?> lastUsed = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
              }) => WorkoutTemplatesCompanion(
                id: id,
                name: name,
                description: description,
                goal: goal,
                duration: duration,
                lastUsed: lastUsed,
                isSelected: isSelected,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> goal = const Value.absent(),
                Value<String?> duration = const Value.absent(),
                Value<DateTime?> lastUsed = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
              }) => WorkoutTemplatesCompanion.insert(
                id: id,
                name: name,
                description: description,
                goal: goal,
                duration: duration,
                lastUsed: lastUsed,
                isSelected: isSelected,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutTemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({templateDaysRefs = false, workoutsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (templateDaysRefs) db.templateDays,
                    if (workoutsRefs) db.workouts,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (templateDaysRefs)
                        await $_getPrefetchedData<
                          WorkoutTemplate,
                          $WorkoutTemplatesTable,
                          TemplateDay
                        >(
                          currentTable: table,
                          referencedTable: $$WorkoutTemplatesTableReferences
                              ._templateDaysRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).templateDaysRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.templateId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutsRefs)
                        await $_getPrefetchedData<
                          WorkoutTemplate,
                          $WorkoutTemplatesTable,
                          Workout
                        >(
                          currentTable: table,
                          referencedTable: $$WorkoutTemplatesTableReferences
                              ._workoutsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.templateId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WorkoutTemplatesTableProcessedTableManager =
    ProcessedTableManager<
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
      PrefetchHooks Function({bool templateDaysRefs, bool workoutsRefs})
    >;
typedef $$TemplateDaysTableCreateCompanionBuilder =
    TemplateDaysCompanion Function({
      Value<int> id,
      required int templateId,
      required String name,
      required int order,
      Value<int?> weekday,
    });
typedef $$TemplateDaysTableUpdateCompanionBuilder =
    TemplateDaysCompanion Function({
      Value<int> id,
      Value<int> templateId,
      Value<String> name,
      Value<int> order,
      Value<int?> weekday,
    });

final class $$TemplateDaysTableReferences
    extends BaseReferences<_$AppDatabase, $TemplateDaysTable, TemplateDay> {
  $$TemplateDaysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutTemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.workoutTemplates.createAlias(
        $_aliasNameGenerator(
          db.templateDays.templateId,
          db.workoutTemplates.id,
        ),
      );

  $$WorkoutTemplatesTableProcessedTableManager get templateId {
    final $_column = $_itemColumn<int>('template_id')!;

    final manager = $$WorkoutTemplatesTableTableManager(
      $_db,
      $_db.workoutTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TemplateExercisesTable, List<TemplateExercise>>
  _templateExercisesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.templateExercises,
        aliasName: $_aliasNameGenerator(
          db.templateDays.id,
          db.templateExercises.dayId,
        ),
      );

  $$TemplateExercisesTableProcessedTableManager get templateExercisesRefs {
    final manager = $$TemplateExercisesTableTableManager(
      $_db,
      $_db.templateExercises,
    ).filter((f) => f.dayId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _templateExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutsTable, List<Workout>> _workoutsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.workouts,
    aliasName: $_aliasNameGenerator(db.templateDays.id, db.workouts.dayId),
  );

  $$WorkoutsTableProcessedTableManager get workoutsRefs {
    final manager = $$WorkoutsTableTableManager(
      $_db,
      $_db.workouts,
    ).filter((f) => f.dayId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutTemplatesTableFilterComposer get templateId {
    final $$WorkoutTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.workoutTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.workoutTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> templateExercisesRefs(
    Expression<bool> Function($$TemplateExercisesTableFilterComposer f) f,
  ) {
    final $$TemplateExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateExercises,
      getReferencedColumn: (t) => t.dayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateExercisesTableFilterComposer(
            $db: $db,
            $table: $db.templateExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutsRefs(
    Expression<bool> Function($$WorkoutsTableFilterComposer f) f,
  ) {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.dayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableFilterComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutTemplatesTableOrderingComposer get templateId {
    final $$WorkoutTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.workoutTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.workoutTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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

  GeneratedColumn<int> get weekday =>
      $composableBuilder(column: $table.weekday, builder: (column) => column);

  $$WorkoutTemplatesTableAnnotationComposer get templateId {
    final $$WorkoutTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.workoutTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> templateExercisesRefs<T extends Object>(
    Expression<T> Function($$TemplateExercisesTableAnnotationComposer a) f,
  ) {
    final $$TemplateExercisesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.templateExercises,
          getReferencedColumn: (t) => t.dayId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TemplateExercisesTableAnnotationComposer(
                $db: $db,
                $table: $db.templateExercises,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> workoutsRefs<T extends Object>(
    Expression<T> Function($$WorkoutsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.dayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableAnnotationComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TemplateDaysTableTableManager
    extends
        RootTableManager<
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
          PrefetchHooks Function({
            bool templateId,
            bool templateExercisesRefs,
            bool workoutsRefs,
          })
        > {
  $$TemplateDaysTableTableManager(_$AppDatabase db, $TemplateDaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplateDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplateDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplateDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> templateId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<int?> weekday = const Value.absent(),
              }) => TemplateDaysCompanion(
                id: id,
                templateId: templateId,
                name: name,
                order: order,
                weekday: weekday,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int templateId,
                required String name,
                required int order,
                Value<int?> weekday = const Value.absent(),
              }) => TemplateDaysCompanion.insert(
                id: id,
                templateId: templateId,
                name: name,
                order: order,
                weekday: weekday,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TemplateDaysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                templateId = false,
                templateExercisesRefs = false,
                workoutsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (templateExercisesRefs) db.templateExercises,
                    if (workoutsRefs) db.workouts,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (templateId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.templateId,
                                    referencedTable:
                                        $$TemplateDaysTableReferences
                                            ._templateIdTable(db),
                                    referencedColumn:
                                        $$TemplateDaysTableReferences
                                            ._templateIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (templateExercisesRefs)
                        await $_getPrefetchedData<
                          TemplateDay,
                          $TemplateDaysTable,
                          TemplateExercise
                        >(
                          currentTable: table,
                          referencedTable: $$TemplateDaysTableReferences
                              ._templateExercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TemplateDaysTableReferences(
                                db,
                                table,
                                p0,
                              ).templateExercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dayId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutsRefs)
                        await $_getPrefetchedData<
                          TemplateDay,
                          $TemplateDaysTable,
                          Workout
                        >(
                          currentTable: table,
                          referencedTable: $$TemplateDaysTableReferences
                              ._workoutsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TemplateDaysTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dayId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TemplateDaysTableProcessedTableManager =
    ProcessedTableManager<
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
      PrefetchHooks Function({
        bool templateId,
        bool templateExercisesRefs,
        bool workoutsRefs,
      })
    >;
typedef $$TemplateExercisesTableCreateCompanionBuilder =
    TemplateExercisesCompanion Function({
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
typedef $$TemplateExercisesTableUpdateCompanionBuilder =
    TemplateExercisesCompanion Function({
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

final class $$TemplateExercisesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TemplateExercisesTable,
          TemplateExercise
        > {
  $$TemplateExercisesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TemplateDaysTable _dayIdTable(_$AppDatabase db) =>
      db.templateDays.createAlias(
        $_aliasNameGenerator(db.templateExercises.dayId, db.templateDays.id),
      );

  $$TemplateDaysTableProcessedTableManager get dayId {
    final $_column = $_itemColumn<int>('day_id')!;

    final manager = $$TemplateDaysTableTableManager(
      $_db,
      $_db.templateDays,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.templateExercises.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SetType, SetType, int> get setType =>
      $composableBuilder(
        column: $table.setType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get setsJson => $composableBuilder(
    column: $table.setsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restTime => $composableBuilder(
    column: $table.restTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supersetGroupId => $composableBuilder(
    column: $table.supersetGroupId,
    builder: (column) => ColumnFilters(column),
  );

  $$TemplateDaysTableFilterComposer get dayId {
    final $$TemplateDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dayId,
      referencedTable: $db.templateDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateDaysTableFilterComposer(
            $db: $db,
            $table: $db.templateDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setType => $composableBuilder(
    column: $table.setType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setsJson => $composableBuilder(
    column: $table.setsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restTime => $composableBuilder(
    column: $table.restTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supersetGroupId => $composableBuilder(
    column: $table.supersetGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  $$TemplateDaysTableOrderingComposer get dayId {
    final $$TemplateDaysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dayId,
      referencedTable: $db.templateDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateDaysTableOrderingComposer(
            $db: $db,
            $table: $db.templateDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.supersetGroupId,
    builder: (column) => column,
  );

  $$TemplateDaysTableAnnotationComposer get dayId {
    final $$TemplateDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dayId,
      referencedTable: $db.templateDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.templateDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplateExercisesTableTableManager
    extends
        RootTableManager<
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
          PrefetchHooks Function({bool dayId, bool exerciseId})
        > {
  $$TemplateExercisesTableTableManager(
    _$AppDatabase db,
    $TemplateExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplateExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplateExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplateExercisesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dayId = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<SetType> setType = const Value.absent(),
                Value<String> setsJson = const Value.absent(),
                Value<int> restTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> supersetGroupId = const Value.absent(),
              }) => TemplateExercisesCompanion(
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
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int dayId,
                required int exerciseId,
                required int order,
                Value<SetType> setType = const Value.absent(),
                required String setsJson,
                Value<int> restTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> supersetGroupId = const Value.absent(),
              }) => TemplateExercisesCompanion.insert(
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
              .map(
                (e) => (
                  e.readTable(table),
                  $$TemplateExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dayId = false, exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (dayId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dayId,
                                referencedTable:
                                    $$TemplateExercisesTableReferences
                                        ._dayIdTable(db),
                                referencedColumn:
                                    $$TemplateExercisesTableReferences
                                        ._dayIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$TemplateExercisesTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$TemplateExercisesTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TemplateExercisesTableProcessedTableManager =
    ProcessedTableManager<
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
      PrefetchHooks Function({bool dayId, bool exerciseId})
    >;
typedef $$MesocyclesTableCreateCompanionBuilder =
    MesocyclesCompanion Function({
      Value<int> id,
      required String name,
      required String goal,
      required String splitType,
      required String experienceLevel,
      required int weeksCount,
      required int daysPerWeek,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String?> notes,
      Value<bool> isArchived,
    });
typedef $$MesocyclesTableUpdateCompanionBuilder =
    MesocyclesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> goal,
      Value<String> splitType,
      Value<String> experienceLevel,
      Value<int> weeksCount,
      Value<int> daysPerWeek,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> notes,
      Value<bool> isArchived,
    });

final class $$MesocyclesTableReferences
    extends BaseReferences<_$AppDatabase, $MesocyclesTable, Mesocycle> {
  $$MesocyclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MesocycleWeeksTable, List<MesocycleWeek>>
  _mesocycleWeeksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mesocycleWeeks,
    aliasName: $_aliasNameGenerator(
      db.mesocycles.id,
      db.mesocycleWeeks.mesocycleId,
    ),
  );

  $$MesocycleWeeksTableProcessedTableManager get mesocycleWeeksRefs {
    final manager = $$MesocycleWeeksTableTableManager(
      $_db,
      $_db.mesocycleWeeks,
    ).filter((f) => f.mesocycleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mesocycleWeeksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutsTable, List<Workout>> _workoutsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.workouts,
    aliasName: $_aliasNameGenerator(db.mesocycles.id, db.workouts.mesocycleId),
  );

  $$WorkoutsTableProcessedTableManager get workoutsRefs {
    final manager = $$WorkoutsTableTableManager(
      $_db,
      $_db.workouts,
    ).filter((f) => f.mesocycleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $UserProgramProgressTable,
    List<UserProgramProgressData>
  >
  _userProgramProgressRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.userProgramProgress,
        aliasName: $_aliasNameGenerator(
          db.mesocycles.id,
          db.userProgramProgress.mesocycleId,
        ),
      );

  $$UserProgramProgressTableProcessedTableManager get userProgramProgressRefs {
    final manager = $$UserProgramProgressTableTableManager(
      $_db,
      $_db.userProgramProgress,
    ).filter((f) => f.mesocycleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userProgramProgressRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MesocyclesTableFilterComposer
    extends Composer<_$AppDatabase, $MesocyclesTable> {
  $$MesocyclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get splitType => $composableBuilder(
    column: $table.splitType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get experienceLevel => $composableBuilder(
    column: $table.experienceLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeksCount => $composableBuilder(
    column: $table.weeksCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get daysPerWeek => $composableBuilder(
    column: $table.daysPerWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mesocycleWeeksRefs(
    Expression<bool> Function($$MesocycleWeeksTableFilterComposer f) f,
  ) {
    final $$MesocycleWeeksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mesocycleWeeks,
      getReferencedColumn: (t) => t.mesocycleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleWeeksTableFilterComposer(
            $db: $db,
            $table: $db.mesocycleWeeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutsRefs(
    Expression<bool> Function($$WorkoutsTableFilterComposer f) f,
  ) {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.mesocycleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableFilterComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userProgramProgressRefs(
    Expression<bool> Function($$UserProgramProgressTableFilterComposer f) f,
  ) {
    final $$UserProgramProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userProgramProgress,
      getReferencedColumn: (t) => t.mesocycleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProgramProgressTableFilterComposer(
            $db: $db,
            $table: $db.userProgramProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MesocyclesTableOrderingComposer
    extends Composer<_$AppDatabase, $MesocyclesTable> {
  $$MesocyclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get splitType => $composableBuilder(
    column: $table.splitType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get experienceLevel => $composableBuilder(
    column: $table.experienceLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeksCount => $composableBuilder(
    column: $table.weeksCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get daysPerWeek => $composableBuilder(
    column: $table.daysPerWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MesocyclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MesocyclesTable> {
  $$MesocyclesTableAnnotationComposer({
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

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<String> get splitType =>
      $composableBuilder(column: $table.splitType, builder: (column) => column);

  GeneratedColumn<String> get experienceLevel => $composableBuilder(
    column: $table.experienceLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weeksCount => $composableBuilder(
    column: $table.weeksCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get daysPerWeek => $composableBuilder(
    column: $table.daysPerWeek,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  Expression<T> mesocycleWeeksRefs<T extends Object>(
    Expression<T> Function($$MesocycleWeeksTableAnnotationComposer a) f,
  ) {
    final $$MesocycleWeeksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mesocycleWeeks,
      getReferencedColumn: (t) => t.mesocycleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleWeeksTableAnnotationComposer(
            $db: $db,
            $table: $db.mesocycleWeeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workoutsRefs<T extends Object>(
    Expression<T> Function($$WorkoutsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.mesocycleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableAnnotationComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userProgramProgressRefs<T extends Object>(
    Expression<T> Function($$UserProgramProgressTableAnnotationComposer a) f,
  ) {
    final $$UserProgramProgressTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userProgramProgress,
          getReferencedColumn: (t) => t.mesocycleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserProgramProgressTableAnnotationComposer(
                $db: $db,
                $table: $db.userProgramProgress,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MesocyclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MesocyclesTable,
          Mesocycle,
          $$MesocyclesTableFilterComposer,
          $$MesocyclesTableOrderingComposer,
          $$MesocyclesTableAnnotationComposer,
          $$MesocyclesTableCreateCompanionBuilder,
          $$MesocyclesTableUpdateCompanionBuilder,
          (Mesocycle, $$MesocyclesTableReferences),
          Mesocycle,
          PrefetchHooks Function({
            bool mesocycleWeeksRefs,
            bool workoutsRefs,
            bool userProgramProgressRefs,
          })
        > {
  $$MesocyclesTableTableManager(_$AppDatabase db, $MesocyclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MesocyclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MesocyclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MesocyclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> goal = const Value.absent(),
                Value<String> splitType = const Value.absent(),
                Value<String> experienceLevel = const Value.absent(),
                Value<int> weeksCount = const Value.absent(),
                Value<int> daysPerWeek = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => MesocyclesCompanion(
                id: id,
                name: name,
                goal: goal,
                splitType: splitType,
                experienceLevel: experienceLevel,
                weeksCount: weeksCount,
                daysPerWeek: daysPerWeek,
                createdAt: createdAt,
                updatedAt: updatedAt,
                notes: notes,
                isArchived: isArchived,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String goal,
                required String splitType,
                required String experienceLevel,
                required int weeksCount,
                required int daysPerWeek,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => MesocyclesCompanion.insert(
                id: id,
                name: name,
                goal: goal,
                splitType: splitType,
                experienceLevel: experienceLevel,
                weeksCount: weeksCount,
                daysPerWeek: daysPerWeek,
                createdAt: createdAt,
                updatedAt: updatedAt,
                notes: notes,
                isArchived: isArchived,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MesocyclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                mesocycleWeeksRefs = false,
                workoutsRefs = false,
                userProgramProgressRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mesocycleWeeksRefs) db.mesocycleWeeks,
                    if (workoutsRefs) db.workouts,
                    if (userProgramProgressRefs) db.userProgramProgress,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mesocycleWeeksRefs)
                        await $_getPrefetchedData<
                          Mesocycle,
                          $MesocyclesTable,
                          MesocycleWeek
                        >(
                          currentTable: table,
                          referencedTable: $$MesocyclesTableReferences
                              ._mesocycleWeeksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MesocyclesTableReferences(
                                db,
                                table,
                                p0,
                              ).mesocycleWeeksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mesocycleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutsRefs)
                        await $_getPrefetchedData<
                          Mesocycle,
                          $MesocyclesTable,
                          Workout
                        >(
                          currentTable: table,
                          referencedTable: $$MesocyclesTableReferences
                              ._workoutsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MesocyclesTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mesocycleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userProgramProgressRefs)
                        await $_getPrefetchedData<
                          Mesocycle,
                          $MesocyclesTable,
                          UserProgramProgressData
                        >(
                          currentTable: table,
                          referencedTable: $$MesocyclesTableReferences
                              ._userProgramProgressRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MesocyclesTableReferences(
                                db,
                                table,
                                p0,
                              ).userProgramProgressRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mesocycleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MesocyclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MesocyclesTable,
      Mesocycle,
      $$MesocyclesTableFilterComposer,
      $$MesocyclesTableOrderingComposer,
      $$MesocyclesTableAnnotationComposer,
      $$MesocyclesTableCreateCompanionBuilder,
      $$MesocyclesTableUpdateCompanionBuilder,
      (Mesocycle, $$MesocyclesTableReferences),
      Mesocycle,
      PrefetchHooks Function({
        bool mesocycleWeeksRefs,
        bool workoutsRefs,
        bool userProgramProgressRefs,
      })
    >;
typedef $$MesocycleWeeksTableCreateCompanionBuilder =
    MesocycleWeeksCompanion Function({
      Value<int> id,
      required int mesocycleId,
      required int weekNumber,
      required String phaseName,
      Value<double> volumeMultiplier,
      Value<double> intensityMultiplier,
      Value<String?> notes,
    });
typedef $$MesocycleWeeksTableUpdateCompanionBuilder =
    MesocycleWeeksCompanion Function({
      Value<int> id,
      Value<int> mesocycleId,
      Value<int> weekNumber,
      Value<String> phaseName,
      Value<double> volumeMultiplier,
      Value<double> intensityMultiplier,
      Value<String?> notes,
    });

final class $$MesocycleWeeksTableReferences
    extends BaseReferences<_$AppDatabase, $MesocycleWeeksTable, MesocycleWeek> {
  $$MesocycleWeeksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MesocyclesTable _mesocycleIdTable(_$AppDatabase db) =>
      db.mesocycles.createAlias(
        $_aliasNameGenerator(db.mesocycleWeeks.mesocycleId, db.mesocycles.id),
      );

  $$MesocyclesTableProcessedTableManager get mesocycleId {
    final $_column = $_itemColumn<int>('mesocycle_id')!;

    final manager = $$MesocyclesTableTableManager(
      $_db,
      $_db.mesocycles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mesocycleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MesocycleDaysTable, List<MesocycleDay>>
  _mesocycleDaysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mesocycleDays,
    aliasName: $_aliasNameGenerator(
      db.mesocycleWeeks.id,
      db.mesocycleDays.mesocycleWeekId,
    ),
  );

  $$MesocycleDaysTableProcessedTableManager get mesocycleDaysRefs {
    final manager = $$MesocycleDaysTableTableManager(
      $_db,
      $_db.mesocycleDays,
    ).filter((f) => f.mesocycleWeekId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mesocycleDaysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutsTable, List<Workout>> _workoutsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.workouts,
    aliasName: $_aliasNameGenerator(
      db.mesocycleWeeks.id,
      db.workouts.mesocycleWeekId,
    ),
  );

  $$WorkoutsTableProcessedTableManager get workoutsRefs {
    final manager = $$WorkoutsTableTableManager(
      $_db,
      $_db.workouts,
    ).filter((f) => f.mesocycleWeekId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MesocycleWeeksTableFilterComposer
    extends Composer<_$AppDatabase, $MesocycleWeeksTable> {
  $$MesocycleWeeksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phaseName => $composableBuilder(
    column: $table.phaseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeMultiplier => $composableBuilder(
    column: $table.volumeMultiplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get intensityMultiplier => $composableBuilder(
    column: $table.intensityMultiplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$MesocyclesTableFilterComposer get mesocycleId {
    final $$MesocyclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleId,
      referencedTable: $db.mesocycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocyclesTableFilterComposer(
            $db: $db,
            $table: $db.mesocycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> mesocycleDaysRefs(
    Expression<bool> Function($$MesocycleDaysTableFilterComposer f) f,
  ) {
    final $$MesocycleDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mesocycleDays,
      getReferencedColumn: (t) => t.mesocycleWeekId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleDaysTableFilterComposer(
            $db: $db,
            $table: $db.mesocycleDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutsRefs(
    Expression<bool> Function($$WorkoutsTableFilterComposer f) f,
  ) {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.mesocycleWeekId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableFilterComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MesocycleWeeksTableOrderingComposer
    extends Composer<_$AppDatabase, $MesocycleWeeksTable> {
  $$MesocycleWeeksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phaseName => $composableBuilder(
    column: $table.phaseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeMultiplier => $composableBuilder(
    column: $table.volumeMultiplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get intensityMultiplier => $composableBuilder(
    column: $table.intensityMultiplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$MesocyclesTableOrderingComposer get mesocycleId {
    final $$MesocyclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleId,
      referencedTable: $db.mesocycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocyclesTableOrderingComposer(
            $db: $db,
            $table: $db.mesocycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MesocycleWeeksTableAnnotationComposer
    extends Composer<_$AppDatabase, $MesocycleWeeksTable> {
  $$MesocycleWeeksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phaseName =>
      $composableBuilder(column: $table.phaseName, builder: (column) => column);

  GeneratedColumn<double> get volumeMultiplier => $composableBuilder(
    column: $table.volumeMultiplier,
    builder: (column) => column,
  );

  GeneratedColumn<double> get intensityMultiplier => $composableBuilder(
    column: $table.intensityMultiplier,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$MesocyclesTableAnnotationComposer get mesocycleId {
    final $$MesocyclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleId,
      referencedTable: $db.mesocycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocyclesTableAnnotationComposer(
            $db: $db,
            $table: $db.mesocycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> mesocycleDaysRefs<T extends Object>(
    Expression<T> Function($$MesocycleDaysTableAnnotationComposer a) f,
  ) {
    final $$MesocycleDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mesocycleDays,
      getReferencedColumn: (t) => t.mesocycleWeekId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.mesocycleDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workoutsRefs<T extends Object>(
    Expression<T> Function($$WorkoutsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.mesocycleWeekId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableAnnotationComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MesocycleWeeksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MesocycleWeeksTable,
          MesocycleWeek,
          $$MesocycleWeeksTableFilterComposer,
          $$MesocycleWeeksTableOrderingComposer,
          $$MesocycleWeeksTableAnnotationComposer,
          $$MesocycleWeeksTableCreateCompanionBuilder,
          $$MesocycleWeeksTableUpdateCompanionBuilder,
          (MesocycleWeek, $$MesocycleWeeksTableReferences),
          MesocycleWeek,
          PrefetchHooks Function({
            bool mesocycleId,
            bool mesocycleDaysRefs,
            bool workoutsRefs,
          })
        > {
  $$MesocycleWeeksTableTableManager(
    _$AppDatabase db,
    $MesocycleWeeksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MesocycleWeeksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MesocycleWeeksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MesocycleWeeksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mesocycleId = const Value.absent(),
                Value<int> weekNumber = const Value.absent(),
                Value<String> phaseName = const Value.absent(),
                Value<double> volumeMultiplier = const Value.absent(),
                Value<double> intensityMultiplier = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MesocycleWeeksCompanion(
                id: id,
                mesocycleId: mesocycleId,
                weekNumber: weekNumber,
                phaseName: phaseName,
                volumeMultiplier: volumeMultiplier,
                intensityMultiplier: intensityMultiplier,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mesocycleId,
                required int weekNumber,
                required String phaseName,
                Value<double> volumeMultiplier = const Value.absent(),
                Value<double> intensityMultiplier = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MesocycleWeeksCompanion.insert(
                id: id,
                mesocycleId: mesocycleId,
                weekNumber: weekNumber,
                phaseName: phaseName,
                volumeMultiplier: volumeMultiplier,
                intensityMultiplier: intensityMultiplier,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MesocycleWeeksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                mesocycleId = false,
                mesocycleDaysRefs = false,
                workoutsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mesocycleDaysRefs) db.mesocycleDays,
                    if (workoutsRefs) db.workouts,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (mesocycleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mesocycleId,
                                    referencedTable:
                                        $$MesocycleWeeksTableReferences
                                            ._mesocycleIdTable(db),
                                    referencedColumn:
                                        $$MesocycleWeeksTableReferences
                                            ._mesocycleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mesocycleDaysRefs)
                        await $_getPrefetchedData<
                          MesocycleWeek,
                          $MesocycleWeeksTable,
                          MesocycleDay
                        >(
                          currentTable: table,
                          referencedTable: $$MesocycleWeeksTableReferences
                              ._mesocycleDaysRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MesocycleWeeksTableReferences(
                                db,
                                table,
                                p0,
                              ).mesocycleDaysRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mesocycleWeekId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutsRefs)
                        await $_getPrefetchedData<
                          MesocycleWeek,
                          $MesocycleWeeksTable,
                          Workout
                        >(
                          currentTable: table,
                          referencedTable: $$MesocycleWeeksTableReferences
                              ._workoutsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MesocycleWeeksTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mesocycleWeekId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MesocycleWeeksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MesocycleWeeksTable,
      MesocycleWeek,
      $$MesocycleWeeksTableFilterComposer,
      $$MesocycleWeeksTableOrderingComposer,
      $$MesocycleWeeksTableAnnotationComposer,
      $$MesocycleWeeksTableCreateCompanionBuilder,
      $$MesocycleWeeksTableUpdateCompanionBuilder,
      (MesocycleWeek, $$MesocycleWeeksTableReferences),
      MesocycleWeek,
      PrefetchHooks Function({
        bool mesocycleId,
        bool mesocycleDaysRefs,
        bool workoutsRefs,
      })
    >;
typedef $$MesocycleDaysTableCreateCompanionBuilder =
    MesocycleDaysCompanion Function({
      Value<int> id,
      required int mesocycleWeekId,
      required int dayNumber,
      required String title,
      Value<String?> splitLabel,
    });
typedef $$MesocycleDaysTableUpdateCompanionBuilder =
    MesocycleDaysCompanion Function({
      Value<int> id,
      Value<int> mesocycleWeekId,
      Value<int> dayNumber,
      Value<String> title,
      Value<String?> splitLabel,
    });

final class $$MesocycleDaysTableReferences
    extends BaseReferences<_$AppDatabase, $MesocycleDaysTable, MesocycleDay> {
  $$MesocycleDaysTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MesocycleWeeksTable _mesocycleWeekIdTable(_$AppDatabase db) =>
      db.mesocycleWeeks.createAlias(
        $_aliasNameGenerator(
          db.mesocycleDays.mesocycleWeekId,
          db.mesocycleWeeks.id,
        ),
      );

  $$MesocycleWeeksTableProcessedTableManager get mesocycleWeekId {
    final $_column = $_itemColumn<int>('mesocycle_week_id')!;

    final manager = $$MesocycleWeeksTableTableManager(
      $_db,
      $_db.mesocycleWeeks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mesocycleWeekIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WorkoutsTable, List<Workout>> _workoutsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.workouts,
    aliasName: $_aliasNameGenerator(
      db.mesocycleDays.id,
      db.workouts.mesocycleDayId,
    ),
  );

  $$WorkoutsTableProcessedTableManager get workoutsRefs {
    final manager = $$WorkoutsTableTableManager(
      $_db,
      $_db.workouts,
    ).filter((f) => f.mesocycleDayId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MesocycleExercisesTable, List<MesocycleExercise>>
  _mesocycleExercisesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.mesocycleExercises,
        aliasName: $_aliasNameGenerator(
          db.mesocycleDays.id,
          db.mesocycleExercises.mesocycleDayId,
        ),
      );

  $$MesocycleExercisesTableProcessedTableManager get mesocycleExercisesRefs {
    final manager = $$MesocycleExercisesTableTableManager(
      $_db,
      $_db.mesocycleExercises,
    ).filter((f) => f.mesocycleDayId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mesocycleExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MesocycleDaysTableFilterComposer
    extends Composer<_$AppDatabase, $MesocycleDaysTable> {
  $$MesocycleDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get splitLabel => $composableBuilder(
    column: $table.splitLabel,
    builder: (column) => ColumnFilters(column),
  );

  $$MesocycleWeeksTableFilterComposer get mesocycleWeekId {
    final $$MesocycleWeeksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleWeekId,
      referencedTable: $db.mesocycleWeeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleWeeksTableFilterComposer(
            $db: $db,
            $table: $db.mesocycleWeeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> workoutsRefs(
    Expression<bool> Function($$WorkoutsTableFilterComposer f) f,
  ) {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.mesocycleDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableFilterComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mesocycleExercisesRefs(
    Expression<bool> Function($$MesocycleExercisesTableFilterComposer f) f,
  ) {
    final $$MesocycleExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mesocycleExercises,
      getReferencedColumn: (t) => t.mesocycleDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleExercisesTableFilterComposer(
            $db: $db,
            $table: $db.mesocycleExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MesocycleDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $MesocycleDaysTable> {
  $$MesocycleDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get splitLabel => $composableBuilder(
    column: $table.splitLabel,
    builder: (column) => ColumnOrderings(column),
  );

  $$MesocycleWeeksTableOrderingComposer get mesocycleWeekId {
    final $$MesocycleWeeksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleWeekId,
      referencedTable: $db.mesocycleWeeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleWeeksTableOrderingComposer(
            $db: $db,
            $table: $db.mesocycleWeeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MesocycleDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $MesocycleDaysTable> {
  $$MesocycleDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayNumber =>
      $composableBuilder(column: $table.dayNumber, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get splitLabel => $composableBuilder(
    column: $table.splitLabel,
    builder: (column) => column,
  );

  $$MesocycleWeeksTableAnnotationComposer get mesocycleWeekId {
    final $$MesocycleWeeksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleWeekId,
      referencedTable: $db.mesocycleWeeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleWeeksTableAnnotationComposer(
            $db: $db,
            $table: $db.mesocycleWeeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> workoutsRefs<T extends Object>(
    Expression<T> Function($$WorkoutsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.mesocycleDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableAnnotationComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mesocycleExercisesRefs<T extends Object>(
    Expression<T> Function($$MesocycleExercisesTableAnnotationComposer a) f,
  ) {
    final $$MesocycleExercisesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.mesocycleExercises,
          getReferencedColumn: (t) => t.mesocycleDayId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MesocycleExercisesTableAnnotationComposer(
                $db: $db,
                $table: $db.mesocycleExercises,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MesocycleDaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MesocycleDaysTable,
          MesocycleDay,
          $$MesocycleDaysTableFilterComposer,
          $$MesocycleDaysTableOrderingComposer,
          $$MesocycleDaysTableAnnotationComposer,
          $$MesocycleDaysTableCreateCompanionBuilder,
          $$MesocycleDaysTableUpdateCompanionBuilder,
          (MesocycleDay, $$MesocycleDaysTableReferences),
          MesocycleDay,
          PrefetchHooks Function({
            bool mesocycleWeekId,
            bool workoutsRefs,
            bool mesocycleExercisesRefs,
          })
        > {
  $$MesocycleDaysTableTableManager(_$AppDatabase db, $MesocycleDaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MesocycleDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MesocycleDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MesocycleDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mesocycleWeekId = const Value.absent(),
                Value<int> dayNumber = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> splitLabel = const Value.absent(),
              }) => MesocycleDaysCompanion(
                id: id,
                mesocycleWeekId: mesocycleWeekId,
                dayNumber: dayNumber,
                title: title,
                splitLabel: splitLabel,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mesocycleWeekId,
                required int dayNumber,
                required String title,
                Value<String?> splitLabel = const Value.absent(),
              }) => MesocycleDaysCompanion.insert(
                id: id,
                mesocycleWeekId: mesocycleWeekId,
                dayNumber: dayNumber,
                title: title,
                splitLabel: splitLabel,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MesocycleDaysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                mesocycleWeekId = false,
                workoutsRefs = false,
                mesocycleExercisesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workoutsRefs) db.workouts,
                    if (mesocycleExercisesRefs) db.mesocycleExercises,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (mesocycleWeekId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mesocycleWeekId,
                                    referencedTable:
                                        $$MesocycleDaysTableReferences
                                            ._mesocycleWeekIdTable(db),
                                    referencedColumn:
                                        $$MesocycleDaysTableReferences
                                            ._mesocycleWeekIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workoutsRefs)
                        await $_getPrefetchedData<
                          MesocycleDay,
                          $MesocycleDaysTable,
                          Workout
                        >(
                          currentTable: table,
                          referencedTable: $$MesocycleDaysTableReferences
                              ._workoutsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MesocycleDaysTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mesocycleDayId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mesocycleExercisesRefs)
                        await $_getPrefetchedData<
                          MesocycleDay,
                          $MesocycleDaysTable,
                          MesocycleExercise
                        >(
                          currentTable: table,
                          referencedTable: $$MesocycleDaysTableReferences
                              ._mesocycleExercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MesocycleDaysTableReferences(
                                db,
                                table,
                                p0,
                              ).mesocycleExercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mesocycleDayId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MesocycleDaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MesocycleDaysTable,
      MesocycleDay,
      $$MesocycleDaysTableFilterComposer,
      $$MesocycleDaysTableOrderingComposer,
      $$MesocycleDaysTableAnnotationComposer,
      $$MesocycleDaysTableCreateCompanionBuilder,
      $$MesocycleDaysTableUpdateCompanionBuilder,
      (MesocycleDay, $$MesocycleDaysTableReferences),
      MesocycleDay,
      PrefetchHooks Function({
        bool mesocycleWeekId,
        bool workoutsRefs,
        bool mesocycleExercisesRefs,
      })
    >;
typedef $$WorkoutsTableCreateCompanionBuilder =
    WorkoutsCompanion Function({
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
      Value<int?> mesocycleId,
      Value<int?> mesocycleWeekId,
      Value<int?> mesocycleDayId,
    });
typedef $$WorkoutsTableUpdateCompanionBuilder =
    WorkoutsCompanion Function({
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
      Value<int?> mesocycleId,
      Value<int?> mesocycleWeekId,
      Value<int?> mesocycleDayId,
    });

final class $$WorkoutsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutsTable, Workout> {
  $$WorkoutsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutTemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.workoutTemplates.createAlias(
        $_aliasNameGenerator(db.workouts.templateId, db.workoutTemplates.id),
      );

  $$WorkoutTemplatesTableProcessedTableManager? get templateId {
    final $_column = $_itemColumn<int>('template_id');
    if ($_column == null) return null;
    final manager = $$WorkoutTemplatesTableTableManager(
      $_db,
      $_db.workoutTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TemplateDaysTable _dayIdTable(_$AppDatabase db) => db.templateDays
      .createAlias($_aliasNameGenerator(db.workouts.dayId, db.templateDays.id));

  $$TemplateDaysTableProcessedTableManager? get dayId {
    final $_column = $_itemColumn<int>('day_id');
    if ($_column == null) return null;
    final manager = $$TemplateDaysTableTableManager(
      $_db,
      $_db.templateDays,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MesocyclesTable _mesocycleIdTable(_$AppDatabase db) =>
      db.mesocycles.createAlias(
        $_aliasNameGenerator(db.workouts.mesocycleId, db.mesocycles.id),
      );

  $$MesocyclesTableProcessedTableManager? get mesocycleId {
    final $_column = $_itemColumn<int>('mesocycle_id');
    if ($_column == null) return null;
    final manager = $$MesocyclesTableTableManager(
      $_db,
      $_db.mesocycles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mesocycleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MesocycleWeeksTable _mesocycleWeekIdTable(_$AppDatabase db) =>
      db.mesocycleWeeks.createAlias(
        $_aliasNameGenerator(db.workouts.mesocycleWeekId, db.mesocycleWeeks.id),
      );

  $$MesocycleWeeksTableProcessedTableManager? get mesocycleWeekId {
    final $_column = $_itemColumn<int>('mesocycle_week_id');
    if ($_column == null) return null;
    final manager = $$MesocycleWeeksTableTableManager(
      $_db,
      $_db.mesocycleWeeks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mesocycleWeekIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MesocycleDaysTable _mesocycleDayIdTable(_$AppDatabase db) =>
      db.mesocycleDays.createAlias(
        $_aliasNameGenerator(db.workouts.mesocycleDayId, db.mesocycleDays.id),
      );

  $$MesocycleDaysTableProcessedTableManager? get mesocycleDayId {
    final $_column = $_itemColumn<int>('mesocycle_day_id');
    if ($_column == null) return null;
    final manager = $$MesocycleDaysTableTableManager(
      $_db,
      $_db.mesocycleDays,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mesocycleDayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WorkoutSetsTable, List<WorkoutSet>>
  _workoutSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutSets,
    aliasName: $_aliasNameGenerator(db.workouts.id, db.workoutSets.workoutId),
  );

  $$WorkoutSetsTableProcessedTableManager get workoutSetsRefs {
    final manager = $$WorkoutSetsTableTableManager(
      $_db,
      $_db.workoutSets,
    ).filter((f) => f.workoutId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutSetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncQueueTable, List<SyncQueueData>>
  _syncQueueRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.syncQueue,
    aliasName: $_aliasNameGenerator(db.workouts.id, db.syncQueue.workoutId),
  );

  $$SyncQueueTableProcessedTableManager get syncQueueRefs {
    final manager = $$SyncQueueTableTableManager(
      $_db,
      $_db.syncQueue,
    ).filter((f) => f.workoutId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncQueueRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $Exercise1RmSnapshotsTable,
    List<Exercise1RmSnapshot>
  >
  _exercise1RmSnapshotsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.exercise1RmSnapshots,
        aliasName: $_aliasNameGenerator(
          db.workouts.id,
          db.exercise1RmSnapshots.workoutId,
        ),
      );

  $$Exercise1RmSnapshotsTableProcessedTableManager
  get exercise1RmSnapshotsRefs {
    final manager = $$Exercise1RmSnapshotsTableTableManager(
      $_db,
      $_db.exercise1RmSnapshots,
    ).filter((f) => f.workoutId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exercise1RmSnapshotsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutTemplatesTableFilterComposer get templateId {
    final $$WorkoutTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.workoutTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.workoutTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemplateDaysTableFilterComposer get dayId {
    final $$TemplateDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dayId,
      referencedTable: $db.templateDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateDaysTableFilterComposer(
            $db: $db,
            $table: $db.templateDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MesocyclesTableFilterComposer get mesocycleId {
    final $$MesocyclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleId,
      referencedTable: $db.mesocycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocyclesTableFilterComposer(
            $db: $db,
            $table: $db.mesocycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MesocycleWeeksTableFilterComposer get mesocycleWeekId {
    final $$MesocycleWeeksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleWeekId,
      referencedTable: $db.mesocycleWeeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleWeeksTableFilterComposer(
            $db: $db,
            $table: $db.mesocycleWeeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MesocycleDaysTableFilterComposer get mesocycleDayId {
    final $$MesocycleDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleDayId,
      referencedTable: $db.mesocycleDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleDaysTableFilterComposer(
            $db: $db,
            $table: $db.mesocycleDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> workoutSetsRefs(
    Expression<bool> Function($$WorkoutSetsTableFilterComposer f) f,
  ) {
    final $$WorkoutSetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSets,
      getReferencedColumn: (t) => t.workoutId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSetsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syncQueueRefs(
    Expression<bool> Function($$SyncQueueTableFilterComposer f) f,
  ) {
    final $$SyncQueueTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncQueue,
      getReferencedColumn: (t) => t.workoutId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncQueueTableFilterComposer(
            $db: $db,
            $table: $db.syncQueue,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> exercise1RmSnapshotsRefs(
    Expression<bool> Function($$Exercise1RmSnapshotsTableFilterComposer f) f,
  ) {
    final $$Exercise1RmSnapshotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercise1RmSnapshots,
      getReferencedColumn: (t) => t.workoutId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$Exercise1RmSnapshotsTableFilterComposer(
            $db: $db,
            $table: $db.exercise1RmSnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutTemplatesTableOrderingComposer get templateId {
    final $$WorkoutTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.workoutTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.workoutTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemplateDaysTableOrderingComposer get dayId {
    final $$TemplateDaysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dayId,
      referencedTable: $db.templateDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateDaysTableOrderingComposer(
            $db: $db,
            $table: $db.templateDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MesocyclesTableOrderingComposer get mesocycleId {
    final $$MesocyclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleId,
      referencedTable: $db.mesocycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocyclesTableOrderingComposer(
            $db: $db,
            $table: $db.mesocycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MesocycleWeeksTableOrderingComposer get mesocycleWeekId {
    final $$MesocycleWeeksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleWeekId,
      referencedTable: $db.mesocycleWeeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleWeeksTableOrderingComposer(
            $db: $db,
            $table: $db.mesocycleWeeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MesocycleDaysTableOrderingComposer get mesocycleDayId {
    final $$MesocycleDaysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleDayId,
      referencedTable: $db.mesocycleDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleDaysTableOrderingComposer(
            $db: $db,
            $table: $db.mesocycleDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TemplateDaysTableAnnotationComposer get dayId {
    final $$TemplateDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dayId,
      referencedTable: $db.templateDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.templateDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MesocyclesTableAnnotationComposer get mesocycleId {
    final $$MesocyclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleId,
      referencedTable: $db.mesocycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocyclesTableAnnotationComposer(
            $db: $db,
            $table: $db.mesocycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MesocycleWeeksTableAnnotationComposer get mesocycleWeekId {
    final $$MesocycleWeeksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleWeekId,
      referencedTable: $db.mesocycleWeeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleWeeksTableAnnotationComposer(
            $db: $db,
            $table: $db.mesocycleWeeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MesocycleDaysTableAnnotationComposer get mesocycleDayId {
    final $$MesocycleDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleDayId,
      referencedTable: $db.mesocycleDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.mesocycleDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> workoutSetsRefs<T extends Object>(
    Expression<T> Function($$WorkoutSetsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutSetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSets,
      getReferencedColumn: (t) => t.workoutId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSetsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> syncQueueRefs<T extends Object>(
    Expression<T> Function($$SyncQueueTableAnnotationComposer a) f,
  ) {
    final $$SyncQueueTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncQueue,
      getReferencedColumn: (t) => t.workoutId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncQueueTableAnnotationComposer(
            $db: $db,
            $table: $db.syncQueue,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> exercise1RmSnapshotsRefs<T extends Object>(
    Expression<T> Function($$Exercise1RmSnapshotsTableAnnotationComposer a) f,
  ) {
    final $$Exercise1RmSnapshotsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exercise1RmSnapshots,
          getReferencedColumn: (t) => t.workoutId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$Exercise1RmSnapshotsTableAnnotationComposer(
                $db: $db,
                $table: $db.exercise1RmSnapshots,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$WorkoutsTableTableManager
    extends
        RootTableManager<
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
          PrefetchHooks Function({
            bool templateId,
            bool dayId,
            bool mesocycleId,
            bool mesocycleWeekId,
            bool mesocycleDayId,
            bool workoutSetsRefs,
            bool syncQueueRefs,
            bool exercise1RmSnapshotsRefs,
          })
        > {
  $$WorkoutsTableTableManager(_$AppDatabase db, $WorkoutsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
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
                Value<int?> mesocycleId = const Value.absent(),
                Value<int?> mesocycleWeekId = const Value.absent(),
                Value<int?> mesocycleDayId = const Value.absent(),
              }) => WorkoutsCompanion(
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
                mesocycleId: mesocycleId,
                mesocycleWeekId: mesocycleWeekId,
                mesocycleDayId: mesocycleDayId,
              ),
          createCompanionCallback:
              ({
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
                Value<int?> mesocycleId = const Value.absent(),
                Value<int?> mesocycleWeekId = const Value.absent(),
                Value<int?> mesocycleDayId = const Value.absent(),
              }) => WorkoutsCompanion.insert(
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
                mesocycleId: mesocycleId,
                mesocycleWeekId: mesocycleWeekId,
                mesocycleDayId: mesocycleDayId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                templateId = false,
                dayId = false,
                mesocycleId = false,
                mesocycleWeekId = false,
                mesocycleDayId = false,
                workoutSetsRefs = false,
                syncQueueRefs = false,
                exercise1RmSnapshotsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workoutSetsRefs) db.workoutSets,
                    if (syncQueueRefs) db.syncQueue,
                    if (exercise1RmSnapshotsRefs) db.exercise1RmSnapshots,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (templateId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.templateId,
                                    referencedTable: $$WorkoutsTableReferences
                                        ._templateIdTable(db),
                                    referencedColumn: $$WorkoutsTableReferences
                                        ._templateIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (dayId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.dayId,
                                    referencedTable: $$WorkoutsTableReferences
                                        ._dayIdTable(db),
                                    referencedColumn: $$WorkoutsTableReferences
                                        ._dayIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (mesocycleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mesocycleId,
                                    referencedTable: $$WorkoutsTableReferences
                                        ._mesocycleIdTable(db),
                                    referencedColumn: $$WorkoutsTableReferences
                                        ._mesocycleIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (mesocycleWeekId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mesocycleWeekId,
                                    referencedTable: $$WorkoutsTableReferences
                                        ._mesocycleWeekIdTable(db),
                                    referencedColumn: $$WorkoutsTableReferences
                                        ._mesocycleWeekIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (mesocycleDayId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mesocycleDayId,
                                    referencedTable: $$WorkoutsTableReferences
                                        ._mesocycleDayIdTable(db),
                                    referencedColumn: $$WorkoutsTableReferences
                                        ._mesocycleDayIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workoutSetsRefs)
                        await $_getPrefetchedData<
                          Workout,
                          $WorkoutsTable,
                          WorkoutSet
                        >(
                          currentTable: table,
                          referencedTable: $$WorkoutsTableReferences
                              ._workoutSetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutsTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutSetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.workoutId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncQueueRefs)
                        await $_getPrefetchedData<
                          Workout,
                          $WorkoutsTable,
                          SyncQueueData
                        >(
                          currentTable: table,
                          referencedTable: $$WorkoutsTableReferences
                              ._syncQueueRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutsTableReferences(
                                db,
                                table,
                                p0,
                              ).syncQueueRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.workoutId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (exercise1RmSnapshotsRefs)
                        await $_getPrefetchedData<
                          Workout,
                          $WorkoutsTable,
                          Exercise1RmSnapshot
                        >(
                          currentTable: table,
                          referencedTable: $$WorkoutsTableReferences
                              ._exercise1RmSnapshotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutsTableReferences(
                                db,
                                table,
                                p0,
                              ).exercise1RmSnapshotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.workoutId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WorkoutsTableProcessedTableManager =
    ProcessedTableManager<
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
      PrefetchHooks Function({
        bool templateId,
        bool dayId,
        bool mesocycleId,
        bool mesocycleWeekId,
        bool mesocycleDayId,
        bool workoutSetsRefs,
        bool syncQueueRefs,
        bool exercise1RmSnapshotsRefs,
      })
    >;
typedef $$WorkoutSetsTableCreateCompanionBuilder =
    WorkoutSetsCompanion Function({
      Value<int> id,
      required int workoutId,
      required int exerciseId,
      required int exerciseOrder,
      required int setNumber,
      required double reps,
      required double weight,
      Value<double?> rpe,
      Value<int?> rir,
      Value<SetType> setType,
      Value<String?> notes,
      Value<bool> completed,
      Value<DateTime?> completedAt,
      Value<bool> isPr,
      Value<String?> supersetGroupId,
      Value<String?> subSetsJson,
      Value<bool> isFavorite,
    });
typedef $$WorkoutSetsTableUpdateCompanionBuilder =
    WorkoutSetsCompanion Function({
      Value<int> id,
      Value<int> workoutId,
      Value<int> exerciseId,
      Value<int> exerciseOrder,
      Value<int> setNumber,
      Value<double> reps,
      Value<double> weight,
      Value<double?> rpe,
      Value<int?> rir,
      Value<SetType> setType,
      Value<String?> notes,
      Value<bool> completed,
      Value<DateTime?> completedAt,
      Value<bool> isPr,
      Value<String?> supersetGroupId,
      Value<String?> subSetsJson,
      Value<bool> isFavorite,
    });

final class $$WorkoutSetsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutSetsTable, WorkoutSet> {
  $$WorkoutSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutsTable _workoutIdTable(_$AppDatabase db) =>
      db.workouts.createAlias(
        $_aliasNameGenerator(db.workoutSets.workoutId, db.workouts.id),
      );

  $$WorkoutsTableProcessedTableManager get workoutId {
    final $_column = $_itemColumn<int>('workout_id')!;

    final manager = $$WorkoutsTableTableManager(
      $_db,
      $_db.workouts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.workoutSets.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exerciseOrder => $composableBuilder(
    column: $table.exerciseOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rir => $composableBuilder(
    column: $table.rir,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SetType, SetType, int> get setType =>
      $composableBuilder(
        column: $table.setType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPr => $composableBuilder(
    column: $table.isPr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supersetGroupId => $composableBuilder(
    column: $table.supersetGroupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subSetsJson => $composableBuilder(
    column: $table.subSetsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutsTableFilterComposer get workoutId {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutId,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableFilterComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exerciseOrder => $composableBuilder(
    column: $table.exerciseOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rir => $composableBuilder(
    column: $table.rir,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setType => $composableBuilder(
    column: $table.setType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPr => $composableBuilder(
    column: $table.isPr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supersetGroupId => $composableBuilder(
    column: $table.supersetGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subSetsJson => $composableBuilder(
    column: $table.subSetsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutsTableOrderingComposer get workoutId {
    final $$WorkoutsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutId,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableOrderingComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.exerciseOrder,
    builder: (column) => column,
  );

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<double> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get rpe =>
      $composableBuilder(column: $table.rpe, builder: (column) => column);

  GeneratedColumn<int> get rir =>
      $composableBuilder(column: $table.rir, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SetType, int> get setType =>
      $composableBuilder(column: $table.setType, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPr =>
      $composableBuilder(column: $table.isPr, builder: (column) => column);

  GeneratedColumn<String> get supersetGroupId => $composableBuilder(
    column: $table.supersetGroupId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subSetsJson => $composableBuilder(
    column: $table.subSetsJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  $$WorkoutsTableAnnotationComposer get workoutId {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutId,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableAnnotationComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutSetsTableTableManager
    extends
        RootTableManager<
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
          PrefetchHooks Function({bool workoutId, bool exerciseId})
        > {
  $$WorkoutSetsTableTableManager(_$AppDatabase db, $WorkoutSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> workoutId = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int> exerciseOrder = const Value.absent(),
                Value<int> setNumber = const Value.absent(),
                Value<double> reps = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<double?> rpe = const Value.absent(),
                Value<int?> rir = const Value.absent(),
                Value<SetType> setType = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> isPr = const Value.absent(),
                Value<String?> supersetGroupId = const Value.absent(),
                Value<String?> subSetsJson = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => WorkoutSetsCompanion(
                id: id,
                workoutId: workoutId,
                exerciseId: exerciseId,
                exerciseOrder: exerciseOrder,
                setNumber: setNumber,
                reps: reps,
                weight: weight,
                rpe: rpe,
                rir: rir,
                setType: setType,
                notes: notes,
                completed: completed,
                completedAt: completedAt,
                isPr: isPr,
                supersetGroupId: supersetGroupId,
                subSetsJson: subSetsJson,
                isFavorite: isFavorite,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int workoutId,
                required int exerciseId,
                required int exerciseOrder,
                required int setNumber,
                required double reps,
                required double weight,
                Value<double?> rpe = const Value.absent(),
                Value<int?> rir = const Value.absent(),
                Value<SetType> setType = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> isPr = const Value.absent(),
                Value<String?> supersetGroupId = const Value.absent(),
                Value<String?> subSetsJson = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => WorkoutSetsCompanion.insert(
                id: id,
                workoutId: workoutId,
                exerciseId: exerciseId,
                exerciseOrder: exerciseOrder,
                setNumber: setNumber,
                reps: reps,
                weight: weight,
                rpe: rpe,
                rir: rir,
                setType: setType,
                notes: notes,
                completed: completed,
                completedAt: completedAt,
                isPr: isPr,
                supersetGroupId: supersetGroupId,
                subSetsJson: subSetsJson,
                isFavorite: isFavorite,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutSetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workoutId = false, exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (workoutId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workoutId,
                                referencedTable: $$WorkoutSetsTableReferences
                                    ._workoutIdTable(db),
                                referencedColumn: $$WorkoutSetsTableReferences
                                    ._workoutIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable: $$WorkoutSetsTableReferences
                                    ._exerciseIdTable(db),
                                referencedColumn: $$WorkoutSetsTableReferences
                                    ._exerciseIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WorkoutSetsTableProcessedTableManager =
    ProcessedTableManager<
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
      PrefetchHooks Function({bool workoutId, bool exerciseId})
    >;
typedef $$BodyMeasurementsTableCreateCompanionBuilder =
    BodyMeasurementsCompanion Function({
      Value<int> id,
      required DateTime date,
      Value<double?> weight,
      Value<double?> bodyFat,
      Value<double?> neck,
      Value<double?> chest,
      Value<double?> shoulders,
      Value<double?> armLeft,
      Value<double?> armRight,
      Value<double?> forearmLeft,
      Value<double?> forearmRight,
      Value<double?> waist,
      Value<double?> waistNaval,
      Value<double?> hips,
      Value<double?> thighLeft,
      Value<double?> thighRight,
      Value<double?> calfLeft,
      Value<double?> calfRight,
      Value<double?> height,
      Value<double?> subcutaneousFat,
      Value<double?> visceralFat,
      Value<String?> customValues,
      Value<String?> notes,
    });
typedef $$BodyMeasurementsTableUpdateCompanionBuilder =
    BodyMeasurementsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<double?> weight,
      Value<double?> bodyFat,
      Value<double?> neck,
      Value<double?> chest,
      Value<double?> shoulders,
      Value<double?> armLeft,
      Value<double?> armRight,
      Value<double?> forearmLeft,
      Value<double?> forearmRight,
      Value<double?> waist,
      Value<double?> waistNaval,
      Value<double?> hips,
      Value<double?> thighLeft,
      Value<double?> thighRight,
      Value<double?> calfLeft,
      Value<double?> calfRight,
      Value<double?> height,
      Value<double?> subcutaneousFat,
      Value<double?> visceralFat,
      Value<String?> customValues,
      Value<String?> notes,
    });

final class $$BodyMeasurementsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BodyMeasurementsTable,
          BodyMeasurementTable
        > {
  $$BodyMeasurementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SyncQueueTable, List<SyncQueueData>>
  _syncQueueRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.syncQueue,
    aliasName: $_aliasNameGenerator(
      db.bodyMeasurements.id,
      db.syncQueue.measurementId,
    ),
  );

  $$SyncQueueTableProcessedTableManager get syncQueueRefs {
    final manager = $$SyncQueueTableTableManager(
      $_db,
      $_db.syncQueue,
    ).filter((f) => f.measurementId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncQueueRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyFat => $composableBuilder(
    column: $table.bodyFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get neck => $composableBuilder(
    column: $table.neck,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get chest => $composableBuilder(
    column: $table.chest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shoulders => $composableBuilder(
    column: $table.shoulders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get armLeft => $composableBuilder(
    column: $table.armLeft,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get armRight => $composableBuilder(
    column: $table.armRight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get forearmLeft => $composableBuilder(
    column: $table.forearmLeft,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get forearmRight => $composableBuilder(
    column: $table.forearmRight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waist => $composableBuilder(
    column: $table.waist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waistNaval => $composableBuilder(
    column: $table.waistNaval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hips => $composableBuilder(
    column: $table.hips,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get thighLeft => $composableBuilder(
    column: $table.thighLeft,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get thighRight => $composableBuilder(
    column: $table.thighRight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calfLeft => $composableBuilder(
    column: $table.calfLeft,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calfRight => $composableBuilder(
    column: $table.calfRight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subcutaneousFat => $composableBuilder(
    column: $table.subcutaneousFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get visceralFat => $composableBuilder(
    column: $table.visceralFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customValues => $composableBuilder(
    column: $table.customValues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> syncQueueRefs(
    Expression<bool> Function($$SyncQueueTableFilterComposer f) f,
  ) {
    final $$SyncQueueTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncQueue,
      getReferencedColumn: (t) => t.measurementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncQueueTableFilterComposer(
            $db: $db,
            $table: $db.syncQueue,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyFat => $composableBuilder(
    column: $table.bodyFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get neck => $composableBuilder(
    column: $table.neck,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get chest => $composableBuilder(
    column: $table.chest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shoulders => $composableBuilder(
    column: $table.shoulders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get armLeft => $composableBuilder(
    column: $table.armLeft,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get armRight => $composableBuilder(
    column: $table.armRight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get forearmLeft => $composableBuilder(
    column: $table.forearmLeft,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get forearmRight => $composableBuilder(
    column: $table.forearmRight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waist => $composableBuilder(
    column: $table.waist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waistNaval => $composableBuilder(
    column: $table.waistNaval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hips => $composableBuilder(
    column: $table.hips,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get thighLeft => $composableBuilder(
    column: $table.thighLeft,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get thighRight => $composableBuilder(
    column: $table.thighRight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calfLeft => $composableBuilder(
    column: $table.calfLeft,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calfRight => $composableBuilder(
    column: $table.calfRight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subcutaneousFat => $composableBuilder(
    column: $table.subcutaneousFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get visceralFat => $composableBuilder(
    column: $table.visceralFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customValues => $composableBuilder(
    column: $table.customValues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumn<double> get bodyFat =>
      $composableBuilder(column: $table.bodyFat, builder: (column) => column);

  GeneratedColumn<double> get neck =>
      $composableBuilder(column: $table.neck, builder: (column) => column);

  GeneratedColumn<double> get chest =>
      $composableBuilder(column: $table.chest, builder: (column) => column);

  GeneratedColumn<double> get shoulders =>
      $composableBuilder(column: $table.shoulders, builder: (column) => column);

  GeneratedColumn<double> get armLeft =>
      $composableBuilder(column: $table.armLeft, builder: (column) => column);

  GeneratedColumn<double> get armRight =>
      $composableBuilder(column: $table.armRight, builder: (column) => column);

  GeneratedColumn<double> get forearmLeft => $composableBuilder(
    column: $table.forearmLeft,
    builder: (column) => column,
  );

  GeneratedColumn<double> get forearmRight => $composableBuilder(
    column: $table.forearmRight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waist =>
      $composableBuilder(column: $table.waist, builder: (column) => column);

  GeneratedColumn<double> get waistNaval => $composableBuilder(
    column: $table.waistNaval,
    builder: (column) => column,
  );

  GeneratedColumn<double> get hips =>
      $composableBuilder(column: $table.hips, builder: (column) => column);

  GeneratedColumn<double> get thighLeft =>
      $composableBuilder(column: $table.thighLeft, builder: (column) => column);

  GeneratedColumn<double> get thighRight => $composableBuilder(
    column: $table.thighRight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get calfLeft =>
      $composableBuilder(column: $table.calfLeft, builder: (column) => column);

  GeneratedColumn<double> get calfRight =>
      $composableBuilder(column: $table.calfRight, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get subcutaneousFat => $composableBuilder(
    column: $table.subcutaneousFat,
    builder: (column) => column,
  );

  GeneratedColumn<double> get visceralFat => $composableBuilder(
    column: $table.visceralFat,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customValues => $composableBuilder(
    column: $table.customValues,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> syncQueueRefs<T extends Object>(
    Expression<T> Function($$SyncQueueTableAnnotationComposer a) f,
  ) {
    final $$SyncQueueTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncQueue,
      getReferencedColumn: (t) => t.measurementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncQueueTableAnnotationComposer(
            $db: $db,
            $table: $db.syncQueue,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BodyMeasurementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyMeasurementsTable,
          BodyMeasurementTable,
          $$BodyMeasurementsTableFilterComposer,
          $$BodyMeasurementsTableOrderingComposer,
          $$BodyMeasurementsTableAnnotationComposer,
          $$BodyMeasurementsTableCreateCompanionBuilder,
          $$BodyMeasurementsTableUpdateCompanionBuilder,
          (BodyMeasurementTable, $$BodyMeasurementsTableReferences),
          BodyMeasurementTable,
          PrefetchHooks Function({bool syncQueueRefs})
        > {
  $$BodyMeasurementsTableTableManager(
    _$AppDatabase db,
    $BodyMeasurementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyMeasurementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyMeasurementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyMeasurementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<double?> bodyFat = const Value.absent(),
                Value<double?> neck = const Value.absent(),
                Value<double?> chest = const Value.absent(),
                Value<double?> shoulders = const Value.absent(),
                Value<double?> armLeft = const Value.absent(),
                Value<double?> armRight = const Value.absent(),
                Value<double?> forearmLeft = const Value.absent(),
                Value<double?> forearmRight = const Value.absent(),
                Value<double?> waist = const Value.absent(),
                Value<double?> waistNaval = const Value.absent(),
                Value<double?> hips = const Value.absent(),
                Value<double?> thighLeft = const Value.absent(),
                Value<double?> thighRight = const Value.absent(),
                Value<double?> calfLeft = const Value.absent(),
                Value<double?> calfRight = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> subcutaneousFat = const Value.absent(),
                Value<double?> visceralFat = const Value.absent(),
                Value<String?> customValues = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => BodyMeasurementsCompanion(
                id: id,
                date: date,
                weight: weight,
                bodyFat: bodyFat,
                neck: neck,
                chest: chest,
                shoulders: shoulders,
                armLeft: armLeft,
                armRight: armRight,
                forearmLeft: forearmLeft,
                forearmRight: forearmRight,
                waist: waist,
                waistNaval: waistNaval,
                hips: hips,
                thighLeft: thighLeft,
                thighRight: thighRight,
                calfLeft: calfLeft,
                calfRight: calfRight,
                height: height,
                subcutaneousFat: subcutaneousFat,
                visceralFat: visceralFat,
                customValues: customValues,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                Value<double?> weight = const Value.absent(),
                Value<double?> bodyFat = const Value.absent(),
                Value<double?> neck = const Value.absent(),
                Value<double?> chest = const Value.absent(),
                Value<double?> shoulders = const Value.absent(),
                Value<double?> armLeft = const Value.absent(),
                Value<double?> armRight = const Value.absent(),
                Value<double?> forearmLeft = const Value.absent(),
                Value<double?> forearmRight = const Value.absent(),
                Value<double?> waist = const Value.absent(),
                Value<double?> waistNaval = const Value.absent(),
                Value<double?> hips = const Value.absent(),
                Value<double?> thighLeft = const Value.absent(),
                Value<double?> thighRight = const Value.absent(),
                Value<double?> calfLeft = const Value.absent(),
                Value<double?> calfRight = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> subcutaneousFat = const Value.absent(),
                Value<double?> visceralFat = const Value.absent(),
                Value<String?> customValues = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => BodyMeasurementsCompanion.insert(
                id: id,
                date: date,
                weight: weight,
                bodyFat: bodyFat,
                neck: neck,
                chest: chest,
                shoulders: shoulders,
                armLeft: armLeft,
                armRight: armRight,
                forearmLeft: forearmLeft,
                forearmRight: forearmRight,
                waist: waist,
                waistNaval: waistNaval,
                hips: hips,
                thighLeft: thighLeft,
                thighRight: thighRight,
                calfLeft: calfLeft,
                calfRight: calfRight,
                height: height,
                subcutaneousFat: subcutaneousFat,
                visceralFat: visceralFat,
                customValues: customValues,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BodyMeasurementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({syncQueueRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (syncQueueRefs) db.syncQueue],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (syncQueueRefs)
                    await $_getPrefetchedData<
                      BodyMeasurementTable,
                      $BodyMeasurementsTable,
                      SyncQueueData
                    >(
                      currentTable: table,
                      referencedTable: $$BodyMeasurementsTableReferences
                          ._syncQueueRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BodyMeasurementsTableReferences(
                            db,
                            table,
                            p0,
                          ).syncQueueRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.measurementId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BodyMeasurementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyMeasurementsTable,
      BodyMeasurementTable,
      $$BodyMeasurementsTableFilterComposer,
      $$BodyMeasurementsTableOrderingComposer,
      $$BodyMeasurementsTableAnnotationComposer,
      $$BodyMeasurementsTableCreateCompanionBuilder,
      $$BodyMeasurementsTableUpdateCompanionBuilder,
      (BodyMeasurementTable, $$BodyMeasurementsTableReferences),
      BodyMeasurementTable,
      PrefetchHooks Function({bool syncQueueRefs})
    >;
typedef $$BodyTargetsTableCreateCompanionBuilder =
    BodyTargetsCompanion Function({
      Value<int> id,
      required String metric,
      required double targetValue,
      Value<DateTime?> deadline,
      required DateTime createdAt,
    });
typedef $$BodyTargetsTableUpdateCompanionBuilder =
    BodyTargetsCompanion Function({
      Value<int> id,
      Value<String> metric,
      Value<double> targetValue,
      Value<DateTime?> deadline,
      Value<DateTime> createdAt,
    });

class $$BodyTargetsTableFilterComposer
    extends Composer<_$AppDatabase, $BodyTargetsTable> {
  $$BodyTargetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BodyTargetsTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyTargetsTable> {
  $$BodyTargetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BodyTargetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyTargetsTable> {
  $$BodyTargetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get metric =>
      $composableBuilder(column: $table.metric, builder: (column) => column);

  GeneratedColumn<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BodyTargetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyTargetsTable,
          BodyTarget,
          $$BodyTargetsTableFilterComposer,
          $$BodyTargetsTableOrderingComposer,
          $$BodyTargetsTableAnnotationComposer,
          $$BodyTargetsTableCreateCompanionBuilder,
          $$BodyTargetsTableUpdateCompanionBuilder,
          (
            BodyTarget,
            BaseReferences<_$AppDatabase, $BodyTargetsTable, BodyTarget>,
          ),
          BodyTarget,
          PrefetchHooks Function()
        > {
  $$BodyTargetsTableTableManager(_$AppDatabase db, $BodyTargetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyTargetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyTargetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyTargetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> metric = const Value.absent(),
                Value<double> targetValue = const Value.absent(),
                Value<DateTime?> deadline = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BodyTargetsCompanion(
                id: id,
                metric: metric,
                targetValue: targetValue,
                deadline: deadline,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String metric,
                required double targetValue,
                Value<DateTime?> deadline = const Value.absent(),
                required DateTime createdAt,
              }) => BodyTargetsCompanion.insert(
                id: id,
                metric: metric,
                targetValue: targetValue,
                deadline: deadline,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BodyTargetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyTargetsTable,
      BodyTarget,
      $$BodyTargetsTableFilterComposer,
      $$BodyTargetsTableOrderingComposer,
      $$BodyTargetsTableAnnotationComposer,
      $$BodyTargetsTableCreateCompanionBuilder,
      $$BodyTargetsTableUpdateCompanionBuilder,
      (
        BodyTarget,
        BaseReferences<_$AppDatabase, $BodyTargetsTable, BodyTarget>,
      ),
      BodyTarget,
      PrefetchHooks Function()
    >;
typedef $$ProgressPhotosTableCreateCompanionBuilder =
    ProgressPhotosCompanion Function({
      Value<int> id,
      required DateTime date,
      required String imagePath,
      Value<String> category,
      Value<String?> notes,
    });
typedef $$ProgressPhotosTableUpdateCompanionBuilder =
    ProgressPhotosCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> imagePath,
      Value<String> category,
      Value<String?> notes,
    });

class $$ProgressPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $ProgressPhotosTable> {
  $$ProgressPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgressPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgressPhotosTable> {
  $$ProgressPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgressPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgressPhotosTable> {
  $$ProgressPhotosTableAnnotationComposer({
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

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$ProgressPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgressPhotosTable,
          ProgressPhoto,
          $$ProgressPhotosTableFilterComposer,
          $$ProgressPhotosTableOrderingComposer,
          $$ProgressPhotosTableAnnotationComposer,
          $$ProgressPhotosTableCreateCompanionBuilder,
          $$ProgressPhotosTableUpdateCompanionBuilder,
          (
            ProgressPhoto,
            BaseReferences<_$AppDatabase, $ProgressPhotosTable, ProgressPhoto>,
          ),
          ProgressPhoto,
          PrefetchHooks Function()
        > {
  $$ProgressPhotosTableTableManager(
    _$AppDatabase db,
    $ProgressPhotosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgressPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgressPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgressPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => ProgressPhotosCompanion(
                id: id,
                date: date,
                imagePath: imagePath,
                category: category,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String imagePath,
                Value<String> category = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => ProgressPhotosCompanion.insert(
                id: id,
                date: date,
                imagePath: imagePath,
                category: category,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgressPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgressPhotosTable,
      ProgressPhoto,
      $$ProgressPhotosTableFilterComposer,
      $$ProgressPhotosTableOrderingComposer,
      $$ProgressPhotosTableAnnotationComposer,
      $$ProgressPhotosTableCreateCompanionBuilder,
      $$ProgressPhotosTableUpdateCompanionBuilder,
      (
        ProgressPhoto,
        BaseReferences<_$AppDatabase, $ProgressPhotosTable, ProgressPhoto>,
      ),
      ProgressPhoto,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      Value<int?> workoutId,
      Value<int?> measurementId,
      required String type,
      Value<String> status,
      required DateTime createdAt,
      Value<int> attempts,
      Value<String?> error,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
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
        $_aliasNameGenerator(db.syncQueue.workoutId, db.workouts.id),
      );

  $$WorkoutsTableProcessedTableManager? get workoutId {
    final $_column = $_itemColumn<int>('workout_id');
    if ($_column == null) return null;
    final manager = $$WorkoutsTableTableManager(
      $_db,
      $_db.workouts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BodyMeasurementsTable _measurementIdTable(_$AppDatabase db) =>
      db.bodyMeasurements.createAlias(
        $_aliasNameGenerator(
          db.syncQueue.measurementId,
          db.bodyMeasurements.id,
        ),
      );

  $$BodyMeasurementsTableProcessedTableManager? get measurementId {
    final $_column = $_itemColumn<int>('measurement_id');
    if ($_column == null) return null;
    final manager = $$BodyMeasurementsTableTableManager(
      $_db,
      $_db.bodyMeasurements,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_measurementIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutsTableFilterComposer get workoutId {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutId,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableFilterComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BodyMeasurementsTableFilterComposer get measurementId {
    final $$BodyMeasurementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.measurementId,
      referencedTable: $db.bodyMeasurements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BodyMeasurementsTableFilterComposer(
            $db: $db,
            $table: $db.bodyMeasurements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutsTableOrderingComposer get workoutId {
    final $$WorkoutsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutId,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableOrderingComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BodyMeasurementsTableOrderingComposer get measurementId {
    final $$BodyMeasurementsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.measurementId,
      referencedTable: $db.bodyMeasurements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BodyMeasurementsTableOrderingComposer(
            $db: $db,
            $table: $db.bodyMeasurements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableAnnotationComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BodyMeasurementsTableAnnotationComposer get measurementId {
    final $$BodyMeasurementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.measurementId,
      referencedTable: $db.bodyMeasurements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BodyMeasurementsTableAnnotationComposer(
            $db: $db,
            $table: $db.bodyMeasurements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
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
          PrefetchHooks Function({bool workoutId, bool measurementId})
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> workoutId = const Value.absent(),
                Value<int?> measurementId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> error = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                workoutId: workoutId,
                measurementId: measurementId,
                type: type,
                status: status,
                createdAt: createdAt,
                attempts: attempts,
                error: error,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> workoutId = const Value.absent(),
                Value<int?> measurementId = const Value.absent(),
                required String type,
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                Value<int> attempts = const Value.absent(),
                Value<String?> error = const Value.absent(),
              }) => SyncQueueCompanion.insert(
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
              .map(
                (e) => (
                  e.readTable(table),
                  $$SyncQueueTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workoutId = false, measurementId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (workoutId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workoutId,
                                referencedTable: $$SyncQueueTableReferences
                                    ._workoutIdTable(db),
                                referencedColumn: $$SyncQueueTableReferences
                                    ._workoutIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (measurementId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.measurementId,
                                referencedTable: $$SyncQueueTableReferences
                                    ._measurementIdTable(db),
                                referencedColumn: $$SyncQueueTableReferences
                                    ._measurementIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
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
      PrefetchHooks Function({bool workoutId, bool measurementId})
    >;
typedef $$ExerciseProgressionSettingsTableCreateCompanionBuilder =
    ExerciseProgressionSettingsCompanion Function({
      Value<int> id,
      required int exerciseId,
      Value<double?> incrementOverride,
      Value<int> targetReps,
      Value<int> targetSets,
      Value<bool> autoSuggest,
    });
typedef $$ExerciseProgressionSettingsTableUpdateCompanionBuilder =
    ExerciseProgressionSettingsCompanion Function({
      Value<int> id,
      Value<int> exerciseId,
      Value<double?> incrementOverride,
      Value<int> targetReps,
      Value<int> targetSets,
      Value<bool> autoSuggest,
    });

final class $$ExerciseProgressionSettingsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseProgressionSettingsTable,
          ExerciseProgressionSetting
        > {
  $$ExerciseProgressionSettingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(
          db.exerciseProgressionSettings.exerciseId,
          db.exercises.id,
        ),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get incrementOverride => $composableBuilder(
    column: $table.incrementOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetReps => $composableBuilder(
    column: $table.targetReps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoSuggest => $composableBuilder(
    column: $table.autoSuggest,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get incrementOverride => $composableBuilder(
    column: $table.incrementOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetReps => $composableBuilder(
    column: $table.targetReps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoSuggest => $composableBuilder(
    column: $table.autoSuggest,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
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
    column: $table.incrementOverride,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetReps => $composableBuilder(
    column: $table.targetReps,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoSuggest => $composableBuilder(
    column: $table.autoSuggest,
    builder: (column) => column,
  );

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseProgressionSettingsTableTableManager
    extends
        RootTableManager<
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
            $$ExerciseProgressionSettingsTableReferences,
          ),
          ExerciseProgressionSetting,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$ExerciseProgressionSettingsTableTableManager(
    _$AppDatabase db,
    $ExerciseProgressionSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseProgressionSettingsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ExerciseProgressionSettingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ExerciseProgressionSettingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<double?> incrementOverride = const Value.absent(),
                Value<int> targetReps = const Value.absent(),
                Value<int> targetSets = const Value.absent(),
                Value<bool> autoSuggest = const Value.absent(),
              }) => ExerciseProgressionSettingsCompanion(
                id: id,
                exerciseId: exerciseId,
                incrementOverride: incrementOverride,
                targetReps: targetReps,
                targetSets: targetSets,
                autoSuggest: autoSuggest,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int exerciseId,
                Value<double?> incrementOverride = const Value.absent(),
                Value<int> targetReps = const Value.absent(),
                Value<int> targetSets = const Value.absent(),
                Value<bool> autoSuggest = const Value.absent(),
              }) => ExerciseProgressionSettingsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                incrementOverride: incrementOverride,
                targetReps: targetReps,
                targetSets: targetSets,
                autoSuggest: autoSuggest,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseProgressionSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$ExerciseProgressionSettingsTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$ExerciseProgressionSettingsTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseProgressionSettingsTableProcessedTableManager =
    ProcessedTableManager<
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
        $$ExerciseProgressionSettingsTableReferences,
      ),
      ExerciseProgressionSetting,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$ExerciseMusclesTableCreateCompanionBuilder =
    ExerciseMusclesCompanion Function({
      Value<int> id,
      required int exerciseId,
      required String muscleName,
      Value<bool> isPrimary,
    });
typedef $$ExerciseMusclesTableUpdateCompanionBuilder =
    ExerciseMusclesCompanion Function({
      Value<int> id,
      Value<int> exerciseId,
      Value<String> muscleName,
      Value<bool> isPrimary,
    });

final class $$ExerciseMusclesTableReferences
    extends
        BaseReferences<_$AppDatabase, $ExerciseMusclesTable, ExerciseMuscle> {
  $$ExerciseMusclesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.exerciseMuscles.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExerciseMusclesTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseMusclesTable> {
  $$ExerciseMusclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleName => $composableBuilder(
    column: $table.muscleName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseMusclesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseMusclesTable> {
  $$ExerciseMusclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleName => $composableBuilder(
    column: $table.muscleName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseMusclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseMusclesTable> {
  $$ExerciseMusclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get muscleName => $composableBuilder(
    column: $table.muscleName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseMusclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseMusclesTable,
          ExerciseMuscle,
          $$ExerciseMusclesTableFilterComposer,
          $$ExerciseMusclesTableOrderingComposer,
          $$ExerciseMusclesTableAnnotationComposer,
          $$ExerciseMusclesTableCreateCompanionBuilder,
          $$ExerciseMusclesTableUpdateCompanionBuilder,
          (ExerciseMuscle, $$ExerciseMusclesTableReferences),
          ExerciseMuscle,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$ExerciseMusclesTableTableManager(
    _$AppDatabase db,
    $ExerciseMusclesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseMusclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseMusclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseMusclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<String> muscleName = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
              }) => ExerciseMusclesCompanion(
                id: id,
                exerciseId: exerciseId,
                muscleName: muscleName,
                isPrimary: isPrimary,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int exerciseId,
                required String muscleName,
                Value<bool> isPrimary = const Value.absent(),
              }) => ExerciseMusclesCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                muscleName: muscleName,
                isPrimary: isPrimary,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseMusclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$ExerciseMusclesTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$ExerciseMusclesTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseMusclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseMusclesTable,
      ExerciseMuscle,
      $$ExerciseMusclesTableFilterComposer,
      $$ExerciseMusclesTableOrderingComposer,
      $$ExerciseMusclesTableAnnotationComposer,
      $$ExerciseMusclesTableCreateCompanionBuilder,
      $$ExerciseMusclesTableUpdateCompanionBuilder,
      (ExerciseMuscle, $$ExerciseMusclesTableReferences),
      ExerciseMuscle,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$ExerciseBodyPartsTableCreateCompanionBuilder =
    ExerciseBodyPartsCompanion Function({
      Value<int> id,
      required int exerciseId,
      required String bodyPart,
    });
typedef $$ExerciseBodyPartsTableUpdateCompanionBuilder =
    ExerciseBodyPartsCompanion Function({
      Value<int> id,
      Value<int> exerciseId,
      Value<String> bodyPart,
    });

final class $$ExerciseBodyPartsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseBodyPartsTable,
          ExerciseBodyPart
        > {
  $$ExerciseBodyPartsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.exerciseBodyParts.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExerciseBodyPartsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseBodyPartsTable> {
  $$ExerciseBodyPartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyPart => $composableBuilder(
    column: $table.bodyPart,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseBodyPartsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseBodyPartsTable> {
  $$ExerciseBodyPartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyPart => $composableBuilder(
    column: $table.bodyPart,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseBodyPartsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseBodyPartsTable> {
  $$ExerciseBodyPartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bodyPart =>
      $composableBuilder(column: $table.bodyPart, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseBodyPartsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseBodyPartsTable,
          ExerciseBodyPart,
          $$ExerciseBodyPartsTableFilterComposer,
          $$ExerciseBodyPartsTableOrderingComposer,
          $$ExerciseBodyPartsTableAnnotationComposer,
          $$ExerciseBodyPartsTableCreateCompanionBuilder,
          $$ExerciseBodyPartsTableUpdateCompanionBuilder,
          (ExerciseBodyPart, $$ExerciseBodyPartsTableReferences),
          ExerciseBodyPart,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$ExerciseBodyPartsTableTableManager(
    _$AppDatabase db,
    $ExerciseBodyPartsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseBodyPartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseBodyPartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseBodyPartsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<String> bodyPart = const Value.absent(),
              }) => ExerciseBodyPartsCompanion(
                id: id,
                exerciseId: exerciseId,
                bodyPart: bodyPart,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int exerciseId,
                required String bodyPart,
              }) => ExerciseBodyPartsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                bodyPart: bodyPart,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseBodyPartsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$ExerciseBodyPartsTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$ExerciseBodyPartsTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseBodyPartsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseBodyPartsTable,
      ExerciseBodyPart,
      $$ExerciseBodyPartsTableFilterComposer,
      $$ExerciseBodyPartsTableOrderingComposer,
      $$ExerciseBodyPartsTableAnnotationComposer,
      $$ExerciseBodyPartsTableCreateCompanionBuilder,
      $$ExerciseBodyPartsTableUpdateCompanionBuilder,
      (ExerciseBodyPart, $$ExerciseBodyPartsTableReferences),
      ExerciseBodyPart,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$ExerciseEnrichedContentTableCreateCompanionBuilder =
    ExerciseEnrichedContentCompanion Function({
      Value<int> exerciseId,
      Value<String?> safetyTips,
      Value<String?> commonMistakes,
      Value<String?> variations,
      Value<String?> enrichedOverview,
      Value<DateTime?> enrichedAt,
      Value<String?> enrichmentSource,
    });
typedef $$ExerciseEnrichedContentTableUpdateCompanionBuilder =
    ExerciseEnrichedContentCompanion Function({
      Value<int> exerciseId,
      Value<String?> safetyTips,
      Value<String?> commonMistakes,
      Value<String?> variations,
      Value<String?> enrichedOverview,
      Value<DateTime?> enrichedAt,
      Value<String?> enrichmentSource,
    });

final class $$ExerciseEnrichedContentTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseEnrichedContentTable,
          ExerciseEnrichedContentData
        > {
  $$ExerciseEnrichedContentTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(
          db.exerciseEnrichedContent.exerciseId,
          db.exercises.id,
        ),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExerciseEnrichedContentTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseEnrichedContentTable> {
  $$ExerciseEnrichedContentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get safetyTips => $composableBuilder(
    column: $table.safetyTips,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commonMistakes => $composableBuilder(
    column: $table.commonMistakes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variations => $composableBuilder(
    column: $table.variations,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enrichedOverview => $composableBuilder(
    column: $table.enrichedOverview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get enrichedAt => $composableBuilder(
    column: $table.enrichedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enrichmentSource => $composableBuilder(
    column: $table.enrichmentSource,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseEnrichedContentTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseEnrichedContentTable> {
  $$ExerciseEnrichedContentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get safetyTips => $composableBuilder(
    column: $table.safetyTips,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commonMistakes => $composableBuilder(
    column: $table.commonMistakes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variations => $composableBuilder(
    column: $table.variations,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enrichedOverview => $composableBuilder(
    column: $table.enrichedOverview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get enrichedAt => $composableBuilder(
    column: $table.enrichedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enrichmentSource => $composableBuilder(
    column: $table.enrichmentSource,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseEnrichedContentTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseEnrichedContentTable> {
  $$ExerciseEnrichedContentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get safetyTips => $composableBuilder(
    column: $table.safetyTips,
    builder: (column) => column,
  );

  GeneratedColumn<String> get commonMistakes => $composableBuilder(
    column: $table.commonMistakes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variations => $composableBuilder(
    column: $table.variations,
    builder: (column) => column,
  );

  GeneratedColumn<String> get enrichedOverview => $composableBuilder(
    column: $table.enrichedOverview,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get enrichedAt => $composableBuilder(
    column: $table.enrichedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get enrichmentSource => $composableBuilder(
    column: $table.enrichmentSource,
    builder: (column) => column,
  );

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseEnrichedContentTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseEnrichedContentTable,
          ExerciseEnrichedContentData,
          $$ExerciseEnrichedContentTableFilterComposer,
          $$ExerciseEnrichedContentTableOrderingComposer,
          $$ExerciseEnrichedContentTableAnnotationComposer,
          $$ExerciseEnrichedContentTableCreateCompanionBuilder,
          $$ExerciseEnrichedContentTableUpdateCompanionBuilder,
          (
            ExerciseEnrichedContentData,
            $$ExerciseEnrichedContentTableReferences,
          ),
          ExerciseEnrichedContentData,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$ExerciseEnrichedContentTableTableManager(
    _$AppDatabase db,
    $ExerciseEnrichedContentTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseEnrichedContentTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ExerciseEnrichedContentTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ExerciseEnrichedContentTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> exerciseId = const Value.absent(),
                Value<String?> safetyTips = const Value.absent(),
                Value<String?> commonMistakes = const Value.absent(),
                Value<String?> variations = const Value.absent(),
                Value<String?> enrichedOverview = const Value.absent(),
                Value<DateTime?> enrichedAt = const Value.absent(),
                Value<String?> enrichmentSource = const Value.absent(),
              }) => ExerciseEnrichedContentCompanion(
                exerciseId: exerciseId,
                safetyTips: safetyTips,
                commonMistakes: commonMistakes,
                variations: variations,
                enrichedOverview: enrichedOverview,
                enrichedAt: enrichedAt,
                enrichmentSource: enrichmentSource,
              ),
          createCompanionCallback:
              ({
                Value<int> exerciseId = const Value.absent(),
                Value<String?> safetyTips = const Value.absent(),
                Value<String?> commonMistakes = const Value.absent(),
                Value<String?> variations = const Value.absent(),
                Value<String?> enrichedOverview = const Value.absent(),
                Value<DateTime?> enrichedAt = const Value.absent(),
                Value<String?> enrichmentSource = const Value.absent(),
              }) => ExerciseEnrichedContentCompanion.insert(
                exerciseId: exerciseId,
                safetyTips: safetyTips,
                commonMistakes: commonMistakes,
                variations: variations,
                enrichedOverview: enrichedOverview,
                enrichedAt: enrichedAt,
                enrichmentSource: enrichmentSource,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseEnrichedContentTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$ExerciseEnrichedContentTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$ExerciseEnrichedContentTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseEnrichedContentTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseEnrichedContentTable,
      ExerciseEnrichedContentData,
      $$ExerciseEnrichedContentTableFilterComposer,
      $$ExerciseEnrichedContentTableOrderingComposer,
      $$ExerciseEnrichedContentTableAnnotationComposer,
      $$ExerciseEnrichedContentTableCreateCompanionBuilder,
      $$ExerciseEnrichedContentTableUpdateCompanionBuilder,
      (ExerciseEnrichedContentData, $$ExerciseEnrichedContentTableReferences),
      ExerciseEnrichedContentData,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$RecentExercisesTableCreateCompanionBuilder =
    RecentExercisesCompanion Function({
      Value<int> exerciseId,
      required DateTime viewedAt,
    });
typedef $$RecentExercisesTableUpdateCompanionBuilder =
    RecentExercisesCompanion Function({
      Value<int> exerciseId,
      Value<DateTime> viewedAt,
    });

final class $$RecentExercisesTableReferences
    extends
        BaseReferences<_$AppDatabase, $RecentExercisesTable, RecentExercise> {
  $$RecentExercisesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.recentExercises.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecentExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $RecentExercisesTable> {
  $$RecentExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get viewedAt => $composableBuilder(
    column: $table.viewedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecentExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecentExercisesTable> {
  $$RecentExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get viewedAt => $composableBuilder(
    column: $table.viewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecentExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecentExercisesTable> {
  $$RecentExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get viewedAt =>
      $composableBuilder(column: $table.viewedAt, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecentExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecentExercisesTable,
          RecentExercise,
          $$RecentExercisesTableFilterComposer,
          $$RecentExercisesTableOrderingComposer,
          $$RecentExercisesTableAnnotationComposer,
          $$RecentExercisesTableCreateCompanionBuilder,
          $$RecentExercisesTableUpdateCompanionBuilder,
          (RecentExercise, $$RecentExercisesTableReferences),
          RecentExercise,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$RecentExercisesTableTableManager(
    _$AppDatabase db,
    $RecentExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecentExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecentExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> exerciseId = const Value.absent(),
                Value<DateTime> viewedAt = const Value.absent(),
              }) => RecentExercisesCompanion(
                exerciseId: exerciseId,
                viewedAt: viewedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> exerciseId = const Value.absent(),
                required DateTime viewedAt,
              }) => RecentExercisesCompanion.insert(
                exerciseId: exerciseId,
                viewedAt: viewedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecentExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$RecentExercisesTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$RecentExercisesTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecentExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecentExercisesTable,
      RecentExercise,
      $$RecentExercisesTableFilterComposer,
      $$RecentExercisesTableOrderingComposer,
      $$RecentExercisesTableAnnotationComposer,
      $$RecentExercisesTableCreateCompanionBuilder,
      $$RecentExercisesTableUpdateCompanionBuilder,
      (RecentExercise, $$RecentExercisesTableReferences),
      RecentExercise,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$ExerciseProgressionsTableCreateCompanionBuilder =
    ExerciseProgressionsCompanion Function({
      Value<int> id,
      required int exerciseId,
      required int progressionExerciseId,
      required int position,
    });
typedef $$ExerciseProgressionsTableUpdateCompanionBuilder =
    ExerciseProgressionsCompanion Function({
      Value<int> id,
      Value<int> exerciseId,
      Value<int> progressionExerciseId,
      Value<int> position,
    });

final class $$ExerciseProgressionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseProgressionsTable,
          ExerciseProgression
        > {
  $$ExerciseProgressionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(
          db.exerciseProgressions.exerciseId,
          db.exercises.id,
        ),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExercisesTable _progressionExerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(
          db.exerciseProgressions.progressionExerciseId,
          db.exercises.id,
        ),
      );

  $$ExercisesTableProcessedTableManager get progressionExerciseId {
    final $_column = $_itemColumn<int>('progression_exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _progressionExerciseIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExerciseProgressionsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseProgressionsTable> {
  $$ExerciseProgressionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableFilterComposer get progressionExerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.progressionExerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseProgressionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseProgressionsTable> {
  $$ExerciseProgressionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableOrderingComposer get progressionExerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.progressionExerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseProgressionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseProgressionsTable> {
  $$ExerciseProgressionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableAnnotationComposer get progressionExerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.progressionExerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseProgressionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseProgressionsTable,
          ExerciseProgression,
          $$ExerciseProgressionsTableFilterComposer,
          $$ExerciseProgressionsTableOrderingComposer,
          $$ExerciseProgressionsTableAnnotationComposer,
          $$ExerciseProgressionsTableCreateCompanionBuilder,
          $$ExerciseProgressionsTableUpdateCompanionBuilder,
          (ExerciseProgression, $$ExerciseProgressionsTableReferences),
          ExerciseProgression,
          PrefetchHooks Function({bool exerciseId, bool progressionExerciseId})
        > {
  $$ExerciseProgressionsTableTableManager(
    _$AppDatabase db,
    $ExerciseProgressionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseProgressionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseProgressionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ExerciseProgressionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int> progressionExerciseId = const Value.absent(),
                Value<int> position = const Value.absent(),
              }) => ExerciseProgressionsCompanion(
                id: id,
                exerciseId: exerciseId,
                progressionExerciseId: progressionExerciseId,
                position: position,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int exerciseId,
                required int progressionExerciseId,
                required int position,
              }) => ExerciseProgressionsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                progressionExerciseId: progressionExerciseId,
                position: position,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseProgressionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({exerciseId = false, progressionExerciseId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (exerciseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.exerciseId,
                                    referencedTable:
                                        $$ExerciseProgressionsTableReferences
                                            ._exerciseIdTable(db),
                                    referencedColumn:
                                        $$ExerciseProgressionsTableReferences
                                            ._exerciseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (progressionExerciseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.progressionExerciseId,
                                    referencedTable:
                                        $$ExerciseProgressionsTableReferences
                                            ._progressionExerciseIdTable(db),
                                    referencedColumn:
                                        $$ExerciseProgressionsTableReferences
                                            ._progressionExerciseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ExerciseProgressionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseProgressionsTable,
      ExerciseProgression,
      $$ExerciseProgressionsTableFilterComposer,
      $$ExerciseProgressionsTableOrderingComposer,
      $$ExerciseProgressionsTableAnnotationComposer,
      $$ExerciseProgressionsTableCreateCompanionBuilder,
      $$ExerciseProgressionsTableUpdateCompanionBuilder,
      (ExerciseProgression, $$ExerciseProgressionsTableReferences),
      ExerciseProgression,
      PrefetchHooks Function({bool exerciseId, bool progressionExerciseId})
    >;
typedef $$ExerciseInstructionsTableCreateCompanionBuilder =
    ExerciseInstructionsCompanion Function({
      Value<int> id,
      required int exerciseId,
      required int stepNumber,
      required String instructionText,
    });
typedef $$ExerciseInstructionsTableUpdateCompanionBuilder =
    ExerciseInstructionsCompanion Function({
      Value<int> id,
      Value<int> exerciseId,
      Value<int> stepNumber,
      Value<String> instructionText,
    });

final class $$ExerciseInstructionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseInstructionsTable,
          ExerciseInstruction
        > {
  $$ExerciseInstructionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(
          db.exerciseInstructions.exerciseId,
          db.exercises.id,
        ),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExerciseInstructionsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseInstructionsTable> {
  $$ExerciseInstructionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepNumber => $composableBuilder(
    column: $table.stepNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructionText => $composableBuilder(
    column: $table.instructionText,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseInstructionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseInstructionsTable> {
  $$ExerciseInstructionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepNumber => $composableBuilder(
    column: $table.stepNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructionText => $composableBuilder(
    column: $table.instructionText,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseInstructionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseInstructionsTable> {
  $$ExerciseInstructionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get stepNumber => $composableBuilder(
    column: $table.stepNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructionText => $composableBuilder(
    column: $table.instructionText,
    builder: (column) => column,
  );

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseInstructionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseInstructionsTable,
          ExerciseInstruction,
          $$ExerciseInstructionsTableFilterComposer,
          $$ExerciseInstructionsTableOrderingComposer,
          $$ExerciseInstructionsTableAnnotationComposer,
          $$ExerciseInstructionsTableCreateCompanionBuilder,
          $$ExerciseInstructionsTableUpdateCompanionBuilder,
          (ExerciseInstruction, $$ExerciseInstructionsTableReferences),
          ExerciseInstruction,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$ExerciseInstructionsTableTableManager(
    _$AppDatabase db,
    $ExerciseInstructionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseInstructionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseInstructionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ExerciseInstructionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int> stepNumber = const Value.absent(),
                Value<String> instructionText = const Value.absent(),
              }) => ExerciseInstructionsCompanion(
                id: id,
                exerciseId: exerciseId,
                stepNumber: stepNumber,
                instructionText: instructionText,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int exerciseId,
                required int stepNumber,
                required String instructionText,
              }) => ExerciseInstructionsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                stepNumber: stepNumber,
                instructionText: instructionText,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseInstructionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$ExerciseInstructionsTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$ExerciseInstructionsTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseInstructionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseInstructionsTable,
      ExerciseInstruction,
      $$ExerciseInstructionsTableFilterComposer,
      $$ExerciseInstructionsTableOrderingComposer,
      $$ExerciseInstructionsTableAnnotationComposer,
      $$ExerciseInstructionsTableCreateCompanionBuilder,
      $$ExerciseInstructionsTableUpdateCompanionBuilder,
      (ExerciseInstruction, $$ExerciseInstructionsTableReferences),
      ExerciseInstruction,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$ExerciseMuscleMapTableCreateCompanionBuilder =
    ExerciseMuscleMapCompanion Function({
      Value<int> id,
      required int exerciseId,
      required String primaryMuscle,
      Value<String?> secondaryMuscle,
    });
typedef $$ExerciseMuscleMapTableUpdateCompanionBuilder =
    ExerciseMuscleMapCompanion Function({
      Value<int> id,
      Value<int> exerciseId,
      Value<String> primaryMuscle,
      Value<String?> secondaryMuscle,
    });

final class $$ExerciseMuscleMapTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseMuscleMapTable,
          ExerciseMuscleMapData
        > {
  $$ExerciseMuscleMapTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.exerciseMuscleMap.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExerciseMuscleMapTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseMuscleMapTable> {
  $$ExerciseMuscleMapTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryMuscle => $composableBuilder(
    column: $table.primaryMuscle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryMuscle => $composableBuilder(
    column: $table.secondaryMuscle,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseMuscleMapTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseMuscleMapTable> {
  $$ExerciseMuscleMapTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryMuscle => $composableBuilder(
    column: $table.primaryMuscle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryMuscle => $composableBuilder(
    column: $table.secondaryMuscle,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseMuscleMapTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseMuscleMapTable> {
  $$ExerciseMuscleMapTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get primaryMuscle => $composableBuilder(
    column: $table.primaryMuscle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryMuscle => $composableBuilder(
    column: $table.secondaryMuscle,
    builder: (column) => column,
  );

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseMuscleMapTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseMuscleMapTable,
          ExerciseMuscleMapData,
          $$ExerciseMuscleMapTableFilterComposer,
          $$ExerciseMuscleMapTableOrderingComposer,
          $$ExerciseMuscleMapTableAnnotationComposer,
          $$ExerciseMuscleMapTableCreateCompanionBuilder,
          $$ExerciseMuscleMapTableUpdateCompanionBuilder,
          (ExerciseMuscleMapData, $$ExerciseMuscleMapTableReferences),
          ExerciseMuscleMapData,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$ExerciseMuscleMapTableTableManager(
    _$AppDatabase db,
    $ExerciseMuscleMapTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseMuscleMapTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseMuscleMapTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseMuscleMapTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<String> primaryMuscle = const Value.absent(),
                Value<String?> secondaryMuscle = const Value.absent(),
              }) => ExerciseMuscleMapCompanion(
                id: id,
                exerciseId: exerciseId,
                primaryMuscle: primaryMuscle,
                secondaryMuscle: secondaryMuscle,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int exerciseId,
                required String primaryMuscle,
                Value<String?> secondaryMuscle = const Value.absent(),
              }) => ExerciseMuscleMapCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                primaryMuscle: primaryMuscle,
                secondaryMuscle: secondaryMuscle,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseMuscleMapTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$ExerciseMuscleMapTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$ExerciseMuscleMapTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseMuscleMapTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseMuscleMapTable,
      ExerciseMuscleMapData,
      $$ExerciseMuscleMapTableFilterComposer,
      $$ExerciseMuscleMapTableOrderingComposer,
      $$ExerciseMuscleMapTableAnnotationComposer,
      $$ExerciseMuscleMapTableCreateCompanionBuilder,
      $$ExerciseMuscleMapTableUpdateCompanionBuilder,
      (ExerciseMuscleMapData, $$ExerciseMuscleMapTableReferences),
      ExerciseMuscleMapData,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$MesocycleExercisesTableCreateCompanionBuilder =
    MesocycleExercisesCompanion Function({
      Value<int> id,
      required int mesocycleDayId,
      required int exerciseId,
      required int exerciseOrder,
      required int targetSets,
      required int minReps,
      required int maxReps,
      Value<double?> targetRpe,
      Value<String> progressionType,
      Value<double?> progressionValue,
      Value<String?> notes,
    });
typedef $$MesocycleExercisesTableUpdateCompanionBuilder =
    MesocycleExercisesCompanion Function({
      Value<int> id,
      Value<int> mesocycleDayId,
      Value<int> exerciseId,
      Value<int> exerciseOrder,
      Value<int> targetSets,
      Value<int> minReps,
      Value<int> maxReps,
      Value<double?> targetRpe,
      Value<String> progressionType,
      Value<double?> progressionValue,
      Value<String?> notes,
    });

final class $$MesocycleExercisesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MesocycleExercisesTable,
          MesocycleExercise
        > {
  $$MesocycleExercisesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MesocycleDaysTable _mesocycleDayIdTable(_$AppDatabase db) =>
      db.mesocycleDays.createAlias(
        $_aliasNameGenerator(
          db.mesocycleExercises.mesocycleDayId,
          db.mesocycleDays.id,
        ),
      );

  $$MesocycleDaysTableProcessedTableManager get mesocycleDayId {
    final $_column = $_itemColumn<int>('mesocycle_day_id')!;

    final manager = $$MesocycleDaysTableTableManager(
      $_db,
      $_db.mesocycleDays,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mesocycleDayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.mesocycleExercises.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MesocycleExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $MesocycleExercisesTable> {
  $$MesocycleExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exerciseOrder => $composableBuilder(
    column: $table.exerciseOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minReps => $composableBuilder(
    column: $table.minReps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxReps => $composableBuilder(
    column: $table.maxReps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetRpe => $composableBuilder(
    column: $table.targetRpe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get progressionType => $composableBuilder(
    column: $table.progressionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progressionValue => $composableBuilder(
    column: $table.progressionValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$MesocycleDaysTableFilterComposer get mesocycleDayId {
    final $$MesocycleDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleDayId,
      referencedTable: $db.mesocycleDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleDaysTableFilterComposer(
            $db: $db,
            $table: $db.mesocycleDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MesocycleExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $MesocycleExercisesTable> {
  $$MesocycleExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exerciseOrder => $composableBuilder(
    column: $table.exerciseOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minReps => $composableBuilder(
    column: $table.minReps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxReps => $composableBuilder(
    column: $table.maxReps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetRpe => $composableBuilder(
    column: $table.targetRpe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get progressionType => $composableBuilder(
    column: $table.progressionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progressionValue => $composableBuilder(
    column: $table.progressionValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$MesocycleDaysTableOrderingComposer get mesocycleDayId {
    final $$MesocycleDaysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleDayId,
      referencedTable: $db.mesocycleDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleDaysTableOrderingComposer(
            $db: $db,
            $table: $db.mesocycleDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MesocycleExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MesocycleExercisesTable> {
  $$MesocycleExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get exerciseOrder => $composableBuilder(
    column: $table.exerciseOrder,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minReps =>
      $composableBuilder(column: $table.minReps, builder: (column) => column);

  GeneratedColumn<int> get maxReps =>
      $composableBuilder(column: $table.maxReps, builder: (column) => column);

  GeneratedColumn<double> get targetRpe =>
      $composableBuilder(column: $table.targetRpe, builder: (column) => column);

  GeneratedColumn<String> get progressionType => $composableBuilder(
    column: $table.progressionType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get progressionValue => $composableBuilder(
    column: $table.progressionValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$MesocycleDaysTableAnnotationComposer get mesocycleDayId {
    final $$MesocycleDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleDayId,
      referencedTable: $db.mesocycleDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocycleDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.mesocycleDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MesocycleExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MesocycleExercisesTable,
          MesocycleExercise,
          $$MesocycleExercisesTableFilterComposer,
          $$MesocycleExercisesTableOrderingComposer,
          $$MesocycleExercisesTableAnnotationComposer,
          $$MesocycleExercisesTableCreateCompanionBuilder,
          $$MesocycleExercisesTableUpdateCompanionBuilder,
          (MesocycleExercise, $$MesocycleExercisesTableReferences),
          MesocycleExercise,
          PrefetchHooks Function({bool mesocycleDayId, bool exerciseId})
        > {
  $$MesocycleExercisesTableTableManager(
    _$AppDatabase db,
    $MesocycleExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MesocycleExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MesocycleExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MesocycleExercisesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mesocycleDayId = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int> exerciseOrder = const Value.absent(),
                Value<int> targetSets = const Value.absent(),
                Value<int> minReps = const Value.absent(),
                Value<int> maxReps = const Value.absent(),
                Value<double?> targetRpe = const Value.absent(),
                Value<String> progressionType = const Value.absent(),
                Value<double?> progressionValue = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MesocycleExercisesCompanion(
                id: id,
                mesocycleDayId: mesocycleDayId,
                exerciseId: exerciseId,
                exerciseOrder: exerciseOrder,
                targetSets: targetSets,
                minReps: minReps,
                maxReps: maxReps,
                targetRpe: targetRpe,
                progressionType: progressionType,
                progressionValue: progressionValue,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mesocycleDayId,
                required int exerciseId,
                required int exerciseOrder,
                required int targetSets,
                required int minReps,
                required int maxReps,
                Value<double?> targetRpe = const Value.absent(),
                Value<String> progressionType = const Value.absent(),
                Value<double?> progressionValue = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MesocycleExercisesCompanion.insert(
                id: id,
                mesocycleDayId: mesocycleDayId,
                exerciseId: exerciseId,
                exerciseOrder: exerciseOrder,
                targetSets: targetSets,
                minReps: minReps,
                maxReps: maxReps,
                targetRpe: targetRpe,
                progressionType: progressionType,
                progressionValue: progressionValue,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MesocycleExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({mesocycleDayId = false, exerciseId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (mesocycleDayId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mesocycleDayId,
                                    referencedTable:
                                        $$MesocycleExercisesTableReferences
                                            ._mesocycleDayIdTable(db),
                                    referencedColumn:
                                        $$MesocycleExercisesTableReferences
                                            ._mesocycleDayIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (exerciseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.exerciseId,
                                    referencedTable:
                                        $$MesocycleExercisesTableReferences
                                            ._exerciseIdTable(db),
                                    referencedColumn:
                                        $$MesocycleExercisesTableReferences
                                            ._exerciseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$MesocycleExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MesocycleExercisesTable,
      MesocycleExercise,
      $$MesocycleExercisesTableFilterComposer,
      $$MesocycleExercisesTableOrderingComposer,
      $$MesocycleExercisesTableAnnotationComposer,
      $$MesocycleExercisesTableCreateCompanionBuilder,
      $$MesocycleExercisesTableUpdateCompanionBuilder,
      (MesocycleExercise, $$MesocycleExercisesTableReferences),
      MesocycleExercise,
      PrefetchHooks Function({bool mesocycleDayId, bool exerciseId})
    >;
typedef $$UserProgramProgressTableCreateCompanionBuilder =
    UserProgramProgressCompanion Function({
      Value<int> id,
      required int mesocycleId,
      required DateTime startDate,
      Value<int> currentPhaseIndex,
      Value<bool> isCompleted,
      Value<DateTime?> lastPhaseAlertAt,
    });
typedef $$UserProgramProgressTableUpdateCompanionBuilder =
    UserProgramProgressCompanion Function({
      Value<int> id,
      Value<int> mesocycleId,
      Value<DateTime> startDate,
      Value<int> currentPhaseIndex,
      Value<bool> isCompleted,
      Value<DateTime?> lastPhaseAlertAt,
    });

final class $$UserProgramProgressTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserProgramProgressTable,
          UserProgramProgressData
        > {
  $$UserProgramProgressTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MesocyclesTable _mesocycleIdTable(_$AppDatabase db) =>
      db.mesocycles.createAlias(
        $_aliasNameGenerator(
          db.userProgramProgress.mesocycleId,
          db.mesocycles.id,
        ),
      );

  $$MesocyclesTableProcessedTableManager get mesocycleId {
    final $_column = $_itemColumn<int>('mesocycle_id')!;

    final manager = $$MesocyclesTableTableManager(
      $_db,
      $_db.mesocycles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mesocycleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserProgramProgressTableFilterComposer
    extends Composer<_$AppDatabase, $UserProgramProgressTable> {
  $$UserProgramProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentPhaseIndex => $composableBuilder(
    column: $table.currentPhaseIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPhaseAlertAt => $composableBuilder(
    column: $table.lastPhaseAlertAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MesocyclesTableFilterComposer get mesocycleId {
    final $$MesocyclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleId,
      referencedTable: $db.mesocycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocyclesTableFilterComposer(
            $db: $db,
            $table: $db.mesocycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProgramProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProgramProgressTable> {
  $$UserProgramProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentPhaseIndex => $composableBuilder(
    column: $table.currentPhaseIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPhaseAlertAt => $composableBuilder(
    column: $table.lastPhaseAlertAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MesocyclesTableOrderingComposer get mesocycleId {
    final $$MesocyclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleId,
      referencedTable: $db.mesocycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocyclesTableOrderingComposer(
            $db: $db,
            $table: $db.mesocycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProgramProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProgramProgressTable> {
  $$UserProgramProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get currentPhaseIndex => $composableBuilder(
    column: $table.currentPhaseIndex,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastPhaseAlertAt => $composableBuilder(
    column: $table.lastPhaseAlertAt,
    builder: (column) => column,
  );

  $$MesocyclesTableAnnotationComposer get mesocycleId {
    final $$MesocyclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mesocycleId,
      referencedTable: $db.mesocycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MesocyclesTableAnnotationComposer(
            $db: $db,
            $table: $db.mesocycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProgramProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProgramProgressTable,
          UserProgramProgressData,
          $$UserProgramProgressTableFilterComposer,
          $$UserProgramProgressTableOrderingComposer,
          $$UserProgramProgressTableAnnotationComposer,
          $$UserProgramProgressTableCreateCompanionBuilder,
          $$UserProgramProgressTableUpdateCompanionBuilder,
          (UserProgramProgressData, $$UserProgramProgressTableReferences),
          UserProgramProgressData,
          PrefetchHooks Function({bool mesocycleId})
        > {
  $$UserProgramProgressTableTableManager(
    _$AppDatabase db,
    $UserProgramProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProgramProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProgramProgressTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserProgramProgressTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mesocycleId = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<int> currentPhaseIndex = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> lastPhaseAlertAt = const Value.absent(),
              }) => UserProgramProgressCompanion(
                id: id,
                mesocycleId: mesocycleId,
                startDate: startDate,
                currentPhaseIndex: currentPhaseIndex,
                isCompleted: isCompleted,
                lastPhaseAlertAt: lastPhaseAlertAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mesocycleId,
                required DateTime startDate,
                Value<int> currentPhaseIndex = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> lastPhaseAlertAt = const Value.absent(),
              }) => UserProgramProgressCompanion.insert(
                id: id,
                mesocycleId: mesocycleId,
                startDate: startDate,
                currentPhaseIndex: currentPhaseIndex,
                isCompleted: isCompleted,
                lastPhaseAlertAt: lastPhaseAlertAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserProgramProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mesocycleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (mesocycleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mesocycleId,
                                referencedTable:
                                    $$UserProgramProgressTableReferences
                                        ._mesocycleIdTable(db),
                                referencedColumn:
                                    $$UserProgramProgressTableReferences
                                        ._mesocycleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserProgramProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProgramProgressTable,
      UserProgramProgressData,
      $$UserProgramProgressTableFilterComposer,
      $$UserProgramProgressTableOrderingComposer,
      $$UserProgramProgressTableAnnotationComposer,
      $$UserProgramProgressTableCreateCompanionBuilder,
      $$UserProgramProgressTableUpdateCompanionBuilder,
      (UserProgramProgressData, $$UserProgramProgressTableReferences),
      UserProgramProgressData,
      PrefetchHooks Function({bool mesocycleId})
    >;
typedef $$Exercise1RmSnapshotsTableCreateCompanionBuilder =
    Exercise1RmSnapshotsCompanion Function({
      Value<int> id,
      required int exerciseId,
      Value<int?> workoutId,
      required DateTime date,
      required double weight,
      required double reps,
      required double estimated1Rm,
      required String formula,
      Value<bool> isPr,
    });
typedef $$Exercise1RmSnapshotsTableUpdateCompanionBuilder =
    Exercise1RmSnapshotsCompanion Function({
      Value<int> id,
      Value<int> exerciseId,
      Value<int?> workoutId,
      Value<DateTime> date,
      Value<double> weight,
      Value<double> reps,
      Value<double> estimated1Rm,
      Value<String> formula,
      Value<bool> isPr,
    });

final class $$Exercise1RmSnapshotsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $Exercise1RmSnapshotsTable,
          Exercise1RmSnapshot
        > {
  $$Exercise1RmSnapshotsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(
          db.exercise1RmSnapshots.exerciseId,
          db.exercises.id,
        ),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WorkoutsTable _workoutIdTable(_$AppDatabase db) =>
      db.workouts.createAlias(
        $_aliasNameGenerator(db.exercise1RmSnapshots.workoutId, db.workouts.id),
      );

  $$WorkoutsTableProcessedTableManager? get workoutId {
    final $_column = $_itemColumn<int>('workout_id');
    if ($_column == null) return null;
    final manager = $$WorkoutsTableTableManager(
      $_db,
      $_db.workouts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$Exercise1RmSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $Exercise1RmSnapshotsTable> {
  $$Exercise1RmSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimated1Rm => $composableBuilder(
    column: $table.estimated1Rm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formula => $composableBuilder(
    column: $table.formula,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPr => $composableBuilder(
    column: $table.isPr,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WorkoutsTableFilterComposer get workoutId {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutId,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableFilterComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$Exercise1RmSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $Exercise1RmSnapshotsTable> {
  $$Exercise1RmSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimated1Rm => $composableBuilder(
    column: $table.estimated1Rm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formula => $composableBuilder(
    column: $table.formula,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPr => $composableBuilder(
    column: $table.isPr,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WorkoutsTableOrderingComposer get workoutId {
    final $$WorkoutsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutId,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableOrderingComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$Exercise1RmSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $Exercise1RmSnapshotsTable> {
  $$Exercise1RmSnapshotsTableAnnotationComposer({
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

  GeneratedColumn<double> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get estimated1Rm => $composableBuilder(
    column: $table.estimated1Rm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get formula =>
      $composableBuilder(column: $table.formula, builder: (column) => column);

  GeneratedColumn<bool> get isPr =>
      $composableBuilder(column: $table.isPr, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WorkoutsTableAnnotationComposer get workoutId {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutId,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableAnnotationComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$Exercise1RmSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $Exercise1RmSnapshotsTable,
          Exercise1RmSnapshot,
          $$Exercise1RmSnapshotsTableFilterComposer,
          $$Exercise1RmSnapshotsTableOrderingComposer,
          $$Exercise1RmSnapshotsTableAnnotationComposer,
          $$Exercise1RmSnapshotsTableCreateCompanionBuilder,
          $$Exercise1RmSnapshotsTableUpdateCompanionBuilder,
          (Exercise1RmSnapshot, $$Exercise1RmSnapshotsTableReferences),
          Exercise1RmSnapshot,
          PrefetchHooks Function({bool exerciseId, bool workoutId})
        > {
  $$Exercise1RmSnapshotsTableTableManager(
    _$AppDatabase db,
    $Exercise1RmSnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$Exercise1RmSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$Exercise1RmSnapshotsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$Exercise1RmSnapshotsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int?> workoutId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<double> reps = const Value.absent(),
                Value<double> estimated1Rm = const Value.absent(),
                Value<String> formula = const Value.absent(),
                Value<bool> isPr = const Value.absent(),
              }) => Exercise1RmSnapshotsCompanion(
                id: id,
                exerciseId: exerciseId,
                workoutId: workoutId,
                date: date,
                weight: weight,
                reps: reps,
                estimated1Rm: estimated1Rm,
                formula: formula,
                isPr: isPr,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int exerciseId,
                Value<int?> workoutId = const Value.absent(),
                required DateTime date,
                required double weight,
                required double reps,
                required double estimated1Rm,
                required String formula,
                Value<bool> isPr = const Value.absent(),
              }) => Exercise1RmSnapshotsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                workoutId: workoutId,
                date: date,
                weight: weight,
                reps: reps,
                estimated1Rm: estimated1Rm,
                formula: formula,
                isPr: isPr,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$Exercise1RmSnapshotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false, workoutId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$Exercise1RmSnapshotsTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$Exercise1RmSnapshotsTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (workoutId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workoutId,
                                referencedTable:
                                    $$Exercise1RmSnapshotsTableReferences
                                        ._workoutIdTable(db),
                                referencedColumn:
                                    $$Exercise1RmSnapshotsTableReferences
                                        ._workoutIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$Exercise1RmSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $Exercise1RmSnapshotsTable,
      Exercise1RmSnapshot,
      $$Exercise1RmSnapshotsTableFilterComposer,
      $$Exercise1RmSnapshotsTableOrderingComposer,
      $$Exercise1RmSnapshotsTableAnnotationComposer,
      $$Exercise1RmSnapshotsTableCreateCompanionBuilder,
      $$Exercise1RmSnapshotsTableUpdateCompanionBuilder,
      (Exercise1RmSnapshot, $$Exercise1RmSnapshotsTableReferences),
      Exercise1RmSnapshot,
      PrefetchHooks Function({bool exerciseId, bool workoutId})
    >;

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
  $$MesocyclesTableTableManager get mesocycles =>
      $$MesocyclesTableTableManager(_db, _db.mesocycles);
  $$MesocycleWeeksTableTableManager get mesocycleWeeks =>
      $$MesocycleWeeksTableTableManager(_db, _db.mesocycleWeeks);
  $$MesocycleDaysTableTableManager get mesocycleDays =>
      $$MesocycleDaysTableTableManager(_db, _db.mesocycleDays);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$WorkoutSetsTableTableManager get workoutSets =>
      $$WorkoutSetsTableTableManager(_db, _db.workoutSets);
  $$BodyMeasurementsTableTableManager get bodyMeasurements =>
      $$BodyMeasurementsTableTableManager(_db, _db.bodyMeasurements);
  $$BodyTargetsTableTableManager get bodyTargets =>
      $$BodyTargetsTableTableManager(_db, _db.bodyTargets);
  $$ProgressPhotosTableTableManager get progressPhotos =>
      $$ProgressPhotosTableTableManager(_db, _db.progressPhotos);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$ExerciseProgressionSettingsTableTableManager
  get exerciseProgressionSettings =>
      $$ExerciseProgressionSettingsTableTableManager(
        _db,
        _db.exerciseProgressionSettings,
      );
  $$ExerciseMusclesTableTableManager get exerciseMuscles =>
      $$ExerciseMusclesTableTableManager(_db, _db.exerciseMuscles);
  $$ExerciseBodyPartsTableTableManager get exerciseBodyParts =>
      $$ExerciseBodyPartsTableTableManager(_db, _db.exerciseBodyParts);
  $$ExerciseEnrichedContentTableTableManager get exerciseEnrichedContent =>
      $$ExerciseEnrichedContentTableTableManager(
        _db,
        _db.exerciseEnrichedContent,
      );
  $$RecentExercisesTableTableManager get recentExercises =>
      $$RecentExercisesTableTableManager(_db, _db.recentExercises);
  $$ExerciseProgressionsTableTableManager get exerciseProgressions =>
      $$ExerciseProgressionsTableTableManager(_db, _db.exerciseProgressions);
  $$ExerciseInstructionsTableTableManager get exerciseInstructions =>
      $$ExerciseInstructionsTableTableManager(_db, _db.exerciseInstructions);
  $$ExerciseMuscleMapTableTableManager get exerciseMuscleMap =>
      $$ExerciseMuscleMapTableTableManager(_db, _db.exerciseMuscleMap);
  $$MesocycleExercisesTableTableManager get mesocycleExercises =>
      $$MesocycleExercisesTableTableManager(_db, _db.mesocycleExercises);
  $$UserProgramProgressTableTableManager get userProgramProgress =>
      $$UserProgramProgressTableTableManager(_db, _db.userProgramProgress);
  $$Exercise1RmSnapshotsTableTableManager get exercise1RmSnapshots =>
      $$Exercise1RmSnapshotsTableTableManager(_db, _db.exercise1RmSnapshots);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'8c69eb46d45206533c176c88a926608e79ca927d';
