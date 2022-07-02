import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yess_nutrition/common/utils/constants.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/models/news_models/news_model.dart';
import 'package:yess_nutrition/data/models/news_models/news_response.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews(int pageSize, int page);

  Future<List<NewsModel>> searchNews(int pageSize, int page, String query);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NewsModel>> getNews(int pageSize, int page) async {
    final url =
        '$newsBaseUrl/top-headlines?apiKey=$newsApiKey&country=id&category=health&pageSize=$pageSize&page=$page';

    final uri = Uri.parse(url);

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final results = json.decode(response.body);

      return NewsResponse.fromJson(results).news;
    }

    throw ServerException('Internal server error');
  }

  @override
  Future<List<NewsModel>> searchNews(
    int pageSize,
    int page,
    String query,
  ) async {
    final url =
        '$newsBaseUrl/everything?apiKey=$newsApiKey&q=$query&language=id&pageSize=$pageSize&page=$page';

    final uri = Uri.parse(url);

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final results = json.decode(response.body);

      return NewsResponse.fromJson(results).news;
    }

    throw ServerException('Internal server error');
  }
}
