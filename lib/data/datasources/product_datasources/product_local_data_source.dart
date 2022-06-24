import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/datasources/database/database_helper.dart';
import 'package:yess_nutrition/data/models/product_models/product_table.dart';

abstract class ProductLocalDataSource {
  Future<String> createFavoriteProduct(ProductTable product);

  Future<List<ProductTable>> getFavoriteProducts(String uid);

  Future<String> deleteFavoriteProduct(ProductTable product);

  Future<String> clearFavoriteProducts(String uid);

  Future<bool> isFavoriteProductExist(ProductTable product);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final DatabaseHelper databaseHelper;

  ProductLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> createFavoriteProduct(ProductTable product) async {
    try {
      await databaseHelper.createFavoriteProduct(product);

      return 'Product ditambahkan ke favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<ProductTable>> getFavoriteProducts(String uid) async {
    try {
      final favorites = await databaseHelper.getFavoriteProducts(uid);

      return favorites;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> deleteFavoriteProduct(ProductTable product) async {
    try {
      await databaseHelper.deleteFavoriteProduct(product);

      return 'Product dihapus dari favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> clearFavoriteProducts(String uid) async {
    try {
      await databaseHelper.clearFavoriteProducts(uid);

      return 'Semua product favorite berhasil dihapus';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<bool> isFavoriteProductExist(ProductTable product) async {
    try {
      final isExist = await databaseHelper.isFavoriteProductExist(product);

      return isExist;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
