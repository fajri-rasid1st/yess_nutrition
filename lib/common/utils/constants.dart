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

const recommendationProductBaseUrl =
    '$shopBaseUrl/products?search%5Bkeywords%5D=buku%20makanan%20kesehatan';

const userNutrientQuestions = <UserNutrientQuestion>[
  UserNutrientQuestion(
    'Detail nutrisi harian saya tidak muncul.',
    'Kami memerlukan data berupa umur, usia, berat badan, dan tinggi badan untuk menentukan kebutuhan nutrisi harian anda. Jika belum, silahkan lengkapi data anda pada menu pengaturan profil.',
  ),
  UserNutrientQuestion(
    'Bagaimana aplikasi menghitung kebutuhan nutrisi harian saya?',
    'Kebutuhan nutrisi yang tertera di atas adalah Basal Metabolic Rate (BMR) anda yang dihitung menggunakan rumus Harris-Benedict.',
  ),
  UserNutrientQuestion(
    'Apa itu BMR?',
    'Basal Metabolic Rate (BMR) adalah kalori yang tubuh Anda perlukan untuk melakukan aktivitas dasar tubuh. Aktivitas tersebut mencakup memompa jantung, mencerna makanan, bernapas, memperbaiki sel tubuh, hingga membuang racun dalam tubuh.',
  ),
  UserNutrientQuestion(
    'Apa itu kalori dan fungsinya untuk tubuh?',
    'Kalori adalah sumber bahan bakar tubuh yang didapatkan dari mengonsumsi beragam makanan dan minuman. Kalori dari makanan dan minuman tersebut akan digunakan tubuh sebagai energi untuk melakukan segala aktivitas fisik.',
  ),
  UserNutrientQuestion(
    'Apakah BMR sudah akurat dalam menentukan kebutuhan nutrisi?',
    'BMR hanyalah jumlah kalori minimum yang dibutuhkan tubuh Anda untuk dapat menjalankan fungsi organ-organ vital tubuh. Namun, setiap harinya Anda perlu mengonsumsi makanan dan minuman dengan jumlah kalori lebih dari itu.',
  ),
];

class UserNutrientQuestion {
  final String question;
  final String answer;

  const UserNutrientQuestion(this.question, this.answer);
}
