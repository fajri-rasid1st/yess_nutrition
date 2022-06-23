import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yess_nutrition/common/utils/constants.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/models/recipe_models/recipe_detail_model.dart';
import 'package:yess_nutrition/data/models/recipe_models/recipe_detail_response.dart';
import 'package:yess_nutrition/data/models/recipe_models/recipe_model.dart';
import 'package:yess_nutrition/data/models/recipe_models/recipe_response.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> searchRecipes(String query);

  Future<RecipeDetailModel> getRecipeDetail(String recipeId);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RecipeModel>> searchRecipes(String query) async {
    const fields =
        'field=uri&field=label&field=image&field=url&field=yield&field=calories&field=totalTime';

    final url =
        '$recipeBaseUrl?app_id=$recipeAppId&app_key=$recipeAppKey&q=$query&$fields&type=public&beta=false';

    final uri = Uri.parse(url);

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final results = json.decode(response.body);

      return RecipeResponse.fromJson(results).recipes;
    }

    throw ServerException('Internal server error');
  }

  @override
  Future<RecipeDetailModel> getRecipeDetail(String recipeId) async {
    const fields =
        'field=uri&field=label&field=image&field=url&field=yield&field=dietLabels&field=healthLabels&field=cautions&field=ingredientLines&field=calories&field=totalTime&field=totalNutrients';

    final url =
        '$recipeBaseUrl/$recipeId?app_id=$recipeAppId&app_key=$recipeAppKey&$fields&type=public&beta=false';

    final uri = Uri.parse(url);

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final results = json.decode(response.body);

      return RecipeDetailResponse.fromJson(results).recipe;
    }

    throw ServerException('Internal server error');
  }
}
