import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/data/models/news_models/news_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  late Database _database;

  Future<Database> get database async {
    _database = await _initializeDb('yess_nutrition.db');

    return _database;
  }

  /// Initialize, create, and open database
  Future<Database> _initializeDb(String file) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, file);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      password: Utilities.encryptText('yess_nutrition_db'),
    );
  }

  /// Create database table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $newsBookmarksTable (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        uid TEXT,
        title TEXT,
        description TEXT,
        url TEXT UNIQUE,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT,
        author TEXT,
        source TEXT)
        ''');
  }

  /// added [news] to bookmarks table
  Future<int> createBookmark(NewsTable news) async {
    final db = await database;

    final id = await db.insert(newsBookmarksTable, news.toMap());

    return id;
  }

  /// get all news at bookmarks table, according to [uid]
  Future<List<NewsTable>> getBookmarks(String uid) async {
    final db = await database;

    final result = await db.query(
      newsBookmarksTable,
      where: 'uid = ?',
      whereArgs: [uid],
      orderBy: '_id DESC',
    );

    final news = List<NewsTable>.from(
      result.map((bookmark) => NewsTable.fromMap(bookmark)),
    );

    return news;
  }

  /// check whether [news] is already in bookmarks table
  Future<bool> isBookmarkExist(NewsTable news) async {
    final db = await database;

    final result = await db.query(
      newsBookmarksTable,
      where: 'uid = ? AND url = ?',
      whereArgs: [news.uid, news.url],
    );

    if (result.isNotEmpty) return Future.value(true);

    return Future.value(false);
  }

  /// delete [news] from bookmarks table
  Future<int> deleteBookmark(NewsTable news) async {
    final db = await database;

    final count = await db.delete(
      newsBookmarksTable,
      where: 'uid = ? AND url = ?',
      whereArgs: [news.uid, news.url],
    );

    return count;
  }

  /// delete all news from bookmarks table, according to [uid]
  Future<int> clearBookmarks(String uid) async {
    final db = await database;

    return await db.delete(
      newsBookmarksTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }
}
