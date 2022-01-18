import 'package:drift/drift.dart';

class SearchHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get request => text().customConstraint('UNIQUE')();
}
