// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SearchHistorie extends DataClass implements Insertable<SearchHistorie> {
  final int id;
  final String request;
  SearchHistorie({required this.id, required this.request});
  factory SearchHistorie.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SearchHistorie(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      request: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}request'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['request'] = Variable<String>(request);
    return map;
  }

  SearchHistoriesCompanion toCompanion(bool nullToAbsent) {
    return SearchHistoriesCompanion(
      id: Value(id),
      request: Value(request),
    );
  }

  factory SearchHistorie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistorie(
      id: serializer.fromJson<int>(json['id']),
      request: serializer.fromJson<String>(json['request']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'request': serializer.toJson<String>(request),
    };
  }

  SearchHistorie copyWith({int? id, String? request}) => SearchHistorie(
        id: id ?? this.id,
        request: request ?? this.request,
      );
  @override
  String toString() {
    return (StringBuffer('SearchHistorie(')
          ..write('id: $id, ')
          ..write('request: $request')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, request);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistorie &&
          other.id == this.id &&
          other.request == this.request);
}

class SearchHistoriesCompanion extends UpdateCompanion<SearchHistorie> {
  final Value<int> id;
  final Value<String> request;
  const SearchHistoriesCompanion({
    this.id = const Value.absent(),
    this.request = const Value.absent(),
  });
  SearchHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required String request,
  }) : request = Value(request);
  static Insertable<SearchHistorie> custom({
    Expression<int>? id,
    Expression<String>? request,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (request != null) 'request': request,
    });
  }

  SearchHistoriesCompanion copyWith({Value<int>? id, Value<String>? request}) {
    return SearchHistoriesCompanion(
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (request.present) {
      map['request'] = Variable<String>(request.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('request: $request')
          ..write(')'))
        .toString();
  }
}

class $SearchHistoriesTable extends SearchHistories
    with TableInfo<$SearchHistoriesTable, SearchHistorie> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SearchHistoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _requestMeta = const VerificationMeta('request');
  @override
  late final GeneratedColumn<String?> request = GeneratedColumn<String?>(
      'request', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE');
  @override
  List<GeneratedColumn> get $columns => [id, request];
  @override
  String get aliasedName => _alias ?? 'search_histories';
  @override
  String get actualTableName => 'search_histories';
  @override
  VerificationContext validateIntegrity(Insertable<SearchHistorie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('request')) {
      context.handle(_requestMeta,
          request.isAcceptableOrUnknown(data['request']!, _requestMeta));
    } else if (isInserting) {
      context.missing(_requestMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistorie map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SearchHistorie.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SearchHistoriesTable createAlias(String alias) {
    return $SearchHistoriesTable(_db, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SearchHistoriesTable searchHistories =
      $SearchHistoriesTable(this);
  late final SearchHistoriesDao searchHistoriesDao =
      SearchHistoriesDao(this as LocalDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [searchHistories];
}
