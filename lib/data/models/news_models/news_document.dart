import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';

class NewsDocument extends Equatable {
  final String id;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String author;
  final String source;
  final String createdAt;

  const NewsDocument({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.author,
    required this.source,
    required this.createdAt,
  });

  factory NewsDocument.fromEntity(NewsEntity news) {
    return NewsDocument(
      id: Utilities.generateUuidV5(news.url),
      title: news.title,
      description: news.description,
      url: news.url,
      urlToImage: news.urlToImage,
      publishedAt: news.publishedAt,
      content: news.content,
      author: news.author,
      source: news.source,
      createdAt: DateTime.now().toIso8601String(),
    );
  }

  factory NewsDocument.fromDocument(Map<String, dynamic> news) {
    return NewsDocument(
      id: news['id'],
      title: news['title'],
      description: news['description'],
      url: news['url'],
      urlToImage: news['urlToImage'],
      publishedAt: news['publishedAt'],
      content: news['content'],
      author: news['author'],
      source: news['source'],
      createdAt: news['createdAt'],
    );
  }

  NewsEntity toEntity() {
    return NewsEntity.bookmark(
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

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'author': author,
      'source': source,
      'createdAt': createdAt,
    };
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
        author,
        source,
        createdAt,
      ];
}
