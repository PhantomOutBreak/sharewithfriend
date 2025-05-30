import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'boon_dao.dart';
import 'boon_entity.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [BoonEntity])
abstract class AppDatabase extends FloorDatabase {
  BoonDao get boonDao;
}
