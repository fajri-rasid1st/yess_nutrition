import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/datasources/database/database_helper.dart';
import 'package:yess_nutrition/data/models/news_models/news_table.dart';

abstract class NewsLocalDataSource {
  Future<String> createBookmark(NewsTable news);

  Future<List<NewsTable>> getBookmarks(String uid);

  Future<bool> isBookmarkExist(NewsTable news);

  Future<String> deleteBookmark(NewsTable news);

  Future<String> clearBookmarks(String uid);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final DatabaseHelper databaseHelper;

  NewsLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> createBookmark(NewsTable news) async {
    try {
      await databaseHelper.createBookmark(news);

      return 'Artikel ditambahkan ke Bookmarks.';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<NewsTable>> getBookmarks(String uid) async {
    try {
      final bookmarks = await databaseHelper.getBookmarks(uid);

      return bookmarks;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<bool> isBookmarkExist(NewsTable news) async {
    try {
      final isExist = await databaseHelper.isBookmarkExist(news);

      return isExist;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> deleteBookmark(NewsTable news) async {
    try {
      await databaseHelper.deleteBookmark(news);

      return 'Artikel dihapus dari Bookmarks.';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> clearBookmarks(String uid) async {
    try {
      await databaseHelper.clearBookmarks(uid);

      return 'Semua artikel berhasil dihapus.';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
