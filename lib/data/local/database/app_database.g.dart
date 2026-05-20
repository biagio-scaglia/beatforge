// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AudioTracksTable extends AudioTracks
    with TableInfo<$AudioTracksTable, AudioTrack> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AudioTracksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extensionMeta = const VerificationMeta(
    'extension',
  );
  @override
  late final GeneratedColumn<String> extension = GeneratedColumn<String>(
    'extension',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _webStorageKeyMeta = const VerificationMeta(
    'webStorageKey',
  );
  @override
  late final GeneratedColumn<String> webStorageKey = GeneratedColumn<String>(
    'web_storage_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    fileName,
    extension,
    mimeType,
    sizeBytes,
    localPath,
    webStorageKey,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audio_tracks';
  @override
  VerificationContext validateIntegrity(
    Insertable<AudioTrack> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('extension')) {
      context.handle(
        _extensionMeta,
        extension.isAcceptableOrUnknown(data['extension']!, _extensionMeta),
      );
    } else if (isInserting) {
      context.missing(_extensionMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('web_storage_key')) {
      context.handle(
        _webStorageKeyMeta,
        webStorageKey.isAcceptableOrUnknown(
          data['web_storage_key']!,
          _webStorageKeyMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AudioTrack map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AudioTrack(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      extension: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extension'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      webStorageKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}web_storage_key'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AudioTracksTable createAlias(String alias) {
    return $AudioTracksTable(attachedDatabase, alias);
  }
}

class AudioTrack extends DataClass implements Insertable<AudioTrack> {
  final int id;
  final String displayName;
  final String fileName;
  final String extension;
  final String? mimeType;
  final int sizeBytes;
  final String? localPath;
  final String? webStorageKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AudioTrack({
    required this.id,
    required this.displayName,
    required this.fileName,
    required this.extension,
    this.mimeType,
    required this.sizeBytes,
    this.localPath,
    this.webStorageKey,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['display_name'] = Variable<String>(displayName);
    map['file_name'] = Variable<String>(fileName);
    map['extension'] = Variable<String>(extension);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    map['size_bytes'] = Variable<int>(sizeBytes);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || webStorageKey != null) {
      map['web_storage_key'] = Variable<String>(webStorageKey);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AudioTracksCompanion toCompanion(bool nullToAbsent) {
    return AudioTracksCompanion(
      id: Value(id),
      displayName: Value(displayName),
      fileName: Value(fileName),
      extension: Value(extension),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      sizeBytes: Value(sizeBytes),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      webStorageKey: webStorageKey == null && nullToAbsent
          ? const Value.absent()
          : Value(webStorageKey),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AudioTrack.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AudioTrack(
      id: serializer.fromJson<int>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      fileName: serializer.fromJson<String>(json['fileName']),
      extension: serializer.fromJson<String>(json['extension']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      webStorageKey: serializer.fromJson<String?>(json['webStorageKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String>(displayName),
      'fileName': serializer.toJson<String>(fileName),
      'extension': serializer.toJson<String>(extension),
      'mimeType': serializer.toJson<String?>(mimeType),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'localPath': serializer.toJson<String?>(localPath),
      'webStorageKey': serializer.toJson<String?>(webStorageKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AudioTrack copyWith({
    int? id,
    String? displayName,
    String? fileName,
    String? extension,
    Value<String?> mimeType = const Value.absent(),
    int? sizeBytes,
    Value<String?> localPath = const Value.absent(),
    Value<String?> webStorageKey = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AudioTrack(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    fileName: fileName ?? this.fileName,
    extension: extension ?? this.extension,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    localPath: localPath.present ? localPath.value : this.localPath,
    webStorageKey: webStorageKey.present
        ? webStorageKey.value
        : this.webStorageKey,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AudioTrack copyWithCompanion(AudioTracksCompanion data) {
    return AudioTrack(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      extension: data.extension.present ? data.extension.value : this.extension,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      webStorageKey: data.webStorageKey.present
          ? data.webStorageKey.value
          : this.webStorageKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AudioTrack(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('fileName: $fileName, ')
          ..write('extension: $extension, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('localPath: $localPath, ')
          ..write('webStorageKey: $webStorageKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    fileName,
    extension,
    mimeType,
    sizeBytes,
    localPath,
    webStorageKey,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AudioTrack &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.fileName == this.fileName &&
          other.extension == this.extension &&
          other.mimeType == this.mimeType &&
          other.sizeBytes == this.sizeBytes &&
          other.localPath == this.localPath &&
          other.webStorageKey == this.webStorageKey &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AudioTracksCompanion extends UpdateCompanion<AudioTrack> {
  final Value<int> id;
  final Value<String> displayName;
  final Value<String> fileName;
  final Value<String> extension;
  final Value<String?> mimeType;
  final Value<int> sizeBytes;
  final Value<String?> localPath;
  final Value<String?> webStorageKey;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AudioTracksCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.fileName = const Value.absent(),
    this.extension = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.localPath = const Value.absent(),
    this.webStorageKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AudioTracksCompanion.insert({
    this.id = const Value.absent(),
    required String displayName,
    required String fileName,
    required String extension,
    this.mimeType = const Value.absent(),
    required int sizeBytes,
    this.localPath = const Value.absent(),
    this.webStorageKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : displayName = Value(displayName),
       fileName = Value(fileName),
       extension = Value(extension),
       sizeBytes = Value(sizeBytes);
  static Insertable<AudioTrack> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<String>? fileName,
    Expression<String>? extension,
    Expression<String>? mimeType,
    Expression<int>? sizeBytes,
    Expression<String>? localPath,
    Expression<String>? webStorageKey,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (fileName != null) 'file_name': fileName,
      if (extension != null) 'extension': extension,
      if (mimeType != null) 'mime_type': mimeType,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (localPath != null) 'local_path': localPath,
      if (webStorageKey != null) 'web_storage_key': webStorageKey,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AudioTracksCompanion copyWith({
    Value<int>? id,
    Value<String>? displayName,
    Value<String>? fileName,
    Value<String>? extension,
    Value<String?>? mimeType,
    Value<int>? sizeBytes,
    Value<String?>? localPath,
    Value<String?>? webStorageKey,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return AudioTracksCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      fileName: fileName ?? this.fileName,
      extension: extension ?? this.extension,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      localPath: localPath ?? this.localPath,
      webStorageKey: webStorageKey ?? this.webStorageKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (extension.present) {
      map['extension'] = Variable<String>(extension.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (webStorageKey.present) {
      map['web_storage_key'] = Variable<String>(webStorageKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AudioTracksCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('fileName: $fileName, ')
          ..write('extension: $extension, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('localPath: $localPath, ')
          ..write('webStorageKey: $webStorageKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TrackCategoriesTable extends TrackCategories
    with TableInfo<$TrackCategoriesTable, TrackCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackCategoriesTable(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, colorValue, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackCategory> instance, {
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
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrackCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TrackCategoriesTable createAlias(String alias) {
    return $TrackCategoriesTable(attachedDatabase, alias);
  }
}

class TrackCategory extends DataClass implements Insertable<TrackCategory> {
  final int id;
  final String name;
  final int? colorValue;
  final DateTime createdAt;
  const TrackCategory({
    required this.id,
    required this.name,
    this.colorValue,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TrackCategoriesCompanion toCompanion(bool nullToAbsent) {
    return TrackCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
      createdAt: Value(createdAt),
    );
  }

  factory TrackCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackCategory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'colorValue': serializer.toJson<int?>(colorValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TrackCategory copyWith({
    int? id,
    String? name,
    Value<int?> colorValue = const Value.absent(),
    DateTime? createdAt,
  }) => TrackCategory(
    id: id ?? this.id,
    name: name ?? this.name,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
    createdAt: createdAt ?? this.createdAt,
  );
  TrackCategory copyWithCompanion(TrackCategoriesCompanion data) {
    return TrackCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, colorValue, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorValue == this.colorValue &&
          other.createdAt == this.createdAt);
}

class TrackCategoriesCompanion extends UpdateCompanion<TrackCategory> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> colorValue;
  final Value<DateTime> createdAt;
  const TrackCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TrackCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.colorValue = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<TrackCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? colorValue,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorValue != null) 'color_value': colorValue,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TrackCategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int?>? colorValue,
    Value<DateTime>? createdAt,
  }) {
    return TrackCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      createdAt: createdAt ?? this.createdAt,
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
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TrackCategoryLinksTable extends TrackCategoryLinks
    with TableInfo<$TrackCategoryLinksTable, TrackCategoryLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackCategoryLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES audio_tracks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES track_categories (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [trackId, categoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_category_links';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackCategoryLink> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {trackId, categoryId};
  @override
  TrackCategoryLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackCategoryLink(
      trackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
    );
  }

  @override
  $TrackCategoryLinksTable createAlias(String alias) {
    return $TrackCategoryLinksTable(attachedDatabase, alias);
  }
}

class TrackCategoryLink extends DataClass
    implements Insertable<TrackCategoryLink> {
  final int trackId;
  final int categoryId;
  const TrackCategoryLink({required this.trackId, required this.categoryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['track_id'] = Variable<int>(trackId);
    map['category_id'] = Variable<int>(categoryId);
    return map;
  }

  TrackCategoryLinksCompanion toCompanion(bool nullToAbsent) {
    return TrackCategoryLinksCompanion(
      trackId: Value(trackId),
      categoryId: Value(categoryId),
    );
  }

  factory TrackCategoryLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackCategoryLink(
      trackId: serializer.fromJson<int>(json['trackId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'trackId': serializer.toJson<int>(trackId),
      'categoryId': serializer.toJson<int>(categoryId),
    };
  }

  TrackCategoryLink copyWith({int? trackId, int? categoryId}) =>
      TrackCategoryLink(
        trackId: trackId ?? this.trackId,
        categoryId: categoryId ?? this.categoryId,
      );
  TrackCategoryLink copyWithCompanion(TrackCategoryLinksCompanion data) {
    return TrackCategoryLink(
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackCategoryLink(')
          ..write('trackId: $trackId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(trackId, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackCategoryLink &&
          other.trackId == this.trackId &&
          other.categoryId == this.categoryId);
}

class TrackCategoryLinksCompanion extends UpdateCompanion<TrackCategoryLink> {
  final Value<int> trackId;
  final Value<int> categoryId;
  final Value<int> rowid;
  const TrackCategoryLinksCompanion({
    this.trackId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrackCategoryLinksCompanion.insert({
    required int trackId,
    required int categoryId,
    this.rowid = const Value.absent(),
  }) : trackId = Value(trackId),
       categoryId = Value(categoryId);
  static Insertable<TrackCategoryLink> custom({
    Expression<int>? trackId,
    Expression<int>? categoryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (trackId != null) 'track_id': trackId,
      if (categoryId != null) 'category_id': categoryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrackCategoryLinksCompanion copyWith({
    Value<int>? trackId,
    Value<int>? categoryId,
    Value<int>? rowid,
  }) {
    return TrackCategoryLinksCompanion(
      trackId: trackId ?? this.trackId,
      categoryId: categoryId ?? this.categoryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackCategoryLinksCompanion(')
          ..write('trackId: $trackId, ')
          ..write('categoryId: $categoryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AudioTrackDataTable extends AudioTrackData
    with TableInfo<$AudioTrackDataTable, AudioTrackDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AudioTrackDataTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES audio_tracks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _bytesMeta = const VerificationMeta('bytes');
  @override
  late final GeneratedColumn<Uint8List> bytes = GeneratedColumn<Uint8List>(
    'bytes',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, trackId, bytes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audio_track_data';
  @override
  VerificationContext validateIntegrity(
    Insertable<AudioTrackDataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('bytes')) {
      context.handle(
        _bytesMeta,
        bytes.isAcceptableOrUnknown(data['bytes']!, _bytesMeta),
      );
    } else if (isInserting) {
      context.missing(_bytesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AudioTrackDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AudioTrackDataData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      trackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_id'],
      )!,
      bytes: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}bytes'],
      )!,
    );
  }

  @override
  $AudioTrackDataTable createAlias(String alias) {
    return $AudioTrackDataTable(attachedDatabase, alias);
  }
}

class AudioTrackDataData extends DataClass
    implements Insertable<AudioTrackDataData> {
  final int id;
  final int trackId;
  final Uint8List bytes;
  const AudioTrackDataData({
    required this.id,
    required this.trackId,
    required this.bytes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['track_id'] = Variable<int>(trackId);
    map['bytes'] = Variable<Uint8List>(bytes);
    return map;
  }

  AudioTrackDataCompanion toCompanion(bool nullToAbsent) {
    return AudioTrackDataCompanion(
      id: Value(id),
      trackId: Value(trackId),
      bytes: Value(bytes),
    );
  }

  factory AudioTrackDataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AudioTrackDataData(
      id: serializer.fromJson<int>(json['id']),
      trackId: serializer.fromJson<int>(json['trackId']),
      bytes: serializer.fromJson<Uint8List>(json['bytes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trackId': serializer.toJson<int>(trackId),
      'bytes': serializer.toJson<Uint8List>(bytes),
    };
  }

  AudioTrackDataData copyWith({int? id, int? trackId, Uint8List? bytes}) =>
      AudioTrackDataData(
        id: id ?? this.id,
        trackId: trackId ?? this.trackId,
        bytes: bytes ?? this.bytes,
      );
  AudioTrackDataData copyWithCompanion(AudioTrackDataCompanion data) {
    return AudioTrackDataData(
      id: data.id.present ? data.id.value : this.id,
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      bytes: data.bytes.present ? data.bytes.value : this.bytes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AudioTrackDataData(')
          ..write('id: $id, ')
          ..write('trackId: $trackId, ')
          ..write('bytes: $bytes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, trackId, $driftBlobEquality.hash(bytes));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AudioTrackDataData &&
          other.id == this.id &&
          other.trackId == this.trackId &&
          $driftBlobEquality.equals(other.bytes, this.bytes));
}

class AudioTrackDataCompanion extends UpdateCompanion<AudioTrackDataData> {
  final Value<int> id;
  final Value<int> trackId;
  final Value<Uint8List> bytes;
  const AudioTrackDataCompanion({
    this.id = const Value.absent(),
    this.trackId = const Value.absent(),
    this.bytes = const Value.absent(),
  });
  AudioTrackDataCompanion.insert({
    this.id = const Value.absent(),
    required int trackId,
    required Uint8List bytes,
  }) : trackId = Value(trackId),
       bytes = Value(bytes);
  static Insertable<AudioTrackDataData> custom({
    Expression<int>? id,
    Expression<int>? trackId,
    Expression<Uint8List>? bytes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trackId != null) 'track_id': trackId,
      if (bytes != null) 'bytes': bytes,
    });
  }

  AudioTrackDataCompanion copyWith({
    Value<int>? id,
    Value<int>? trackId,
    Value<Uint8List>? bytes,
  }) {
    return AudioTrackDataCompanion(
      id: id ?? this.id,
      trackId: trackId ?? this.trackId,
      bytes: bytes ?? this.bytes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (bytes.present) {
      map['bytes'] = Variable<Uint8List>(bytes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AudioTrackDataCompanion(')
          ..write('id: $id, ')
          ..write('trackId: $trackId, ')
          ..write('bytes: $bytes')
          ..write(')'))
        .toString();
  }
}

class $BeatmapsTable extends Beatmaps with TableInfo<$BeatmapsTable, Beatmap> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BeatmapsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES audio_tracks (id) ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _difficultyNameMeta = const VerificationMeta(
    'difficultyName',
  );
  @override
  late final GeneratedColumn<String> difficultyName = GeneratedColumn<String>(
    'difficulty_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyLevelMeta = const VerificationMeta(
    'difficultyLevel',
  );
  @override
  late final GeneratedColumn<int> difficultyLevel = GeneratedColumn<int>(
    'difficulty_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioOffsetMsMeta = const VerificationMeta(
    'audioOffsetMs',
  );
  @override
  late final GeneratedColumn<int> audioOffsetMs = GeneratedColumn<int>(
    'audio_offset_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _baseBpmMeta = const VerificationMeta(
    'baseBpm',
  );
  @override
  late final GeneratedColumn<double> baseBpm = GeneratedColumn<double>(
    'base_bpm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(120.0),
  );
  static const VerificationMeta _scrollSpeedMeta = const VerificationMeta(
    'scrollSpeed',
  );
  @override
  late final GeneratedColumn<double> scrollSpeed = GeneratedColumn<double>(
    'scroll_speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trackId,
    title,
    difficultyName,
    difficultyLevel,
    audioOffsetMs,
    baseBpm,
    scrollSpeed,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'beatmaps';
  @override
  VerificationContext validateIntegrity(
    Insertable<Beatmap> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('difficulty_name')) {
      context.handle(
        _difficultyNameMeta,
        difficultyName.isAcceptableOrUnknown(
          data['difficulty_name']!,
          _difficultyNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_difficultyNameMeta);
    }
    if (data.containsKey('difficulty_level')) {
      context.handle(
        _difficultyLevelMeta,
        difficultyLevel.isAcceptableOrUnknown(
          data['difficulty_level']!,
          _difficultyLevelMeta,
        ),
      );
    }
    if (data.containsKey('audio_offset_ms')) {
      context.handle(
        _audioOffsetMsMeta,
        audioOffsetMs.isAcceptableOrUnknown(
          data['audio_offset_ms']!,
          _audioOffsetMsMeta,
        ),
      );
    }
    if (data.containsKey('base_bpm')) {
      context.handle(
        _baseBpmMeta,
        baseBpm.isAcceptableOrUnknown(data['base_bpm']!, _baseBpmMeta),
      );
    }
    if (data.containsKey('scroll_speed')) {
      context.handle(
        _scrollSpeedMeta,
        scrollSpeed.isAcceptableOrUnknown(
          data['scroll_speed']!,
          _scrollSpeedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Beatmap map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Beatmap(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      trackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      difficultyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty_name'],
      )!,
      difficultyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty_level'],
      ),
      audioOffsetMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}audio_offset_ms'],
      )!,
      baseBpm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}base_bpm'],
      )!,
      scrollSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}scroll_speed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BeatmapsTable createAlias(String alias) {
    return $BeatmapsTable(attachedDatabase, alias);
  }
}

class Beatmap extends DataClass implements Insertable<Beatmap> {
  final int id;
  final int trackId;
  final String title;
  final String difficultyName;
  final int? difficultyLevel;
  final int audioOffsetMs;
  final double baseBpm;
  final double scrollSpeed;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Beatmap({
    required this.id,
    required this.trackId,
    required this.title,
    required this.difficultyName,
    this.difficultyLevel,
    required this.audioOffsetMs,
    required this.baseBpm,
    required this.scrollSpeed,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['track_id'] = Variable<int>(trackId);
    map['title'] = Variable<String>(title);
    map['difficulty_name'] = Variable<String>(difficultyName);
    if (!nullToAbsent || difficultyLevel != null) {
      map['difficulty_level'] = Variable<int>(difficultyLevel);
    }
    map['audio_offset_ms'] = Variable<int>(audioOffsetMs);
    map['base_bpm'] = Variable<double>(baseBpm);
    map['scroll_speed'] = Variable<double>(scrollSpeed);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BeatmapsCompanion toCompanion(bool nullToAbsent) {
    return BeatmapsCompanion(
      id: Value(id),
      trackId: Value(trackId),
      title: Value(title),
      difficultyName: Value(difficultyName),
      difficultyLevel: difficultyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(difficultyLevel),
      audioOffsetMs: Value(audioOffsetMs),
      baseBpm: Value(baseBpm),
      scrollSpeed: Value(scrollSpeed),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Beatmap.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Beatmap(
      id: serializer.fromJson<int>(json['id']),
      trackId: serializer.fromJson<int>(json['trackId']),
      title: serializer.fromJson<String>(json['title']),
      difficultyName: serializer.fromJson<String>(json['difficultyName']),
      difficultyLevel: serializer.fromJson<int?>(json['difficultyLevel']),
      audioOffsetMs: serializer.fromJson<int>(json['audioOffsetMs']),
      baseBpm: serializer.fromJson<double>(json['baseBpm']),
      scrollSpeed: serializer.fromJson<double>(json['scrollSpeed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trackId': serializer.toJson<int>(trackId),
      'title': serializer.toJson<String>(title),
      'difficultyName': serializer.toJson<String>(difficultyName),
      'difficultyLevel': serializer.toJson<int?>(difficultyLevel),
      'audioOffsetMs': serializer.toJson<int>(audioOffsetMs),
      'baseBpm': serializer.toJson<double>(baseBpm),
      'scrollSpeed': serializer.toJson<double>(scrollSpeed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Beatmap copyWith({
    int? id,
    int? trackId,
    String? title,
    String? difficultyName,
    Value<int?> difficultyLevel = const Value.absent(),
    int? audioOffsetMs,
    double? baseBpm,
    double? scrollSpeed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Beatmap(
    id: id ?? this.id,
    trackId: trackId ?? this.trackId,
    title: title ?? this.title,
    difficultyName: difficultyName ?? this.difficultyName,
    difficultyLevel: difficultyLevel.present
        ? difficultyLevel.value
        : this.difficultyLevel,
    audioOffsetMs: audioOffsetMs ?? this.audioOffsetMs,
    baseBpm: baseBpm ?? this.baseBpm,
    scrollSpeed: scrollSpeed ?? this.scrollSpeed,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Beatmap copyWithCompanion(BeatmapsCompanion data) {
    return Beatmap(
      id: data.id.present ? data.id.value : this.id,
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      title: data.title.present ? data.title.value : this.title,
      difficultyName: data.difficultyName.present
          ? data.difficultyName.value
          : this.difficultyName,
      difficultyLevel: data.difficultyLevel.present
          ? data.difficultyLevel.value
          : this.difficultyLevel,
      audioOffsetMs: data.audioOffsetMs.present
          ? data.audioOffsetMs.value
          : this.audioOffsetMs,
      baseBpm: data.baseBpm.present ? data.baseBpm.value : this.baseBpm,
      scrollSpeed: data.scrollSpeed.present
          ? data.scrollSpeed.value
          : this.scrollSpeed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Beatmap(')
          ..write('id: $id, ')
          ..write('trackId: $trackId, ')
          ..write('title: $title, ')
          ..write('difficultyName: $difficultyName, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('audioOffsetMs: $audioOffsetMs, ')
          ..write('baseBpm: $baseBpm, ')
          ..write('scrollSpeed: $scrollSpeed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    trackId,
    title,
    difficultyName,
    difficultyLevel,
    audioOffsetMs,
    baseBpm,
    scrollSpeed,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Beatmap &&
          other.id == this.id &&
          other.trackId == this.trackId &&
          other.title == this.title &&
          other.difficultyName == this.difficultyName &&
          other.difficultyLevel == this.difficultyLevel &&
          other.audioOffsetMs == this.audioOffsetMs &&
          other.baseBpm == this.baseBpm &&
          other.scrollSpeed == this.scrollSpeed &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BeatmapsCompanion extends UpdateCompanion<Beatmap> {
  final Value<int> id;
  final Value<int> trackId;
  final Value<String> title;
  final Value<String> difficultyName;
  final Value<int?> difficultyLevel;
  final Value<int> audioOffsetMs;
  final Value<double> baseBpm;
  final Value<double> scrollSpeed;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BeatmapsCompanion({
    this.id = const Value.absent(),
    this.trackId = const Value.absent(),
    this.title = const Value.absent(),
    this.difficultyName = const Value.absent(),
    this.difficultyLevel = const Value.absent(),
    this.audioOffsetMs = const Value.absent(),
    this.baseBpm = const Value.absent(),
    this.scrollSpeed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BeatmapsCompanion.insert({
    this.id = const Value.absent(),
    required int trackId,
    required String title,
    required String difficultyName,
    this.difficultyLevel = const Value.absent(),
    this.audioOffsetMs = const Value.absent(),
    this.baseBpm = const Value.absent(),
    this.scrollSpeed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : trackId = Value(trackId),
       title = Value(title),
       difficultyName = Value(difficultyName);
  static Insertable<Beatmap> custom({
    Expression<int>? id,
    Expression<int>? trackId,
    Expression<String>? title,
    Expression<String>? difficultyName,
    Expression<int>? difficultyLevel,
    Expression<int>? audioOffsetMs,
    Expression<double>? baseBpm,
    Expression<double>? scrollSpeed,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trackId != null) 'track_id': trackId,
      if (title != null) 'title': title,
      if (difficultyName != null) 'difficulty_name': difficultyName,
      if (difficultyLevel != null) 'difficulty_level': difficultyLevel,
      if (audioOffsetMs != null) 'audio_offset_ms': audioOffsetMs,
      if (baseBpm != null) 'base_bpm': baseBpm,
      if (scrollSpeed != null) 'scroll_speed': scrollSpeed,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BeatmapsCompanion copyWith({
    Value<int>? id,
    Value<int>? trackId,
    Value<String>? title,
    Value<String>? difficultyName,
    Value<int?>? difficultyLevel,
    Value<int>? audioOffsetMs,
    Value<double>? baseBpm,
    Value<double>? scrollSpeed,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BeatmapsCompanion(
      id: id ?? this.id,
      trackId: trackId ?? this.trackId,
      title: title ?? this.title,
      difficultyName: difficultyName ?? this.difficultyName,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      audioOffsetMs: audioOffsetMs ?? this.audioOffsetMs,
      baseBpm: baseBpm ?? this.baseBpm,
      scrollSpeed: scrollSpeed ?? this.scrollSpeed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (difficultyName.present) {
      map['difficulty_name'] = Variable<String>(difficultyName.value);
    }
    if (difficultyLevel.present) {
      map['difficulty_level'] = Variable<int>(difficultyLevel.value);
    }
    if (audioOffsetMs.present) {
      map['audio_offset_ms'] = Variable<int>(audioOffsetMs.value);
    }
    if (baseBpm.present) {
      map['base_bpm'] = Variable<double>(baseBpm.value);
    }
    if (scrollSpeed.present) {
      map['scroll_speed'] = Variable<double>(scrollSpeed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BeatmapsCompanion(')
          ..write('id: $id, ')
          ..write('trackId: $trackId, ')
          ..write('title: $title, ')
          ..write('difficultyName: $difficultyName, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('audioOffsetMs: $audioOffsetMs, ')
          ..write('baseBpm: $baseBpm, ')
          ..write('scrollSpeed: $scrollSpeed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TimingPointsTable extends TimingPoints
    with TableInfo<$TimingPointsTable, TimingPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimingPointsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _beatmapIdMeta = const VerificationMeta(
    'beatmapId',
  );
  @override
  late final GeneratedColumn<int> beatmapId = GeneratedColumn<int>(
    'beatmap_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beatmaps (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _timeMsMeta = const VerificationMeta('timeMs');
  @override
  late final GeneratedColumn<int> timeMs = GeneratedColumn<int>(
    'time_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bpmMeta = const VerificationMeta('bpm');
  @override
  late final GeneratedColumn<double> bpm = GeneratedColumn<double>(
    'bpm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meterMeta = const VerificationMeta('meter');
  @override
  late final GeneratedColumn<int> meter = GeneratedColumn<int>(
    'meter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4),
  );
  static const VerificationMeta _inheritedMeta = const VerificationMeta(
    'inherited',
  );
  @override
  late final GeneratedColumn<bool> inherited = GeneratedColumn<bool>(
    'inherited',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("inherited" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    beatmapId,
    timeMs,
    bpm,
    meter,
    inherited,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timing_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimingPoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('beatmap_id')) {
      context.handle(
        _beatmapIdMeta,
        beatmapId.isAcceptableOrUnknown(data['beatmap_id']!, _beatmapIdMeta),
      );
    } else if (isInserting) {
      context.missing(_beatmapIdMeta);
    }
    if (data.containsKey('time_ms')) {
      context.handle(
        _timeMsMeta,
        timeMs.isAcceptableOrUnknown(data['time_ms']!, _timeMsMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMsMeta);
    }
    if (data.containsKey('bpm')) {
      context.handle(
        _bpmMeta,
        bpm.isAcceptableOrUnknown(data['bpm']!, _bpmMeta),
      );
    } else if (isInserting) {
      context.missing(_bpmMeta);
    }
    if (data.containsKey('meter')) {
      context.handle(
        _meterMeta,
        meter.isAcceptableOrUnknown(data['meter']!, _meterMeta),
      );
    }
    if (data.containsKey('inherited')) {
      context.handle(
        _inheritedMeta,
        inherited.isAcceptableOrUnknown(data['inherited']!, _inheritedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimingPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimingPoint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      beatmapId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}beatmap_id'],
      )!,
      timeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_ms'],
      )!,
      bpm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bpm'],
      )!,
      meter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meter'],
      )!,
      inherited: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}inherited'],
      )!,
    );
  }

  @override
  $TimingPointsTable createAlias(String alias) {
    return $TimingPointsTable(attachedDatabase, alias);
  }
}

class TimingPoint extends DataClass implements Insertable<TimingPoint> {
  final int id;
  final int beatmapId;
  final int timeMs;
  final double bpm;
  final int meter;
  final bool inherited;
  const TimingPoint({
    required this.id,
    required this.beatmapId,
    required this.timeMs,
    required this.bpm,
    required this.meter,
    required this.inherited,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['beatmap_id'] = Variable<int>(beatmapId);
    map['time_ms'] = Variable<int>(timeMs);
    map['bpm'] = Variable<double>(bpm);
    map['meter'] = Variable<int>(meter);
    map['inherited'] = Variable<bool>(inherited);
    return map;
  }

  TimingPointsCompanion toCompanion(bool nullToAbsent) {
    return TimingPointsCompanion(
      id: Value(id),
      beatmapId: Value(beatmapId),
      timeMs: Value(timeMs),
      bpm: Value(bpm),
      meter: Value(meter),
      inherited: Value(inherited),
    );
  }

  factory TimingPoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimingPoint(
      id: serializer.fromJson<int>(json['id']),
      beatmapId: serializer.fromJson<int>(json['beatmapId']),
      timeMs: serializer.fromJson<int>(json['timeMs']),
      bpm: serializer.fromJson<double>(json['bpm']),
      meter: serializer.fromJson<int>(json['meter']),
      inherited: serializer.fromJson<bool>(json['inherited']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'beatmapId': serializer.toJson<int>(beatmapId),
      'timeMs': serializer.toJson<int>(timeMs),
      'bpm': serializer.toJson<double>(bpm),
      'meter': serializer.toJson<int>(meter),
      'inherited': serializer.toJson<bool>(inherited),
    };
  }

  TimingPoint copyWith({
    int? id,
    int? beatmapId,
    int? timeMs,
    double? bpm,
    int? meter,
    bool? inherited,
  }) => TimingPoint(
    id: id ?? this.id,
    beatmapId: beatmapId ?? this.beatmapId,
    timeMs: timeMs ?? this.timeMs,
    bpm: bpm ?? this.bpm,
    meter: meter ?? this.meter,
    inherited: inherited ?? this.inherited,
  );
  TimingPoint copyWithCompanion(TimingPointsCompanion data) {
    return TimingPoint(
      id: data.id.present ? data.id.value : this.id,
      beatmapId: data.beatmapId.present ? data.beatmapId.value : this.beatmapId,
      timeMs: data.timeMs.present ? data.timeMs.value : this.timeMs,
      bpm: data.bpm.present ? data.bpm.value : this.bpm,
      meter: data.meter.present ? data.meter.value : this.meter,
      inherited: data.inherited.present ? data.inherited.value : this.inherited,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimingPoint(')
          ..write('id: $id, ')
          ..write('beatmapId: $beatmapId, ')
          ..write('timeMs: $timeMs, ')
          ..write('bpm: $bpm, ')
          ..write('meter: $meter, ')
          ..write('inherited: $inherited')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, beatmapId, timeMs, bpm, meter, inherited);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimingPoint &&
          other.id == this.id &&
          other.beatmapId == this.beatmapId &&
          other.timeMs == this.timeMs &&
          other.bpm == this.bpm &&
          other.meter == this.meter &&
          other.inherited == this.inherited);
}

class TimingPointsCompanion extends UpdateCompanion<TimingPoint> {
  final Value<int> id;
  final Value<int> beatmapId;
  final Value<int> timeMs;
  final Value<double> bpm;
  final Value<int> meter;
  final Value<bool> inherited;
  const TimingPointsCompanion({
    this.id = const Value.absent(),
    this.beatmapId = const Value.absent(),
    this.timeMs = const Value.absent(),
    this.bpm = const Value.absent(),
    this.meter = const Value.absent(),
    this.inherited = const Value.absent(),
  });
  TimingPointsCompanion.insert({
    this.id = const Value.absent(),
    required int beatmapId,
    required int timeMs,
    required double bpm,
    this.meter = const Value.absent(),
    this.inherited = const Value.absent(),
  }) : beatmapId = Value(beatmapId),
       timeMs = Value(timeMs),
       bpm = Value(bpm);
  static Insertable<TimingPoint> custom({
    Expression<int>? id,
    Expression<int>? beatmapId,
    Expression<int>? timeMs,
    Expression<double>? bpm,
    Expression<int>? meter,
    Expression<bool>? inherited,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (beatmapId != null) 'beatmap_id': beatmapId,
      if (timeMs != null) 'time_ms': timeMs,
      if (bpm != null) 'bpm': bpm,
      if (meter != null) 'meter': meter,
      if (inherited != null) 'inherited': inherited,
    });
  }

  TimingPointsCompanion copyWith({
    Value<int>? id,
    Value<int>? beatmapId,
    Value<int>? timeMs,
    Value<double>? bpm,
    Value<int>? meter,
    Value<bool>? inherited,
  }) {
    return TimingPointsCompanion(
      id: id ?? this.id,
      beatmapId: beatmapId ?? this.beatmapId,
      timeMs: timeMs ?? this.timeMs,
      bpm: bpm ?? this.bpm,
      meter: meter ?? this.meter,
      inherited: inherited ?? this.inherited,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (beatmapId.present) {
      map['beatmap_id'] = Variable<int>(beatmapId.value);
    }
    if (timeMs.present) {
      map['time_ms'] = Variable<int>(timeMs.value);
    }
    if (bpm.present) {
      map['bpm'] = Variable<double>(bpm.value);
    }
    if (meter.present) {
      map['meter'] = Variable<int>(meter.value);
    }
    if (inherited.present) {
      map['inherited'] = Variable<bool>(inherited.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimingPointsCompanion(')
          ..write('id: $id, ')
          ..write('beatmapId: $beatmapId, ')
          ..write('timeMs: $timeMs, ')
          ..write('bpm: $bpm, ')
          ..write('meter: $meter, ')
          ..write('inherited: $inherited')
          ..write(')'))
        .toString();
  }
}

class $BeatmapNotesTable extends BeatmapNotes
    with TableInfo<$BeatmapNotesTable, BeatmapNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BeatmapNotesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _beatmapIdMeta = const VerificationMeta(
    'beatmapId',
  );
  @override
  late final GeneratedColumn<int> beatmapId = GeneratedColumn<int>(
    'beatmap_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES beatmaps (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _timeMsMeta = const VerificationMeta('timeMs');
  @override
  late final GeneratedColumn<int> timeMs = GeneratedColumn<int>(
    'time_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _laneMeta = const VerificationMeta('lane');
  @override
  late final GeneratedColumn<int> lane = GeneratedColumn<int>(
    'lane',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionXMeta = const VerificationMeta(
    'positionX',
  );
  @override
  late final GeneratedColumn<double> positionX = GeneratedColumn<double>(
    'position_x',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionYMeta = const VerificationMeta(
    'positionY',
  );
  @override
  late final GeneratedColumn<double> positionY = GeneratedColumn<double>(
    'position_y',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    beatmapId,
    timeMs,
    lane,
    type,
    durationMs,
    direction,
    positionX,
    positionY,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'beatmap_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<BeatmapNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('beatmap_id')) {
      context.handle(
        _beatmapIdMeta,
        beatmapId.isAcceptableOrUnknown(data['beatmap_id']!, _beatmapIdMeta),
      );
    } else if (isInserting) {
      context.missing(_beatmapIdMeta);
    }
    if (data.containsKey('time_ms')) {
      context.handle(
        _timeMsMeta,
        timeMs.isAcceptableOrUnknown(data['time_ms']!, _timeMsMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMsMeta);
    }
    if (data.containsKey('lane')) {
      context.handle(
        _laneMeta,
        lane.isAcceptableOrUnknown(data['lane']!, _laneMeta),
      );
    } else if (isInserting) {
      context.missing(_laneMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    }
    if (data.containsKey('position_x')) {
      context.handle(
        _positionXMeta,
        positionX.isAcceptableOrUnknown(data['position_x']!, _positionXMeta),
      );
    }
    if (data.containsKey('position_y')) {
      context.handle(
        _positionYMeta,
        positionY.isAcceptableOrUnknown(data['position_y']!, _positionYMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BeatmapNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BeatmapNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      beatmapId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}beatmap_id'],
      )!,
      timeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_ms'],
      )!,
      lane: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lane'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      ),
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      ),
      positionX: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}position_x'],
      ),
      positionY: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}position_y'],
      ),
    );
  }

  @override
  $BeatmapNotesTable createAlias(String alias) {
    return $BeatmapNotesTable(attachedDatabase, alias);
  }
}

class BeatmapNote extends DataClass implements Insertable<BeatmapNote> {
  final int id;
  final int beatmapId;
  final int timeMs;
  final int lane;
  final String type;
  final int? durationMs;
  final String? direction;
  final double? positionX;
  final double? positionY;
  const BeatmapNote({
    required this.id,
    required this.beatmapId,
    required this.timeMs,
    required this.lane,
    required this.type,
    this.durationMs,
    this.direction,
    this.positionX,
    this.positionY,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['beatmap_id'] = Variable<int>(beatmapId);
    map['time_ms'] = Variable<int>(timeMs);
    map['lane'] = Variable<int>(lane);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    if (!nullToAbsent || direction != null) {
      map['direction'] = Variable<String>(direction);
    }
    if (!nullToAbsent || positionX != null) {
      map['position_x'] = Variable<double>(positionX);
    }
    if (!nullToAbsent || positionY != null) {
      map['position_y'] = Variable<double>(positionY);
    }
    return map;
  }

  BeatmapNotesCompanion toCompanion(bool nullToAbsent) {
    return BeatmapNotesCompanion(
      id: Value(id),
      beatmapId: Value(beatmapId),
      timeMs: Value(timeMs),
      lane: Value(lane),
      type: Value(type),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      direction: direction == null && nullToAbsent
          ? const Value.absent()
          : Value(direction),
      positionX: positionX == null && nullToAbsent
          ? const Value.absent()
          : Value(positionX),
      positionY: positionY == null && nullToAbsent
          ? const Value.absent()
          : Value(positionY),
    );
  }

  factory BeatmapNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BeatmapNote(
      id: serializer.fromJson<int>(json['id']),
      beatmapId: serializer.fromJson<int>(json['beatmapId']),
      timeMs: serializer.fromJson<int>(json['timeMs']),
      lane: serializer.fromJson<int>(json['lane']),
      type: serializer.fromJson<String>(json['type']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      direction: serializer.fromJson<String?>(json['direction']),
      positionX: serializer.fromJson<double?>(json['positionX']),
      positionY: serializer.fromJson<double?>(json['positionY']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'beatmapId': serializer.toJson<int>(beatmapId),
      'timeMs': serializer.toJson<int>(timeMs),
      'lane': serializer.toJson<int>(lane),
      'type': serializer.toJson<String>(type),
      'durationMs': serializer.toJson<int?>(durationMs),
      'direction': serializer.toJson<String?>(direction),
      'positionX': serializer.toJson<double?>(positionX),
      'positionY': serializer.toJson<double?>(positionY),
    };
  }

  BeatmapNote copyWith({
    int? id,
    int? beatmapId,
    int? timeMs,
    int? lane,
    String? type,
    Value<int?> durationMs = const Value.absent(),
    Value<String?> direction = const Value.absent(),
    Value<double?> positionX = const Value.absent(),
    Value<double?> positionY = const Value.absent(),
  }) => BeatmapNote(
    id: id ?? this.id,
    beatmapId: beatmapId ?? this.beatmapId,
    timeMs: timeMs ?? this.timeMs,
    lane: lane ?? this.lane,
    type: type ?? this.type,
    durationMs: durationMs.present ? durationMs.value : this.durationMs,
    direction: direction.present ? direction.value : this.direction,
    positionX: positionX.present ? positionX.value : this.positionX,
    positionY: positionY.present ? positionY.value : this.positionY,
  );
  BeatmapNote copyWithCompanion(BeatmapNotesCompanion data) {
    return BeatmapNote(
      id: data.id.present ? data.id.value : this.id,
      beatmapId: data.beatmapId.present ? data.beatmapId.value : this.beatmapId,
      timeMs: data.timeMs.present ? data.timeMs.value : this.timeMs,
      lane: data.lane.present ? data.lane.value : this.lane,
      type: data.type.present ? data.type.value : this.type,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      direction: data.direction.present ? data.direction.value : this.direction,
      positionX: data.positionX.present ? data.positionX.value : this.positionX,
      positionY: data.positionY.present ? data.positionY.value : this.positionY,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BeatmapNote(')
          ..write('id: $id, ')
          ..write('beatmapId: $beatmapId, ')
          ..write('timeMs: $timeMs, ')
          ..write('lane: $lane, ')
          ..write('type: $type, ')
          ..write('durationMs: $durationMs, ')
          ..write('direction: $direction, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    beatmapId,
    timeMs,
    lane,
    type,
    durationMs,
    direction,
    positionX,
    positionY,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BeatmapNote &&
          other.id == this.id &&
          other.beatmapId == this.beatmapId &&
          other.timeMs == this.timeMs &&
          other.lane == this.lane &&
          other.type == this.type &&
          other.durationMs == this.durationMs &&
          other.direction == this.direction &&
          other.positionX == this.positionX &&
          other.positionY == this.positionY);
}

class BeatmapNotesCompanion extends UpdateCompanion<BeatmapNote> {
  final Value<int> id;
  final Value<int> beatmapId;
  final Value<int> timeMs;
  final Value<int> lane;
  final Value<String> type;
  final Value<int?> durationMs;
  final Value<String?> direction;
  final Value<double?> positionX;
  final Value<double?> positionY;
  const BeatmapNotesCompanion({
    this.id = const Value.absent(),
    this.beatmapId = const Value.absent(),
    this.timeMs = const Value.absent(),
    this.lane = const Value.absent(),
    this.type = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.direction = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
  });
  BeatmapNotesCompanion.insert({
    this.id = const Value.absent(),
    required int beatmapId,
    required int timeMs,
    required int lane,
    required String type,
    this.durationMs = const Value.absent(),
    this.direction = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
  }) : beatmapId = Value(beatmapId),
       timeMs = Value(timeMs),
       lane = Value(lane),
       type = Value(type);
  static Insertable<BeatmapNote> custom({
    Expression<int>? id,
    Expression<int>? beatmapId,
    Expression<int>? timeMs,
    Expression<int>? lane,
    Expression<String>? type,
    Expression<int>? durationMs,
    Expression<String>? direction,
    Expression<double>? positionX,
    Expression<double>? positionY,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (beatmapId != null) 'beatmap_id': beatmapId,
      if (timeMs != null) 'time_ms': timeMs,
      if (lane != null) 'lane': lane,
      if (type != null) 'type': type,
      if (durationMs != null) 'duration_ms': durationMs,
      if (direction != null) 'direction': direction,
      if (positionX != null) 'position_x': positionX,
      if (positionY != null) 'position_y': positionY,
    });
  }

  BeatmapNotesCompanion copyWith({
    Value<int>? id,
    Value<int>? beatmapId,
    Value<int>? timeMs,
    Value<int>? lane,
    Value<String>? type,
    Value<int?>? durationMs,
    Value<String?>? direction,
    Value<double?>? positionX,
    Value<double?>? positionY,
  }) {
    return BeatmapNotesCompanion(
      id: id ?? this.id,
      beatmapId: beatmapId ?? this.beatmapId,
      timeMs: timeMs ?? this.timeMs,
      lane: lane ?? this.lane,
      type: type ?? this.type,
      durationMs: durationMs ?? this.durationMs,
      direction: direction ?? this.direction,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (beatmapId.present) {
      map['beatmap_id'] = Variable<int>(beatmapId.value);
    }
    if (timeMs.present) {
      map['time_ms'] = Variable<int>(timeMs.value);
    }
    if (lane.present) {
      map['lane'] = Variable<int>(lane.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (positionX.present) {
      map['position_x'] = Variable<double>(positionX.value);
    }
    if (positionY.present) {
      map['position_y'] = Variable<double>(positionY.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BeatmapNotesCompanion(')
          ..write('id: $id, ')
          ..write('beatmapId: $beatmapId, ')
          ..write('timeMs: $timeMs, ')
          ..write('lane: $lane, ')
          ..write('type: $type, ')
          ..write('durationMs: $durationMs, ')
          ..write('direction: $direction, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AudioTracksTable audioTracks = $AudioTracksTable(this);
  late final $TrackCategoriesTable trackCategories = $TrackCategoriesTable(
    this,
  );
  late final $TrackCategoryLinksTable trackCategoryLinks =
      $TrackCategoryLinksTable(this);
  late final $AudioTrackDataTable audioTrackData = $AudioTrackDataTable(this);
  late final $BeatmapsTable beatmaps = $BeatmapsTable(this);
  late final $TimingPointsTable timingPoints = $TimingPointsTable(this);
  late final $BeatmapNotesTable beatmapNotes = $BeatmapNotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    audioTracks,
    trackCategories,
    trackCategoryLinks,
    audioTrackData,
    beatmaps,
    timingPoints,
    beatmapNotes,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'audio_tracks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('track_category_links', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'track_categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('track_category_links', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'audio_tracks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('audio_track_data', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'audio_tracks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('beatmaps', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'beatmaps',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('timing_points', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'beatmaps',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('beatmap_notes', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$AudioTracksTableCreateCompanionBuilder =
    AudioTracksCompanion Function({
      Value<int> id,
      required String displayName,
      required String fileName,
      required String extension,
      Value<String?> mimeType,
      required int sizeBytes,
      Value<String?> localPath,
      Value<String?> webStorageKey,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$AudioTracksTableUpdateCompanionBuilder =
    AudioTracksCompanion Function({
      Value<int> id,
      Value<String> displayName,
      Value<String> fileName,
      Value<String> extension,
      Value<String?> mimeType,
      Value<int> sizeBytes,
      Value<String?> localPath,
      Value<String?> webStorageKey,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$AudioTracksTableReferences
    extends BaseReferences<_$AppDatabase, $AudioTracksTable, AudioTrack> {
  $$AudioTracksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TrackCategoryLinksTable, List<TrackCategoryLink>>
  _trackCategoryLinksRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.trackCategoryLinks,
        aliasName: $_aliasNameGenerator(
          db.audioTracks.id,
          db.trackCategoryLinks.trackId,
        ),
      );

  $$TrackCategoryLinksTableProcessedTableManager get trackCategoryLinksRefs {
    final manager = $$TrackCategoryLinksTableTableManager(
      $_db,
      $_db.trackCategoryLinks,
    ).filter((f) => f.trackId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _trackCategoryLinksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AudioTrackDataTable, List<AudioTrackDataData>>
  _audioTrackDataRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.audioTrackData,
    aliasName: $_aliasNameGenerator(
      db.audioTracks.id,
      db.audioTrackData.trackId,
    ),
  );

  $$AudioTrackDataTableProcessedTableManager get audioTrackDataRefs {
    final manager = $$AudioTrackDataTableTableManager(
      $_db,
      $_db.audioTrackData,
    ).filter((f) => f.trackId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_audioTrackDataRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BeatmapsTable, List<Beatmap>> _beatmapsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.beatmaps,
    aliasName: $_aliasNameGenerator(db.audioTracks.id, db.beatmaps.trackId),
  );

  $$BeatmapsTableProcessedTableManager get beatmapsRefs {
    final manager = $$BeatmapsTableTableManager(
      $_db,
      $_db.beatmaps,
    ).filter((f) => f.trackId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_beatmapsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AudioTracksTableFilterComposer
    extends Composer<_$AppDatabase, $AudioTracksTable> {
  $$AudioTracksTableFilterComposer({
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

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extension => $composableBuilder(
    column: $table.extension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get webStorageKey => $composableBuilder(
    column: $table.webStorageKey,
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

  Expression<bool> trackCategoryLinksRefs(
    Expression<bool> Function($$TrackCategoryLinksTableFilterComposer f) f,
  ) {
    final $$TrackCategoryLinksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackCategoryLinks,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackCategoryLinksTableFilterComposer(
            $db: $db,
            $table: $db.trackCategoryLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> audioTrackDataRefs(
    Expression<bool> Function($$AudioTrackDataTableFilterComposer f) f,
  ) {
    final $$AudioTrackDataTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.audioTrackData,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AudioTrackDataTableFilterComposer(
            $db: $db,
            $table: $db.audioTrackData,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> beatmapsRefs(
    Expression<bool> Function($$BeatmapsTableFilterComposer f) f,
  ) {
    final $$BeatmapsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beatmaps,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeatmapsTableFilterComposer(
            $db: $db,
            $table: $db.beatmaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AudioTracksTableOrderingComposer
    extends Composer<_$AppDatabase, $AudioTracksTable> {
  $$AudioTracksTableOrderingComposer({
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

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extension => $composableBuilder(
    column: $table.extension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get webStorageKey => $composableBuilder(
    column: $table.webStorageKey,
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
}

class $$AudioTracksTableAnnotationComposer
    extends Composer<_$AppDatabase, $AudioTracksTable> {
  $$AudioTracksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get extension =>
      $composableBuilder(column: $table.extension, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get webStorageKey => $composableBuilder(
    column: $table.webStorageKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> trackCategoryLinksRefs<T extends Object>(
    Expression<T> Function($$TrackCategoryLinksTableAnnotationComposer a) f,
  ) {
    final $$TrackCategoryLinksTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.trackCategoryLinks,
          getReferencedColumn: (t) => t.trackId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TrackCategoryLinksTableAnnotationComposer(
                $db: $db,
                $table: $db.trackCategoryLinks,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> audioTrackDataRefs<T extends Object>(
    Expression<T> Function($$AudioTrackDataTableAnnotationComposer a) f,
  ) {
    final $$AudioTrackDataTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.audioTrackData,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AudioTrackDataTableAnnotationComposer(
            $db: $db,
            $table: $db.audioTrackData,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> beatmapsRefs<T extends Object>(
    Expression<T> Function($$BeatmapsTableAnnotationComposer a) f,
  ) {
    final $$BeatmapsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beatmaps,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeatmapsTableAnnotationComposer(
            $db: $db,
            $table: $db.beatmaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AudioTracksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AudioTracksTable,
          AudioTrack,
          $$AudioTracksTableFilterComposer,
          $$AudioTracksTableOrderingComposer,
          $$AudioTracksTableAnnotationComposer,
          $$AudioTracksTableCreateCompanionBuilder,
          $$AudioTracksTableUpdateCompanionBuilder,
          (AudioTrack, $$AudioTracksTableReferences),
          AudioTrack,
          PrefetchHooks Function({
            bool trackCategoryLinksRefs,
            bool audioTrackDataRefs,
            bool beatmapsRefs,
          })
        > {
  $$AudioTracksTableTableManager(_$AppDatabase db, $AudioTracksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AudioTracksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AudioTracksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AudioTracksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> extension = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> webStorageKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AudioTracksCompanion(
                id: id,
                displayName: displayName,
                fileName: fileName,
                extension: extension,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                localPath: localPath,
                webStorageKey: webStorageKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String displayName,
                required String fileName,
                required String extension,
                Value<String?> mimeType = const Value.absent(),
                required int sizeBytes,
                Value<String?> localPath = const Value.absent(),
                Value<String?> webStorageKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AudioTracksCompanion.insert(
                id: id,
                displayName: displayName,
                fileName: fileName,
                extension: extension,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                localPath: localPath,
                webStorageKey: webStorageKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AudioTracksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                trackCategoryLinksRefs = false,
                audioTrackDataRefs = false,
                beatmapsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (trackCategoryLinksRefs) db.trackCategoryLinks,
                    if (audioTrackDataRefs) db.audioTrackData,
                    if (beatmapsRefs) db.beatmaps,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (trackCategoryLinksRefs)
                        await $_getPrefetchedData<
                          AudioTrack,
                          $AudioTracksTable,
                          TrackCategoryLink
                        >(
                          currentTable: table,
                          referencedTable: $$AudioTracksTableReferences
                              ._trackCategoryLinksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AudioTracksTableReferences(
                                db,
                                table,
                                p0,
                              ).trackCategoryLinksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trackId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (audioTrackDataRefs)
                        await $_getPrefetchedData<
                          AudioTrack,
                          $AudioTracksTable,
                          AudioTrackDataData
                        >(
                          currentTable: table,
                          referencedTable: $$AudioTracksTableReferences
                              ._audioTrackDataRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AudioTracksTableReferences(
                                db,
                                table,
                                p0,
                              ).audioTrackDataRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trackId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (beatmapsRefs)
                        await $_getPrefetchedData<
                          AudioTrack,
                          $AudioTracksTable,
                          Beatmap
                        >(
                          currentTable: table,
                          referencedTable: $$AudioTracksTableReferences
                              ._beatmapsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AudioTracksTableReferences(
                                db,
                                table,
                                p0,
                              ).beatmapsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trackId == item.id,
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

typedef $$AudioTracksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AudioTracksTable,
      AudioTrack,
      $$AudioTracksTableFilterComposer,
      $$AudioTracksTableOrderingComposer,
      $$AudioTracksTableAnnotationComposer,
      $$AudioTracksTableCreateCompanionBuilder,
      $$AudioTracksTableUpdateCompanionBuilder,
      (AudioTrack, $$AudioTracksTableReferences),
      AudioTrack,
      PrefetchHooks Function({
        bool trackCategoryLinksRefs,
        bool audioTrackDataRefs,
        bool beatmapsRefs,
      })
    >;
typedef $$TrackCategoriesTableCreateCompanionBuilder =
    TrackCategoriesCompanion Function({
      Value<int> id,
      required String name,
      Value<int?> colorValue,
      Value<DateTime> createdAt,
    });
typedef $$TrackCategoriesTableUpdateCompanionBuilder =
    TrackCategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int?> colorValue,
      Value<DateTime> createdAt,
    });

final class $$TrackCategoriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $TrackCategoriesTable, TrackCategory> {
  $$TrackCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TrackCategoryLinksTable, List<TrackCategoryLink>>
  _trackCategoryLinksRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.trackCategoryLinks,
        aliasName: $_aliasNameGenerator(
          db.trackCategories.id,
          db.trackCategoryLinks.categoryId,
        ),
      );

  $$TrackCategoryLinksTableProcessedTableManager get trackCategoryLinksRefs {
    final manager = $$TrackCategoryLinksTableTableManager(
      $_db,
      $_db.trackCategoryLinks,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _trackCategoryLinksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TrackCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $TrackCategoriesTable> {
  $$TrackCategoriesTableFilterComposer({
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

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> trackCategoryLinksRefs(
    Expression<bool> Function($$TrackCategoryLinksTableFilterComposer f) f,
  ) {
    final $$TrackCategoryLinksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackCategoryLinks,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackCategoryLinksTableFilterComposer(
            $db: $db,
            $table: $db.trackCategoryLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrackCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackCategoriesTable> {
  $$TrackCategoriesTableOrderingComposer({
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

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrackCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackCategoriesTable> {
  $$TrackCategoriesTableAnnotationComposer({
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

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> trackCategoryLinksRefs<T extends Object>(
    Expression<T> Function($$TrackCategoryLinksTableAnnotationComposer a) f,
  ) {
    final $$TrackCategoryLinksTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.trackCategoryLinks,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TrackCategoryLinksTableAnnotationComposer(
                $db: $db,
                $table: $db.trackCategoryLinks,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TrackCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrackCategoriesTable,
          TrackCategory,
          $$TrackCategoriesTableFilterComposer,
          $$TrackCategoriesTableOrderingComposer,
          $$TrackCategoriesTableAnnotationComposer,
          $$TrackCategoriesTableCreateCompanionBuilder,
          $$TrackCategoriesTableUpdateCompanionBuilder,
          (TrackCategory, $$TrackCategoriesTableReferences),
          TrackCategory,
          PrefetchHooks Function({bool trackCategoryLinksRefs})
        > {
  $$TrackCategoriesTableTableManager(
    _$AppDatabase db,
    $TrackCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TrackCategoriesCompanion(
                id: id,
                name: name,
                colorValue: colorValue,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int?> colorValue = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TrackCategoriesCompanion.insert(
                id: id,
                name: name,
                colorValue: colorValue,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrackCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackCategoryLinksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (trackCategoryLinksRefs) db.trackCategoryLinks,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (trackCategoryLinksRefs)
                    await $_getPrefetchedData<
                      TrackCategory,
                      $TrackCategoriesTable,
                      TrackCategoryLink
                    >(
                      currentTable: table,
                      referencedTable: $$TrackCategoriesTableReferences
                          ._trackCategoryLinksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TrackCategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).trackCategoryLinksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TrackCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrackCategoriesTable,
      TrackCategory,
      $$TrackCategoriesTableFilterComposer,
      $$TrackCategoriesTableOrderingComposer,
      $$TrackCategoriesTableAnnotationComposer,
      $$TrackCategoriesTableCreateCompanionBuilder,
      $$TrackCategoriesTableUpdateCompanionBuilder,
      (TrackCategory, $$TrackCategoriesTableReferences),
      TrackCategory,
      PrefetchHooks Function({bool trackCategoryLinksRefs})
    >;
typedef $$TrackCategoryLinksTableCreateCompanionBuilder =
    TrackCategoryLinksCompanion Function({
      required int trackId,
      required int categoryId,
      Value<int> rowid,
    });
typedef $$TrackCategoryLinksTableUpdateCompanionBuilder =
    TrackCategoryLinksCompanion Function({
      Value<int> trackId,
      Value<int> categoryId,
      Value<int> rowid,
    });

final class $$TrackCategoryLinksTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TrackCategoryLinksTable,
          TrackCategoryLink
        > {
  $$TrackCategoryLinksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AudioTracksTable _trackIdTable(_$AppDatabase db) =>
      db.audioTracks.createAlias(
        $_aliasNameGenerator(db.trackCategoryLinks.trackId, db.audioTracks.id),
      );

  $$AudioTracksTableProcessedTableManager get trackId {
    final $_column = $_itemColumn<int>('track_id')!;

    final manager = $$AudioTracksTableTableManager(
      $_db,
      $_db.audioTracks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TrackCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.trackCategories.createAlias(
        $_aliasNameGenerator(
          db.trackCategoryLinks.categoryId,
          db.trackCategories.id,
        ),
      );

  $$TrackCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$TrackCategoriesTableTableManager(
      $_db,
      $_db.trackCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TrackCategoryLinksTableFilterComposer
    extends Composer<_$AppDatabase, $TrackCategoryLinksTable> {
  $$TrackCategoryLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AudioTracksTableFilterComposer get trackId {
    final $$AudioTracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.audioTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AudioTracksTableFilterComposer(
            $db: $db,
            $table: $db.audioTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TrackCategoriesTableFilterComposer get categoryId {
    final $$TrackCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.trackCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.trackCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackCategoryLinksTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackCategoryLinksTable> {
  $$TrackCategoryLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AudioTracksTableOrderingComposer get trackId {
    final $$AudioTracksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.audioTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AudioTracksTableOrderingComposer(
            $db: $db,
            $table: $db.audioTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TrackCategoriesTableOrderingComposer get categoryId {
    final $$TrackCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.trackCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.trackCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackCategoryLinksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackCategoryLinksTable> {
  $$TrackCategoryLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$AudioTracksTableAnnotationComposer get trackId {
    final $$AudioTracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.audioTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AudioTracksTableAnnotationComposer(
            $db: $db,
            $table: $db.audioTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TrackCategoriesTableAnnotationComposer get categoryId {
    final $$TrackCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.trackCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.trackCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackCategoryLinksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrackCategoryLinksTable,
          TrackCategoryLink,
          $$TrackCategoryLinksTableFilterComposer,
          $$TrackCategoryLinksTableOrderingComposer,
          $$TrackCategoryLinksTableAnnotationComposer,
          $$TrackCategoryLinksTableCreateCompanionBuilder,
          $$TrackCategoryLinksTableUpdateCompanionBuilder,
          (TrackCategoryLink, $$TrackCategoryLinksTableReferences),
          TrackCategoryLink,
          PrefetchHooks Function({bool trackId, bool categoryId})
        > {
  $$TrackCategoryLinksTableTableManager(
    _$AppDatabase db,
    $TrackCategoryLinksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackCategoryLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackCategoryLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackCategoryLinksTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> trackId = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrackCategoryLinksCompanion(
                trackId: trackId,
                categoryId: categoryId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int trackId,
                required int categoryId,
                Value<int> rowid = const Value.absent(),
              }) => TrackCategoryLinksCompanion.insert(
                trackId: trackId,
                categoryId: categoryId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrackCategoryLinksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackId = false, categoryId = false}) {
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
                    if (trackId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trackId,
                                referencedTable:
                                    $$TrackCategoryLinksTableReferences
                                        ._trackIdTable(db),
                                referencedColumn:
                                    $$TrackCategoryLinksTableReferences
                                        ._trackIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable:
                                    $$TrackCategoryLinksTableReferences
                                        ._categoryIdTable(db),
                                referencedColumn:
                                    $$TrackCategoryLinksTableReferences
                                        ._categoryIdTable(db)
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

typedef $$TrackCategoryLinksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrackCategoryLinksTable,
      TrackCategoryLink,
      $$TrackCategoryLinksTableFilterComposer,
      $$TrackCategoryLinksTableOrderingComposer,
      $$TrackCategoryLinksTableAnnotationComposer,
      $$TrackCategoryLinksTableCreateCompanionBuilder,
      $$TrackCategoryLinksTableUpdateCompanionBuilder,
      (TrackCategoryLink, $$TrackCategoryLinksTableReferences),
      TrackCategoryLink,
      PrefetchHooks Function({bool trackId, bool categoryId})
    >;
typedef $$AudioTrackDataTableCreateCompanionBuilder =
    AudioTrackDataCompanion Function({
      Value<int> id,
      required int trackId,
      required Uint8List bytes,
    });
typedef $$AudioTrackDataTableUpdateCompanionBuilder =
    AudioTrackDataCompanion Function({
      Value<int> id,
      Value<int> trackId,
      Value<Uint8List> bytes,
    });

final class $$AudioTrackDataTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AudioTrackDataTable,
          AudioTrackDataData
        > {
  $$AudioTrackDataTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AudioTracksTable _trackIdTable(_$AppDatabase db) =>
      db.audioTracks.createAlias(
        $_aliasNameGenerator(db.audioTrackData.trackId, db.audioTracks.id),
      );

  $$AudioTracksTableProcessedTableManager get trackId {
    final $_column = $_itemColumn<int>('track_id')!;

    final manager = $$AudioTracksTableTableManager(
      $_db,
      $_db.audioTracks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AudioTrackDataTableFilterComposer
    extends Composer<_$AppDatabase, $AudioTrackDataTable> {
  $$AudioTrackDataTableFilterComposer({
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

  ColumnFilters<Uint8List> get bytes => $composableBuilder(
    column: $table.bytes,
    builder: (column) => ColumnFilters(column),
  );

  $$AudioTracksTableFilterComposer get trackId {
    final $$AudioTracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.audioTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AudioTracksTableFilterComposer(
            $db: $db,
            $table: $db.audioTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AudioTrackDataTableOrderingComposer
    extends Composer<_$AppDatabase, $AudioTrackDataTable> {
  $$AudioTrackDataTableOrderingComposer({
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

  ColumnOrderings<Uint8List> get bytes => $composableBuilder(
    column: $table.bytes,
    builder: (column) => ColumnOrderings(column),
  );

  $$AudioTracksTableOrderingComposer get trackId {
    final $$AudioTracksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.audioTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AudioTracksTableOrderingComposer(
            $db: $db,
            $table: $db.audioTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AudioTrackDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $AudioTrackDataTable> {
  $$AudioTrackDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<Uint8List> get bytes =>
      $composableBuilder(column: $table.bytes, builder: (column) => column);

  $$AudioTracksTableAnnotationComposer get trackId {
    final $$AudioTracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.audioTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AudioTracksTableAnnotationComposer(
            $db: $db,
            $table: $db.audioTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AudioTrackDataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AudioTrackDataTable,
          AudioTrackDataData,
          $$AudioTrackDataTableFilterComposer,
          $$AudioTrackDataTableOrderingComposer,
          $$AudioTrackDataTableAnnotationComposer,
          $$AudioTrackDataTableCreateCompanionBuilder,
          $$AudioTrackDataTableUpdateCompanionBuilder,
          (AudioTrackDataData, $$AudioTrackDataTableReferences),
          AudioTrackDataData,
          PrefetchHooks Function({bool trackId})
        > {
  $$AudioTrackDataTableTableManager(
    _$AppDatabase db,
    $AudioTrackDataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AudioTrackDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AudioTrackDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AudioTrackDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> trackId = const Value.absent(),
                Value<Uint8List> bytes = const Value.absent(),
              }) => AudioTrackDataCompanion(
                id: id,
                trackId: trackId,
                bytes: bytes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int trackId,
                required Uint8List bytes,
              }) => AudioTrackDataCompanion.insert(
                id: id,
                trackId: trackId,
                bytes: bytes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AudioTrackDataTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackId = false}) {
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
                    if (trackId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trackId,
                                referencedTable: $$AudioTrackDataTableReferences
                                    ._trackIdTable(db),
                                referencedColumn:
                                    $$AudioTrackDataTableReferences
                                        ._trackIdTable(db)
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

typedef $$AudioTrackDataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AudioTrackDataTable,
      AudioTrackDataData,
      $$AudioTrackDataTableFilterComposer,
      $$AudioTrackDataTableOrderingComposer,
      $$AudioTrackDataTableAnnotationComposer,
      $$AudioTrackDataTableCreateCompanionBuilder,
      $$AudioTrackDataTableUpdateCompanionBuilder,
      (AudioTrackDataData, $$AudioTrackDataTableReferences),
      AudioTrackDataData,
      PrefetchHooks Function({bool trackId})
    >;
typedef $$BeatmapsTableCreateCompanionBuilder =
    BeatmapsCompanion Function({
      Value<int> id,
      required int trackId,
      required String title,
      required String difficultyName,
      Value<int?> difficultyLevel,
      Value<int> audioOffsetMs,
      Value<double> baseBpm,
      Value<double> scrollSpeed,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$BeatmapsTableUpdateCompanionBuilder =
    BeatmapsCompanion Function({
      Value<int> id,
      Value<int> trackId,
      Value<String> title,
      Value<String> difficultyName,
      Value<int?> difficultyLevel,
      Value<int> audioOffsetMs,
      Value<double> baseBpm,
      Value<double> scrollSpeed,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$BeatmapsTableReferences
    extends BaseReferences<_$AppDatabase, $BeatmapsTable, Beatmap> {
  $$BeatmapsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AudioTracksTable _trackIdTable(_$AppDatabase db) =>
      db.audioTracks.createAlias(
        $_aliasNameGenerator(db.beatmaps.trackId, db.audioTracks.id),
      );

  $$AudioTracksTableProcessedTableManager get trackId {
    final $_column = $_itemColumn<int>('track_id')!;

    final manager = $$AudioTracksTableTableManager(
      $_db,
      $_db.audioTracks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TimingPointsTable, List<TimingPoint>>
  _timingPointsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timingPoints,
    aliasName: $_aliasNameGenerator(db.beatmaps.id, db.timingPoints.beatmapId),
  );

  $$TimingPointsTableProcessedTableManager get timingPointsRefs {
    final manager = $$TimingPointsTableTableManager(
      $_db,
      $_db.timingPoints,
    ).filter((f) => f.beatmapId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_timingPointsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BeatmapNotesTable, List<BeatmapNote>>
  _beatmapNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.beatmapNotes,
    aliasName: $_aliasNameGenerator(db.beatmaps.id, db.beatmapNotes.beatmapId),
  );

  $$BeatmapNotesTableProcessedTableManager get beatmapNotesRefs {
    final manager = $$BeatmapNotesTableTableManager(
      $_db,
      $_db.beatmapNotes,
    ).filter((f) => f.beatmapId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_beatmapNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BeatmapsTableFilterComposer
    extends Composer<_$AppDatabase, $BeatmapsTable> {
  $$BeatmapsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficultyName => $composableBuilder(
    column: $table.difficultyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get difficultyLevel => $composableBuilder(
    column: $table.difficultyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get audioOffsetMs => $composableBuilder(
    column: $table.audioOffsetMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get baseBpm => $composableBuilder(
    column: $table.baseBpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get scrollSpeed => $composableBuilder(
    column: $table.scrollSpeed,
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

  $$AudioTracksTableFilterComposer get trackId {
    final $$AudioTracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.audioTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AudioTracksTableFilterComposer(
            $db: $db,
            $table: $db.audioTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> timingPointsRefs(
    Expression<bool> Function($$TimingPointsTableFilterComposer f) f,
  ) {
    final $$TimingPointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timingPoints,
      getReferencedColumn: (t) => t.beatmapId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimingPointsTableFilterComposer(
            $db: $db,
            $table: $db.timingPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> beatmapNotesRefs(
    Expression<bool> Function($$BeatmapNotesTableFilterComposer f) f,
  ) {
    final $$BeatmapNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beatmapNotes,
      getReferencedColumn: (t) => t.beatmapId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeatmapNotesTableFilterComposer(
            $db: $db,
            $table: $db.beatmapNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BeatmapsTableOrderingComposer
    extends Composer<_$AppDatabase, $BeatmapsTable> {
  $$BeatmapsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficultyName => $composableBuilder(
    column: $table.difficultyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficultyLevel => $composableBuilder(
    column: $table.difficultyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get audioOffsetMs => $composableBuilder(
    column: $table.audioOffsetMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get baseBpm => $composableBuilder(
    column: $table.baseBpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get scrollSpeed => $composableBuilder(
    column: $table.scrollSpeed,
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

  $$AudioTracksTableOrderingComposer get trackId {
    final $$AudioTracksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.audioTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AudioTracksTableOrderingComposer(
            $db: $db,
            $table: $db.audioTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BeatmapsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BeatmapsTable> {
  $$BeatmapsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get difficultyName => $composableBuilder(
    column: $table.difficultyName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get difficultyLevel => $composableBuilder(
    column: $table.difficultyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get audioOffsetMs => $composableBuilder(
    column: $table.audioOffsetMs,
    builder: (column) => column,
  );

  GeneratedColumn<double> get baseBpm =>
      $composableBuilder(column: $table.baseBpm, builder: (column) => column);

  GeneratedColumn<double> get scrollSpeed => $composableBuilder(
    column: $table.scrollSpeed,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AudioTracksTableAnnotationComposer get trackId {
    final $$AudioTracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.audioTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AudioTracksTableAnnotationComposer(
            $db: $db,
            $table: $db.audioTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> timingPointsRefs<T extends Object>(
    Expression<T> Function($$TimingPointsTableAnnotationComposer a) f,
  ) {
    final $$TimingPointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timingPoints,
      getReferencedColumn: (t) => t.beatmapId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimingPointsTableAnnotationComposer(
            $db: $db,
            $table: $db.timingPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> beatmapNotesRefs<T extends Object>(
    Expression<T> Function($$BeatmapNotesTableAnnotationComposer a) f,
  ) {
    final $$BeatmapNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.beatmapNotes,
      getReferencedColumn: (t) => t.beatmapId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeatmapNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.beatmapNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BeatmapsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BeatmapsTable,
          Beatmap,
          $$BeatmapsTableFilterComposer,
          $$BeatmapsTableOrderingComposer,
          $$BeatmapsTableAnnotationComposer,
          $$BeatmapsTableCreateCompanionBuilder,
          $$BeatmapsTableUpdateCompanionBuilder,
          (Beatmap, $$BeatmapsTableReferences),
          Beatmap,
          PrefetchHooks Function({
            bool trackId,
            bool timingPointsRefs,
            bool beatmapNotesRefs,
          })
        > {
  $$BeatmapsTableTableManager(_$AppDatabase db, $BeatmapsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BeatmapsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BeatmapsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BeatmapsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> trackId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> difficultyName = const Value.absent(),
                Value<int?> difficultyLevel = const Value.absent(),
                Value<int> audioOffsetMs = const Value.absent(),
                Value<double> baseBpm = const Value.absent(),
                Value<double> scrollSpeed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BeatmapsCompanion(
                id: id,
                trackId: trackId,
                title: title,
                difficultyName: difficultyName,
                difficultyLevel: difficultyLevel,
                audioOffsetMs: audioOffsetMs,
                baseBpm: baseBpm,
                scrollSpeed: scrollSpeed,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int trackId,
                required String title,
                required String difficultyName,
                Value<int?> difficultyLevel = const Value.absent(),
                Value<int> audioOffsetMs = const Value.absent(),
                Value<double> baseBpm = const Value.absent(),
                Value<double> scrollSpeed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BeatmapsCompanion.insert(
                id: id,
                trackId: trackId,
                title: title,
                difficultyName: difficultyName,
                difficultyLevel: difficultyLevel,
                audioOffsetMs: audioOffsetMs,
                baseBpm: baseBpm,
                scrollSpeed: scrollSpeed,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BeatmapsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                trackId = false,
                timingPointsRefs = false,
                beatmapNotesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (timingPointsRefs) db.timingPoints,
                    if (beatmapNotesRefs) db.beatmapNotes,
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
                        if (trackId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.trackId,
                                    referencedTable: $$BeatmapsTableReferences
                                        ._trackIdTable(db),
                                    referencedColumn: $$BeatmapsTableReferences
                                        ._trackIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (timingPointsRefs)
                        await $_getPrefetchedData<
                          Beatmap,
                          $BeatmapsTable,
                          TimingPoint
                        >(
                          currentTable: table,
                          referencedTable: $$BeatmapsTableReferences
                              ._timingPointsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BeatmapsTableReferences(
                                db,
                                table,
                                p0,
                              ).timingPointsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.beatmapId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (beatmapNotesRefs)
                        await $_getPrefetchedData<
                          Beatmap,
                          $BeatmapsTable,
                          BeatmapNote
                        >(
                          currentTable: table,
                          referencedTable: $$BeatmapsTableReferences
                              ._beatmapNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BeatmapsTableReferences(
                                db,
                                table,
                                p0,
                              ).beatmapNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.beatmapId == item.id,
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

typedef $$BeatmapsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BeatmapsTable,
      Beatmap,
      $$BeatmapsTableFilterComposer,
      $$BeatmapsTableOrderingComposer,
      $$BeatmapsTableAnnotationComposer,
      $$BeatmapsTableCreateCompanionBuilder,
      $$BeatmapsTableUpdateCompanionBuilder,
      (Beatmap, $$BeatmapsTableReferences),
      Beatmap,
      PrefetchHooks Function({
        bool trackId,
        bool timingPointsRefs,
        bool beatmapNotesRefs,
      })
    >;
typedef $$TimingPointsTableCreateCompanionBuilder =
    TimingPointsCompanion Function({
      Value<int> id,
      required int beatmapId,
      required int timeMs,
      required double bpm,
      Value<int> meter,
      Value<bool> inherited,
    });
typedef $$TimingPointsTableUpdateCompanionBuilder =
    TimingPointsCompanion Function({
      Value<int> id,
      Value<int> beatmapId,
      Value<int> timeMs,
      Value<double> bpm,
      Value<int> meter,
      Value<bool> inherited,
    });

final class $$TimingPointsTableReferences
    extends BaseReferences<_$AppDatabase, $TimingPointsTable, TimingPoint> {
  $$TimingPointsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BeatmapsTable _beatmapIdTable(_$AppDatabase db) =>
      db.beatmaps.createAlias(
        $_aliasNameGenerator(db.timingPoints.beatmapId, db.beatmaps.id),
      );

  $$BeatmapsTableProcessedTableManager get beatmapId {
    final $_column = $_itemColumn<int>('beatmap_id')!;

    final manager = $$BeatmapsTableTableManager(
      $_db,
      $_db.beatmaps,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beatmapIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TimingPointsTableFilterComposer
    extends Composer<_$AppDatabase, $TimingPointsTable> {
  $$TimingPointsTableFilterComposer({
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

  ColumnFilters<int> get timeMs => $composableBuilder(
    column: $table.timeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bpm => $composableBuilder(
    column: $table.bpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get meter => $composableBuilder(
    column: $table.meter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get inherited => $composableBuilder(
    column: $table.inherited,
    builder: (column) => ColumnFilters(column),
  );

  $$BeatmapsTableFilterComposer get beatmapId {
    final $$BeatmapsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beatmapId,
      referencedTable: $db.beatmaps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeatmapsTableFilterComposer(
            $db: $db,
            $table: $db.beatmaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimingPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $TimingPointsTable> {
  $$TimingPointsTableOrderingComposer({
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

  ColumnOrderings<int> get timeMs => $composableBuilder(
    column: $table.timeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bpm => $composableBuilder(
    column: $table.bpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get meter => $composableBuilder(
    column: $table.meter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get inherited => $composableBuilder(
    column: $table.inherited,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeatmapsTableOrderingComposer get beatmapId {
    final $$BeatmapsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beatmapId,
      referencedTable: $db.beatmaps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeatmapsTableOrderingComposer(
            $db: $db,
            $table: $db.beatmaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimingPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimingPointsTable> {
  $$TimingPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get timeMs =>
      $composableBuilder(column: $table.timeMs, builder: (column) => column);

  GeneratedColumn<double> get bpm =>
      $composableBuilder(column: $table.bpm, builder: (column) => column);

  GeneratedColumn<int> get meter =>
      $composableBuilder(column: $table.meter, builder: (column) => column);

  GeneratedColumn<bool> get inherited =>
      $composableBuilder(column: $table.inherited, builder: (column) => column);

  $$BeatmapsTableAnnotationComposer get beatmapId {
    final $$BeatmapsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beatmapId,
      referencedTable: $db.beatmaps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeatmapsTableAnnotationComposer(
            $db: $db,
            $table: $db.beatmaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimingPointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimingPointsTable,
          TimingPoint,
          $$TimingPointsTableFilterComposer,
          $$TimingPointsTableOrderingComposer,
          $$TimingPointsTableAnnotationComposer,
          $$TimingPointsTableCreateCompanionBuilder,
          $$TimingPointsTableUpdateCompanionBuilder,
          (TimingPoint, $$TimingPointsTableReferences),
          TimingPoint,
          PrefetchHooks Function({bool beatmapId})
        > {
  $$TimingPointsTableTableManager(_$AppDatabase db, $TimingPointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimingPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimingPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimingPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> beatmapId = const Value.absent(),
                Value<int> timeMs = const Value.absent(),
                Value<double> bpm = const Value.absent(),
                Value<int> meter = const Value.absent(),
                Value<bool> inherited = const Value.absent(),
              }) => TimingPointsCompanion(
                id: id,
                beatmapId: beatmapId,
                timeMs: timeMs,
                bpm: bpm,
                meter: meter,
                inherited: inherited,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int beatmapId,
                required int timeMs,
                required double bpm,
                Value<int> meter = const Value.absent(),
                Value<bool> inherited = const Value.absent(),
              }) => TimingPointsCompanion.insert(
                id: id,
                beatmapId: beatmapId,
                timeMs: timeMs,
                bpm: bpm,
                meter: meter,
                inherited: inherited,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TimingPointsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({beatmapId = false}) {
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
                    if (beatmapId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.beatmapId,
                                referencedTable: $$TimingPointsTableReferences
                                    ._beatmapIdTable(db),
                                referencedColumn: $$TimingPointsTableReferences
                                    ._beatmapIdTable(db)
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

typedef $$TimingPointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimingPointsTable,
      TimingPoint,
      $$TimingPointsTableFilterComposer,
      $$TimingPointsTableOrderingComposer,
      $$TimingPointsTableAnnotationComposer,
      $$TimingPointsTableCreateCompanionBuilder,
      $$TimingPointsTableUpdateCompanionBuilder,
      (TimingPoint, $$TimingPointsTableReferences),
      TimingPoint,
      PrefetchHooks Function({bool beatmapId})
    >;
typedef $$BeatmapNotesTableCreateCompanionBuilder =
    BeatmapNotesCompanion Function({
      Value<int> id,
      required int beatmapId,
      required int timeMs,
      required int lane,
      required String type,
      Value<int?> durationMs,
      Value<String?> direction,
      Value<double?> positionX,
      Value<double?> positionY,
    });
typedef $$BeatmapNotesTableUpdateCompanionBuilder =
    BeatmapNotesCompanion Function({
      Value<int> id,
      Value<int> beatmapId,
      Value<int> timeMs,
      Value<int> lane,
      Value<String> type,
      Value<int?> durationMs,
      Value<String?> direction,
      Value<double?> positionX,
      Value<double?> positionY,
    });

final class $$BeatmapNotesTableReferences
    extends BaseReferences<_$AppDatabase, $BeatmapNotesTable, BeatmapNote> {
  $$BeatmapNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BeatmapsTable _beatmapIdTable(_$AppDatabase db) =>
      db.beatmaps.createAlias(
        $_aliasNameGenerator(db.beatmapNotes.beatmapId, db.beatmaps.id),
      );

  $$BeatmapsTableProcessedTableManager get beatmapId {
    final $_column = $_itemColumn<int>('beatmap_id')!;

    final manager = $$BeatmapsTableTableManager(
      $_db,
      $_db.beatmaps,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beatmapIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BeatmapNotesTableFilterComposer
    extends Composer<_$AppDatabase, $BeatmapNotesTable> {
  $$BeatmapNotesTableFilterComposer({
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

  ColumnFilters<int> get timeMs => $composableBuilder(
    column: $table.timeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lane => $composableBuilder(
    column: $table.lane,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get positionX => $composableBuilder(
    column: $table.positionX,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get positionY => $composableBuilder(
    column: $table.positionY,
    builder: (column) => ColumnFilters(column),
  );

  $$BeatmapsTableFilterComposer get beatmapId {
    final $$BeatmapsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beatmapId,
      referencedTable: $db.beatmaps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeatmapsTableFilterComposer(
            $db: $db,
            $table: $db.beatmaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BeatmapNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $BeatmapNotesTable> {
  $$BeatmapNotesTableOrderingComposer({
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

  ColumnOrderings<int> get timeMs => $composableBuilder(
    column: $table.timeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lane => $composableBuilder(
    column: $table.lane,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get positionX => $composableBuilder(
    column: $table.positionX,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get positionY => $composableBuilder(
    column: $table.positionY,
    builder: (column) => ColumnOrderings(column),
  );

  $$BeatmapsTableOrderingComposer get beatmapId {
    final $$BeatmapsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beatmapId,
      referencedTable: $db.beatmaps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeatmapsTableOrderingComposer(
            $db: $db,
            $table: $db.beatmaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BeatmapNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BeatmapNotesTable> {
  $$BeatmapNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get timeMs =>
      $composableBuilder(column: $table.timeMs, builder: (column) => column);

  GeneratedColumn<int> get lane =>
      $composableBuilder(column: $table.lane, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<double> get positionX =>
      $composableBuilder(column: $table.positionX, builder: (column) => column);

  GeneratedColumn<double> get positionY =>
      $composableBuilder(column: $table.positionY, builder: (column) => column);

  $$BeatmapsTableAnnotationComposer get beatmapId {
    final $$BeatmapsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beatmapId,
      referencedTable: $db.beatmaps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BeatmapsTableAnnotationComposer(
            $db: $db,
            $table: $db.beatmaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BeatmapNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BeatmapNotesTable,
          BeatmapNote,
          $$BeatmapNotesTableFilterComposer,
          $$BeatmapNotesTableOrderingComposer,
          $$BeatmapNotesTableAnnotationComposer,
          $$BeatmapNotesTableCreateCompanionBuilder,
          $$BeatmapNotesTableUpdateCompanionBuilder,
          (BeatmapNote, $$BeatmapNotesTableReferences),
          BeatmapNote,
          PrefetchHooks Function({bool beatmapId})
        > {
  $$BeatmapNotesTableTableManager(_$AppDatabase db, $BeatmapNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BeatmapNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BeatmapNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BeatmapNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> beatmapId = const Value.absent(),
                Value<int> timeMs = const Value.absent(),
                Value<int> lane = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                Value<String?> direction = const Value.absent(),
                Value<double?> positionX = const Value.absent(),
                Value<double?> positionY = const Value.absent(),
              }) => BeatmapNotesCompanion(
                id: id,
                beatmapId: beatmapId,
                timeMs: timeMs,
                lane: lane,
                type: type,
                durationMs: durationMs,
                direction: direction,
                positionX: positionX,
                positionY: positionY,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int beatmapId,
                required int timeMs,
                required int lane,
                required String type,
                Value<int?> durationMs = const Value.absent(),
                Value<String?> direction = const Value.absent(),
                Value<double?> positionX = const Value.absent(),
                Value<double?> positionY = const Value.absent(),
              }) => BeatmapNotesCompanion.insert(
                id: id,
                beatmapId: beatmapId,
                timeMs: timeMs,
                lane: lane,
                type: type,
                durationMs: durationMs,
                direction: direction,
                positionX: positionX,
                positionY: positionY,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BeatmapNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({beatmapId = false}) {
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
                    if (beatmapId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.beatmapId,
                                referencedTable: $$BeatmapNotesTableReferences
                                    ._beatmapIdTable(db),
                                referencedColumn: $$BeatmapNotesTableReferences
                                    ._beatmapIdTable(db)
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

typedef $$BeatmapNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BeatmapNotesTable,
      BeatmapNote,
      $$BeatmapNotesTableFilterComposer,
      $$BeatmapNotesTableOrderingComposer,
      $$BeatmapNotesTableAnnotationComposer,
      $$BeatmapNotesTableCreateCompanionBuilder,
      $$BeatmapNotesTableUpdateCompanionBuilder,
      (BeatmapNote, $$BeatmapNotesTableReferences),
      BeatmapNote,
      PrefetchHooks Function({bool beatmapId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AudioTracksTableTableManager get audioTracks =>
      $$AudioTracksTableTableManager(_db, _db.audioTracks);
  $$TrackCategoriesTableTableManager get trackCategories =>
      $$TrackCategoriesTableTableManager(_db, _db.trackCategories);
  $$TrackCategoryLinksTableTableManager get trackCategoryLinks =>
      $$TrackCategoryLinksTableTableManager(_db, _db.trackCategoryLinks);
  $$AudioTrackDataTableTableManager get audioTrackData =>
      $$AudioTrackDataTableTableManager(_db, _db.audioTrackData);
  $$BeatmapsTableTableManager get beatmaps =>
      $$BeatmapsTableTableManager(_db, _db.beatmaps);
  $$TimingPointsTableTableManager get timingPoints =>
      $$TimingPointsTableTableManager(_db, _db.timingPoints);
  $$BeatmapNotesTableTableManager get beatmapNotes =>
      $$BeatmapNotesTableTableManager(_db, _db.beatmapNotes);
}
