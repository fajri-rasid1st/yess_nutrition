/// a base API urls for news feature
const newsBaseUrl = 'https://newsapi.org/v2';

/// an API key, used with [newsBaseUrl]
const newsApiKey = '7050119227e24e83bd10051e12a1b9c5';

/// a base API urls for food database feature
const foodBaseUrl = 'https://api.edamam.com/api/food-database/v2/parser';

/// an app id, used with [foodBaseUrl]
const foodAppId = 'b8bd9b3a';

/// an app key, used with [foodBaseUrl]
const foodAppKey = '6cf3d53b97c0bfa283c2120350b0e532';

/// a list of certificates that used for request data from API
const certificates = <String, String>{
  'newsApi': 'certificates/sni-cloudflaressl-com.pem',
  'foodApi': 'certificates/edamam-com.pem',
};
