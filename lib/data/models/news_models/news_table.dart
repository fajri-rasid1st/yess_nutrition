import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';

const newsBookmarksTable = 'news_bookmarks_table';

class NewsTable extends Equatable {
  final String uid;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;
  final String author;
  final String source;

  const NewsTable({
    required this.uid,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.author,
    required this.source,
  });

  factory NewsTable.fromEntity(NewsEntity news) {
    return NewsTable(
      uid: news.uid!,
      title: news.title,
      description: news.description,
      url: news.url,
      urlToImage: news.urlToImage,
      publishedAt: news.publishedAt,
      content: news.content,
      author: news.author,
      source: news.source,
    );
  }

  factory NewsTable.fromMap(Map<String, dynamic> news) {
    return NewsTable(
      uid: news['uid'] as String,
      title: news['title'] as String,
      description: news['description'] as String,
      url: news['url'] as String,
      urlToImage: news['urlToImage'] as String,
      publishedAt: DateTime.parse(news['publishedAt'] as String),
      content: news['content'] as String,
      author: news['author'] as String,
      source: news['source'] as String,
    );
  }

  NewsEntity toEntity() {
    return NewsEntity.bookmark(
      uid: uid,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
      author: author,
      source: source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
      'author': author,
      'source': source,
    };
  }

  @override
  List<Object> get props => [
        uid,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
        author,
        source,
      ];
}
