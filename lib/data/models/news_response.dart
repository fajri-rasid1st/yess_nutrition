import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/news_model.dart';

class NewsResponse extends Equatable {
  final List<NewsModel> news;

  const NewsResponse({required this.news});

  factory NewsResponse.fromJson(Map<String, dynamic> news) {
    return NewsResponse(
      news: List<NewsModel>.from(
        (news['articles'] as List).map(
          (article) => NewsModel.fromJson(article),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'articles': List<dynamic>.from(news.map((article) => article.toJson())),
    };
  }

  @override
  List<Object> get props => [news];
}
