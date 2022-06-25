import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/datasources/database/database_helper.dart';
import 'package:yess_nutrition/data/models/food_models/food_table.dart';

abstract class FoodLocalDataSource {
  Future<void> addFoodHistory(FoodTable food);

  Future<List<FoodTable>> getFoodHistories(String uid);

  Future<String> deleteFoodHistory(FoodTable food);

  Future<String> clearFoodHistories(String uid);
}

class FoodLocalDataSourceImpl implements FoodLocalDataSource {
  final DatabaseHelper databaseHelper;

  FoodLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> addFoodHistory(FoodTable food) async {
    try {
      await databaseHelper.addFoodHistory(food);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<FoodTable>> getFoodHistories(String uid) async {
    try {
      final foodHistories = await databaseHelper.getFoodHistories(uid);

      return foodHistories;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> deleteFoodHistory(FoodTable food) async {
    try {
      await databaseHelper.deleteFoodHistory(food);

      return 'Berhasil dihapus dari riwayat pencarian';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> clearFoodHistories(String uid) async {
    try {
      await databaseHelper.clearFoodHistories(uid);

      return 'Semua riwayat pencarian telah dihapus';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
