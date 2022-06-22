// API urls for nutri news feature
const newsBaseUrl = 'https://newsapi.org/v2';
const newsApiKey = '7050119227e24e83bd10051e12a1b9c5';

const double defaultPadding = 16.0;
const double defaultBorderRadius = 12.0;
const font = 'Plus Jakarta Sans';
const baseUrl = 'https://www.bukalapak.com/products?search%5Bkeywords%5D';

const foodAndDrinkCategories = <String>[
  'Bahan Kue',
  'Buah',
  'Bumbu',
  'Beras',
  'Kue',
  'Makanan Beku',
  'Makanan Jadi',
  'Sayur',
  'teh',
  'telur'
];

const foodAndDrinkBaseUrls = <String>[
  '$baseUrl?q=bahan%20kue',
  '$baseUrl?q=buah',
  '$baseUrl?q=bumbu',
  '$baseUrl?q=beras',
  '$baseUrl?q=kue',
  '$baseUrl?q=makanan%20beku',
  '$baseUrl?q=makanan%20jadi',
  '$baseUrl?q=sayur',
  '$baseUrl?q=teh',
  '$baseUrl?q=telur',
];

const healthCategories = <String>[
  'Alat Kesehatan',
  'Essential Oil',
  'Masker',
  'Kesehatan Mata',
  'Kesehatan Mulut & Gigi',
  'Kesehatan Telinga',
  'Kesehatan Wanita',
  'Obat & Vitamin',
];

const healthBaseUrls = <String>[
  '$baseUrl?q=alat%20kesehatan',
  '$baseUrl?q=essential%20oil',
  '$baseUrl?q=kesehatan%20masker',
  '$baseUrl?q=kesehatan%20mata',
  '$baseUrl?q=kesehatan%20mulut%20gigi',
  '$baseUrl?q=kesehatan%20telinga',
  '$baseUrl?q=kesehatan%20wanita',
  '$baseUrl?q=obat%20vitamin',
];
