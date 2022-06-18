import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yess_nutrition/common/utils/constants.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/models/food_models/food_model.dart';
import 'package:yess_nutrition/data/models/food_models/food_response.dart';

abstract class FoodRemoteDataSource {
  Future<Map<String, List<FoodModel>>> searchFoods(String query);
}

class FoodRemoteDataSourceImpl implements FoodRemoteDataSource {
  final http.Client client;

  FoodRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, List<FoodModel>>> searchFoods(String query) async {
    final url =
        '$foodBaseUrl?app_id=$foodAppId&app_key=$foodAppKey&ingr=$query&nutrition-type=logging';

    final uri = Uri.parse(url);

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final results = json.decode(response.body);

      return {
        'parsed': FoodResponse.fromJson(results).results,
        'hints': FoodResponse.fromJson(results).hints,
      };
    }

    throw ServerException('Internal server error');
  }
}
