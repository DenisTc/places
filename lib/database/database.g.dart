// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CachedPlace extends DataClass implements Insertable<CachedPlace> {
  final int id;
  final Place? place;
  CachedPlace({required this.id, this.place});
  factory CachedPlace.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CachedPlace(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      place: $CachedPlacesTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || place != null) {
      final converter = $CachedPlacesTable.$converter0;
      map['place'] = Variable<String?>(converter.mapToSql(place));
    }
    return map;
  }

  CachedPlacesCompanion toCompanion(bool nullToAbsent) {
    return CachedPlacesCompanion(
      id: Value(id),
      place:
          place == null && nullToAbsent ? const Value.absent() : Value(place),
    );
  }

  factory CachedPlace.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedPlace(
      id: serializer.fromJson<int>(json['id']),
      place: serializer.fromJson<Place?>(json['place']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'place': serializer.toJson<Place?>(place),
    };
  }

  CachedPlace copyWith({int? id, Place? place}) => CachedPlace(
        id: id ?? this.id,
        place: place ?? this.place,
      );
  @override
  String toString() {
    return (StringBuffer('CachedPlace(')
          ..write('id: $id, ')
          ..write('place: $place')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, place);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedPlace &&
          other.id == this.id &&
          other.place == this.place);
}

class CachedPlacesCompanion extends UpdateCompanion<CachedPlace> {
  final Value<int> id;
  final Value<Place?> place;
  const CachedPlacesCompanion({
    this.id = const Value.absent(),
    this.place = const Value.absent(),
  });
  CachedPlacesCompanion.insert({
    this.id = const Value.absent(),
    this.place = const Value.absent(),
  });
  static Insertable<CachedPlace> custom({
    Expression<int>? id,
    Expression<Place?>? place,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (place != null) 'place': place,
    });
  }

  CachedPlacesCompanion copyWith({Value<int>? id, Value<Place?>? place}) {
    return CachedPlacesCompanion(
      id: id ?? this.id,
      place: place ?? this.place,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (place.present) {
      final converter = $CachedPlacesTable.$converter0;
      map['place'] = Variable<String?>(converter.mapToSql(place.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedPlacesCompanion(')
          ..write('id: $id, ')
          ..write('place: $place')
          ..write(')'))
        .toString();
  }
}

class $CachedPlacesTable extends CachedPlaces
    with TableInfo<$CachedPlacesTable, CachedPlace> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CachedPlacesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _placeMeta = const VerificationMeta('place');
  @override
  late final GeneratedColumnWithTypeConverter<Place, String?> place =
      GeneratedColumn<String?>('place', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<Place>($CachedPlacesTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, place];
  @override
  String get aliasedName => _alias ?? 'cached_places';
  @override
  String get actualTableName => 'cached_places';
  @override
  VerificationContext validateIntegrity(Insertable<CachedPlace> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_placeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedPlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CachedPlace.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CachedPlacesTable createAlias(String alias) {
    return $CachedPlacesTable(_db, alias);
  }

  static TypeConverter<Place, String> $converter0 = const PlaceConverter();
}

class FavoritePlace extends DataClass implements Insertable<FavoritePlace> {
  final int placeId;
  FavoritePlace({required this.placeId});
  factory FavoritePlace.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoritePlace(
      placeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['place_id'] = Variable<int>(placeId);
    return map;
  }

  FavoritePlacesCompanion toCompanion(bool nullToAbsent) {
    return FavoritePlacesCompanion(
      placeId: Value(placeId),
    );
  }

  factory FavoritePlace.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritePlace(
      placeId: serializer.fromJson<int>(json['placeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'placeId': serializer.toJson<int>(placeId),
    };
  }

  FavoritePlace copyWith({int? placeId}) => FavoritePlace(
        placeId: placeId ?? this.placeId,
      );
  @override
  String toString() {
    return (StringBuffer('FavoritePlace(')
          ..write('placeId: $placeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => placeId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritePlace && other.placeId == this.placeId);
}

class FavoritePlacesCompanion extends UpdateCompanion<FavoritePlace> {
  final Value<int> placeId;
  const FavoritePlacesCompanion({
    this.placeId = const Value.absent(),
  });
  FavoritePlacesCompanion.insert({
    this.placeId = const Value.absent(),
  });
  static Insertable<FavoritePlace> custom({
    Expression<int>? placeId,
  }) {
    return RawValuesInsertable({
      if (placeId != null) 'place_id': placeId,
    });
  }

  FavoritePlacesCompanion copyWith({Value<int>? placeId}) {
    return FavoritePlacesCompanion(
      placeId: placeId ?? this.placeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePlacesCompanion(')
          ..write('placeId: $placeId')
          ..write(')'))
        .toString();
  }
}

class $FavoritePlacesTable extends FavoritePlaces
    with TableInfo<$FavoritePlacesTable, FavoritePlace> {
  final GeneratedDatabase _db;
  final String? _alias;
  $FavoritePlacesTable(this._db, [this._alias]);
  final VerificationMeta _placeIdMeta = const VerificationMeta('placeId');
  @override
  late final GeneratedColumn<int?> placeId = GeneratedColumn<int?>(
      'place_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [placeId];
  @override
  String get aliasedName => _alias ?? 'favorite_places';
  @override
  String get actualTableName => 'favorite_places';
  @override
  VerificationContext validateIntegrity(Insertable<FavoritePlace> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {placeId};
  @override
  FavoritePlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FavoritePlace.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoritePlacesTable createAlias(String alias) {
    return $FavoritePlacesTable(_db, alias);
  }
}

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

class VisitedPlace extends DataClass implements Insertable<VisitedPlace> {
  final int placeId;
  final DateTime date;
  VisitedPlace({required this.placeId, required this.date});
  factory VisitedPlace.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return VisitedPlace(
      placeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_id'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['place_id'] = Variable<int>(placeId);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  VisitedPlacesCompanion toCompanion(bool nullToAbsent) {
    return VisitedPlacesCompanion(
      placeId: Value(placeId),
      date: Value(date),
    );
  }

  factory VisitedPlace.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VisitedPlace(
      placeId: serializer.fromJson<int>(json['placeId']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'placeId': serializer.toJson<int>(placeId),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  VisitedPlace copyWith({int? placeId, DateTime? date}) => VisitedPlace(
        placeId: placeId ?? this.placeId,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('VisitedPlace(')
          ..write('placeId: $placeId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(placeId, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VisitedPlace &&
          other.placeId == this.placeId &&
          other.date == this.date);
}

class VisitedPlacesCompanion extends UpdateCompanion<VisitedPlace> {
  final Value<int> placeId;
  final Value<DateTime> date;
  const VisitedPlacesCompanion({
    this.placeId = const Value.absent(),
    this.date = const Value.absent(),
  });
  VisitedPlacesCompanion.insert({
    this.placeId = const Value.absent(),
    required DateTime date,
  }) : date = Value(date);
  static Insertable<VisitedPlace> custom({
    Expression<int>? placeId,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (placeId != null) 'place_id': placeId,
      if (date != null) 'date': date,
    });
  }

  VisitedPlacesCompanion copyWith(
      {Value<int>? placeId, Value<DateTime>? date}) {
    return VisitedPlacesCompanion(
      placeId: placeId ?? this.placeId,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitedPlacesCompanion(')
          ..write('placeId: $placeId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $VisitedPlacesTable extends VisitedPlaces
    with TableInfo<$VisitedPlacesTable, VisitedPlace> {
  final GeneratedDatabase _db;
  final String? _alias;
  $VisitedPlacesTable(this._db, [this._alias]);
  final VerificationMeta _placeIdMeta = const VerificationMeta('placeId');
  @override
  late final GeneratedColumn<int?> placeId = GeneratedColumn<int?>(
      'place_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [placeId, date];
  @override
  String get aliasedName => _alias ?? 'visited_places';
  @override
  String get actualTableName => 'visited_places';
  @override
  VerificationContext validateIntegrity(Insertable<VisitedPlace> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {placeId};
  @override
  VisitedPlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    return VisitedPlace.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VisitedPlacesTable createAlias(String alias) {
    return $VisitedPlacesTable(_db, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CachedPlacesTable cachedPlaces = $CachedPlacesTable(this);
  late final $FavoritePlacesTable favoritePlaces = $FavoritePlacesTable(this);
  late final $SearchHistoriesTable searchHistories =
      $SearchHistoriesTable(this);
  late final $VisitedPlacesTable visitedPlaces = $VisitedPlacesTable(this);
  late final CachedPlacesDao cachedPlacesDao =
      CachedPlacesDao(this as LocalDatabase);
  late final FavoritePlacesDao favoritePlacesDao =
      FavoritePlacesDao(this as LocalDatabase);
  late final SearchHistoriesDao searchHistoriesDao =
      SearchHistoriesDao(this as LocalDatabase);
  late final VisitedPlacesDao visitedPlacesDao =
      VisitedPlacesDao(this as LocalDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [cachedPlaces, favoritePlaces, searchHistories, visitedPlaces];
}
