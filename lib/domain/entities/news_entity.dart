import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String? uid;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;
  final String author;
  final String source;

  const NewsEntity({
    this.uid,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.author,
    required this.source,
  });

  const NewsEntity.bookmark({
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

  NewsEntity copyWith({
    String? uid,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
    String? author,
    String? source,
  }) {
    return NewsEntity(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      author: author ?? this.author,
      source: source ?? this.source,
    );
  }

  @override
  List<Object?> get props => [
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
