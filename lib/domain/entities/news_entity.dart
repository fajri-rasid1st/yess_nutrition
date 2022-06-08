import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String author;
  final String source;

  const NewsEntity({
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
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.author,
    required this.source,
  });

  @override
  List<Object> get props => [
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
