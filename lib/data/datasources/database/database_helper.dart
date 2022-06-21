import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/data/models/food_models/food_table.dart';
import 'package:yess_nutrition/data/models/news_models/news_table.dart';
import 'package:yess_nutrition/data/models/recipe_models/recipe_table.dart';

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
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT,
        author TEXT,
        source TEXT)
        ''');

    await db.execute('''
      CREATE TABLE $foodHistoryTable (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        uid TEXT,
        foodId TEXT,
        label TEXT,
        category TEXT,
        categoryLabel TEXT,
        foodContentsLabel TEXT,
        image TEXT,
        nutrients TEXT,
        createdAt TEXT)
        ''');

    await db.execute('''
      CREATE TABLE $recipeBookmarksTable (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        uid TEXT,
        recipeId TEXT,
        label TEXT,
        image TEXT,
        url TEXT,
        totalServing INTEGER,
        totalTime INTEGER,
        calories REAL)
        ''');
  }

  /// added [news] to news bookmarks table
  Future<int> createNewsBookmark(NewsTable news) async {
    final db = await database;

    return await db.insert(newsBookmarksTable, news.toMap());
  }

  /// get all news at news bookmarks table, according to [uid]
  Future<List<NewsTable>> getNewsBookmarks(String uid) async {
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

  /// delete [news] from news bookmarks table
  Future<int> deleteNewsBookmark(NewsTable news) async {
    final db = await database;

    return await db.delete(
      newsBookmarksTable,
      where: 'uid = ? AND url = ?',
      whereArgs: [news.uid, news.url],
    );
  }

  /// clear all news from news bookmarks table, according to [uid]
  Future<int> clearNewsBookmarks(String uid) async {
    final db = await database;

    return await db.delete(
      newsBookmarksTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  /// check whether [news] is already in news bookmarks table
  Future<bool> isNewsBookmarkExist(NewsTable news) async {
    final db = await database;

    final result = await db.query(
      newsBookmarksTable,
      where: 'uid = ? AND url = ?',
      whereArgs: [news.uid, news.url],
    );

    if (result.isNotEmpty) return Future.value(true);

    return Future.value(false);
  }

  /// added [food] to history table
  Future<int> addFoodHistory(FoodTable food) async {
    final db = await database;

    return await db.insert(foodHistoryTable, food.toMap());
  }

  /// get all foods history, according to [uid]
  Future<List<FoodTable>> getFoodHistories(String uid) async {
    final db = await database;

    final result = await db.query(
      foodHistoryTable,
      where: 'uid = ?',
      whereArgs: [uid],
      orderBy: 'createdAt DESC',
    );

    final foods = List<FoodTable>.from(
      result.map((food) => FoodTable.fromMap(food)),
    );

    return foods;
  }

  /// delete [food] from history table
  Future<int> deleteFoodHistory(FoodTable food) async {
    final db = await database;

    return await db.delete(
      foodHistoryTable,
      where: 'uid = ? AND foodId = ?',
      whereArgs: [food.uid, food.foodId],
    );
  }

  /// clear all recent food history from table, according to [uid]
  Future<int> clearFoodHistories(String uid) async {
    final db = await database;

    return await db.delete(
      foodHistoryTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  /// added [recipe] to recipe bookmarks table
  Future<int> createRecipeBookmark(RecipeTable recipe) async {
    final db = await database;

    return await db.insert(recipeBookmarksTable, recipe.toMap());
  }

  /// get all recipe at recipe bookmarks table, according to [uid]
  Future<List<RecipeTable>> getRecipeBookmarks(String uid) async {
    final db = await database;

    final result = await db.query(
      recipeBookmarksTable,
      where: 'uid = ?',
      whereArgs: [uid],
      orderBy: '_id DESC',
    );

    final recipes = List<RecipeTable>.from(
      result.map((bookmark) => RecipeTable.fromMap(bookmark)),
    );

    return recipes;
  }

  /// delete [recipe] from recipe bookmarks table
  Future<int> deleteRecipeBookmark(RecipeTable recipe) async {
    final db = await database;

    return await db.delete(
      recipeBookmarksTable,
      where: 'uid = ? AND recipeId = ?',
      whereArgs: [recipe.uid, recipe.recipeId],
    );
  }

  /// clear all recipe from recipe bookmarks table, according to [uid]
  Future<int> clearRecipeBookmarks(String uid) async {
    final db = await database;

    return await db.delete(
      recipeBookmarksTable,
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  /// check whether [recipe] is already in recipe bookmarks table
  Future<bool> isRecipeBookmarkExist(RecipeTable recipe) async {
    final db = await database;

    final result = await db.query(
      recipeBookmarksTable,
      where: 'uid = ? AND recipeId = ?',
      whereArgs: [recipe.uid, recipe.recipeId],
    );

    if (result.isNotEmpty) return Future.value(true);

    return Future.value(false);
  }
}
