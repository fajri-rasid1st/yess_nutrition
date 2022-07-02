import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';

class NewsModel extends Equatable {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;
  final String? author;
  final String? source;

  const NewsModel({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.author,
    this.source,
  });

  factory NewsModel.fromJson(Map<String, dynamic> news) {
    return NewsModel(
      title: news['title'] as String?,
      description: news['description'] as String?,
      url: news['url'] as String?,
      urlToImage: news['urlToImage'] as String?,
      publishedAt: DateTime.tryParse((news['publishedAt'] as String?) ?? ''),
      content: news['content'] as String?,
      author: news['author'] as String?,
      source: (news['source'] as Map<String, dynamic>)['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt?.toIso8601String(),
      'content': content,
      'author': author,
      'source': source,
    };
  }

  NewsEntity toEntity() {
    return NewsEntity(
      title: title ?? '',
      description: description ?? '',
      url: url ?? '',
      urlToImage: urlToImage ?? '',
      publishedAt: publishedAt ?? DateTime(0),
      content: content ?? '',
      author: author ?? '',
      source: source ?? '',
    );
  }

  @override
  List<Object?> get props => [
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
