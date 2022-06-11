import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';

class NewsModel extends Equatable {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
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
      title: news['title'],
      description: news['description'],
      url: news['url'],
      urlToImage: news['urlToImage'],
      publishedAt: news['publishedAt'],
      content: news['content'],
      author: news['author'],
      source: (news['source'] as Map<String, dynamic>)['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
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
      publishedAt: publishedAt ?? '',
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
