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
  @override
  List<GeneratedColumn> get $columns => [id, name];
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
  const TrackCategory({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TrackCategoriesCompanion toCompanion(bool nullToAbsent) {
    return TrackCategoriesCompanion(id: Value(id), name: Value(name));
  }

  factory TrackCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackCategory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  TrackCategory copyWith({int? id, String? name}) =>
      TrackCategory(id: id ?? this.id, name: name ?? this.name);
  TrackCategory copyWithCompanion(TrackCategoriesCompanion data) {
    return TrackCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackCategory(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackCategory &&
          other.id == this.id &&
          other.name == this.name);
}

class TrackCategoriesCompanion extends UpdateCompanion<TrackCategory> {
  final Value<int> id;
  final Value<String> name;
  const TrackCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TrackCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<TrackCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  TrackCategoriesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return TrackCategoriesCompanion(id: id ?? this.id, name: name ?? this.name);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
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
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    audioTracks,
    trackCategories,
    trackCategoryLinks,
    audioTrackData,
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
  ]);
}

typedef $$AudioTracksTableCreateCompanionBuilder =
    AudioTracksCompanion Function({
      Value<int> id,
      required String displayName,
      required String fileName,
      required String extension,
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
              ({trackCategoryLinksRefs = false, audioTrackDataRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (trackCategoryLinksRefs) db.trackCategoryLinks,
                    if (audioTrackDataRefs) db.audioTrackData,
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
      })
    >;
typedef $$TrackCategoriesTableCreateCompanionBuilder =
    TrackCategoriesCompanion Function({Value<int> id, required String name});
typedef $$TrackCategoriesTableUpdateCompanionBuilder =
    TrackCategoriesCompanion Function({Value<int> id, Value<String> name});

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
              }) => TrackCategoriesCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  TrackCategoriesCompanion.insert(id: id, name: name),
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
}
