// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:yess_nutrition/data/models/schedule_models/nutritime_info.dart';
import 'package:sqflite/sqflite.dart'
    show Database, getDatabasesPath, openDatabase;

const String tableAlarm = 'alarm';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnDateTime = 'alarmDateTime';
const String columnPending = 'isPending';
const String columnColorIndex = 'gradientColorIndex';

class NutriTimeHelper {
  static Database? _database;
  static NutriTimeHelper? _nutriTimeHelper;

  NutriTimeHelper._createInstance();
  factory NutriTimeHelper() {
    _nutriTimeHelper ??= NutriTimeHelper._createInstance();
    return _nutriTimeHelper!;
  }

  Future<Database?> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = "${dir}nutritime.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm(
            $columnId integer primary key autoincrement,
            $columnTitle text not null,
            $columnDateTime text not null,
            $columnPending integer,
            $columnColorIndex integer)
            ''');
      },
    );
    return database;
  }

  void insertAlarm(NutriTimeInfo alarmInfo) async {
    var db = await database;
    var result = await db!.insert(tableAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  Future<List<NutriTimeInfo>> getAlarms() async {
    List<NutriTimeInfo> alarms = [];

    var db = await database;
    var result = await db!.query(tableAlarm);
    for (var element in result) {
      var alarmInfo = NutriTimeInfo.fromMap(element);
      alarms.add(alarmInfo);
    }

    return alarms;
  }

  Future<int> delete(int id) async {
    var db = await database;
    return await db!
        .delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
}
