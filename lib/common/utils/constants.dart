import 'package:yess_nutrition/data/models/product_models/product_category_model.dart';

/// a base API url for news feature
const newsBaseUrl = 'https://newsapi.org/v2';

/// an API key, used with [newsBaseUrl]
const newsApiKey = '7050119227e24e83bd10051e12a1b9c5';

/// a base API url for food and product database feature
const foodBaseUrl = 'https://api.edamam.com/api/food-database/v2/parser';

/// an app id, used with [foodBaseUrl]
const foodAppId = 'b8bd9b3a';

/// an app key, used with [foodBaseUrl]
const foodAppKey = '6cf3d53b97c0bfa283c2120350b0e532';

/// a base API url for food recipe feauture
const recipeBaseUrl = 'https://api.edamam.com/api/recipes/v2';

/// an app id, used with [recipeBaseUrl]
const recipeAppId = 'c4cfd3e2';

/// an app key, used with [recipeBaseUrl]
const recipeAppKey = '25a1a63aff3f14b00da8df7ad109f4b5';

/// a list of certificates that used for request data from API
const certificates = <String, String>{
  'newsApi': 'certificates/sni-cloudflaressl-com.pem',
  'nutritionApi': 'certificates/edamam-com.pem',
  'bukalapak': 'certificates/bukalapak-com.pem',
};

/// a base url for shop feature
const shopBaseUrl = 'https://www.bukalapak.com';

/// list of food category urls
const foodProductBaseUrls = <String>[
  '$shopBaseUrl/c/food/makanan',
  '$shopBaseUrl/c/food/makanan-beku',
  '$shopBaseUrl/c/food/makanan-jadi',
  '$shopBaseUrl/c/food/minuman',
  '$shopBaseUrl/c/food/sayur-buah',
  '$shopBaseUrl/c/food/telur-protein',
  '$shopBaseUrl/c/food/bumbu',
  '$shopBaseUrl/c/food/beras',
  '$shopBaseUrl/c/food/bahan-kue',
  '$shopBaseUrl/c/food/kue',
];

/// list of health category urls
const healthProductBaseUrls = <String>[
  '$shopBaseUrl/c/kesehatan-2359/alat-kesehatan',
  '$shopBaseUrl/c/kesehatan-2359/essential-oil',
  '$shopBaseUrl/c/kesehatan-2359/masker-4297',
  '$shopBaseUrl/c/kesehatan-2359/kesehatan-mata',
  '$shopBaseUrl/c/kesehatan-2359/kesehatan-mulut-gigi',
  '$shopBaseUrl/c/kesehatan-2359/kesehatan-telinga',
  '$shopBaseUrl/c/kesehatan-2359/kesehatan-wanita',
  '$shopBaseUrl/c/kesehatan-2359/obat-vitamin',
];

/// list of food produccategory urls
const foodProductCategories = <ProductCategoryModel>[
  ProductCategoryModel(
    title: 'Makanan',
    imgAsset: 'assets/img/food_category_food.png',
  ),
  ProductCategoryModel(
    title: 'Makanan Beku',
    imgAsset: 'assets/img/food_category_frozen_food.png',
  ),
  ProductCategoryModel(
    title: 'Makanan Jadi',
    imgAsset: 'assets/img/food_category_prepared_food.png',
  ),
  ProductCategoryModel(
    title: 'Minuman',
    imgAsset: 'assets/img/food_category_beverage.png',
  ),
  ProductCategoryModel(
    title: 'Buah & Sayur',
    imgAsset: 'assets/img/food_category_fruit_and_vegetable.png',
  ),
  ProductCategoryModel(
    title: 'Telur & Protein',
    imgAsset: 'assets/img/food_category_egg.png',
  ),
  ProductCategoryModel(
    title: 'Bumbu',
    imgAsset: 'assets/img/food_category_seasoning.png',
  ),
  ProductCategoryModel(
    title: 'Beras',
    imgAsset: 'assets/img/food_category_rice.png',
  ),
  ProductCategoryModel(
    title: 'Bahan Kue',
    imgAsset: 'assets/img/food_category_cake_ingredient.png',
  ),
  ProductCategoryModel(
    title: 'Kue',
    imgAsset: 'assets/img/food_category_cake.png',
  ),
];

const healthProductCategories = <ProductCategoryModel>[
  ProductCategoryModel(
    title: 'Alat Kesehatan',
    imgAsset: 'assets/img/health_category_medical_tool.png',
  ),
  ProductCategoryModel(
    title: 'Essential Oil',
    imgAsset: 'assets/img/health_category_essential_oil.png',
  ),
  ProductCategoryModel(
    title: 'Masker',
    imgAsset: 'assets/img/health_category_mask.png',
  ),
  ProductCategoryModel(
    title: 'Kesehatan Mata',
    imgAsset: 'assets/img/health_category_eye.png',
  ),
  ProductCategoryModel(
    title: 'Kesehatan Mulut & Gigi',
    imgAsset: 'assets/img/health_category_mouth_and_teeth.png',
  ),
  ProductCategoryModel(
    title: 'Kesehatan Telinga',
    imgAsset: 'assets/img/health_category_ear.png',
  ),
  ProductCategoryModel(
    title: 'Kesehatan Wanita',
    imgAsset: 'assets/img/health_category_female.png',
  ),
  ProductCategoryModel(
    title: 'Obat & Vitamin',
    imgAsset: 'assets/img/health_category_drug_and_vitamin.png',
  ),
];
