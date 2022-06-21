import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/food_models/food_model.dart';

class FoodResponse extends Equatable {
  final List<FoodModel> results;
  final List<FoodModel> hints;

  const FoodResponse({required this.results, required this.hints});

  factory FoodResponse.fromJson(Map<String, dynamic> results) {
    return FoodResponse(
      results: List<FoodModel>.from(
        (results['parsed'] as List).map(
          (parse) => FoodModel.fromJson(parse['food'] as Map<String, dynamic>),
        ),
      ),
      hints: List<FoodModel>.from(
        (results['hints'] as List).map(
          (hint) => FoodModel.fromJson(hint['food'] as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': List<Map<String, dynamic>>.from(
        results.map((food) => food.toJson()),
      ),
      'hints': List<Map<String, dynamic>>.from(
        hints.map((food) => food.toJson()),
      ),
    };
  }

  @override
  List<Object> get props => [results, hints];
}
