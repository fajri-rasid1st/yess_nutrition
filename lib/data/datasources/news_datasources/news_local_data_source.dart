import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/datasources/helpers/database_helper.dart';
import 'package:yess_nutrition/data/models/news_models/news_table.dart';

abstract class NewsLocalDataSource {
  Future<String> createNewsBookmark(NewsTable news);

  Future<List<NewsTable>> getNewsBookmarks(String uid);

  Future<String> deleteNewsBookmark(NewsTable news);

  Future<String> clearNewsBookmarks(String uid);

  Future<bool> isNewsBookmarkExist(NewsTable news);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final DatabaseHelper databaseHelper;

  NewsLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> createNewsBookmark(NewsTable news) async {
    try {
      await databaseHelper.createNewsBookmark(news);

      return 'Artikel ditambahkan ke Bookmarks.';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<NewsTable>> getNewsBookmarks(String uid) async {
    try {
      final bookmarks = await databaseHelper.getNewsBookmarks(uid);

      return bookmarks;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> deleteNewsBookmark(NewsTable news) async {
    try {
      await databaseHelper.deleteNewsBookmark(news);

      return 'Artikel dihapus dari Bookmarks.';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> clearNewsBookmarks(String uid) async {
    try {
      await databaseHelper.clearNewsBookmarks(uid);

      return 'Semua artikel berhasil dihapus.';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<bool> isNewsBookmarkExist(NewsTable news) async {
    try {
      final isExist = await databaseHelper.isNewsBookmarkExist(news);

      return isExist;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
