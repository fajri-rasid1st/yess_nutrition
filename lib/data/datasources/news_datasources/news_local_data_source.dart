import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/datasources/databases/news_database.dart';
import 'package:yess_nutrition/data/models/news_models/news_table.dart';

abstract class NewsLocalDataSource {
  Future<String> createBookmark(NewsTable news);

  Future<List<NewsTable>> getBookmarks();

  Future<bool> isBookmarkExist(NewsTable news);

  Future<String> deleteBookmark(NewsTable news);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final NewsDatabase newsDatabase;

  NewsLocalDataSourceImpl({required this.newsDatabase});

  @override
  Future<String> createBookmark(NewsTable news) async {
    try {
      await newsDatabase.createBookmark(news);

      return 'Berita ditambahkan ke Bookmarks.';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<NewsTable>> getBookmarks() async {
    try {
      final bookmarks = await newsDatabase.getBookmarks();

      return bookmarks;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<bool> isBookmarkExist(NewsTable news) async {
    try {
      final isExist = await newsDatabase.isBookmarkExist(news);

      return isExist;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> deleteBookmark(NewsTable news) async {
    try {
      await newsDatabase.deleteBookmark(news);

      return 'Berita dihapus dari Bookmarks.';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
