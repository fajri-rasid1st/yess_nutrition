import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/models/news_models/news_document.dart';

abstract class NewsFirestoreDataSource {
  Future<String> createBookmark(String uid, NewsDocument news);

  Future<List<NewsDocument>> getBookmarks(String uid);

  Future<String> deleteBookmark(String uid, NewsDocument news);

  Future<String> clearBookmarks(String uid);

  Future<bool> isBookmarkExist(String uid, NewsDocument news);
}

class NewsFirestoreDataSourceImpl implements NewsFirestoreDataSource {
  final FirebaseFirestore firebaseFirestore;

  NewsFirestoreDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<String> createBookmark(String uid, NewsDocument news) async {
    try {
      final reference = firebaseFirestore.collection('bookmarks').doc(uid);

      final newsDocument = news.toDocument();

      await reference.set({news.id: newsDocument});

      return 'Artikel ditambahkan ke bookmarks.';
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<List<NewsDocument>> getBookmarks(String uid) async {
    try {
      final reference = firebaseFirestore.collection('bookmarks').doc(uid);

      final snapshot = await reference.get();

      if (snapshot.data() == null) return <NewsDocument>[];

      final values = snapshot.data()!.values as Iterable<Map<String, dynamic>>;

      final news = values.map((news) => NewsDocument.fromDocument(news));

      return news.toList()
        ..sort((news1, news2) {
          return news1.publishedAt.compareTo(news2.publishedAt) * -1;
        });
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<String> deleteBookmark(String uid, NewsDocument news) async {
    try {
      final reference = firebaseFirestore.collection('bookmarks').doc(uid);

      await reference.update({news.id: FieldValue.delete()});

      return 'Artikel dihapus dari bookmarks.';
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<String> clearBookmarks(String uid) async {
    try {
      final reference = firebaseFirestore.collection('bookmarks').doc(uid);

      await reference.delete();

      return 'Berhasil menghapus semua artikel dari bookmarks.';
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<bool> isBookmarkExist(String uid, NewsDocument news) async {
    try {
      final reference = firebaseFirestore.collection('bookmarks').doc(uid);

      final snapshot = await reference.get();

      if (snapshot.data() == null) return false;

      final keys = snapshot.data()!.keys;

      return keys.contains(news.id);
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }
}
