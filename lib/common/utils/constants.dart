// API urls for nutri news feature
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';

const newsBaseUrl = 'https://newsapi.org/v2';
const newsApiKey = '7050119227e24e83bd10051e12a1b9c5';

// user data empty instance
const userDataEmpty = UserDataEntity(
  uid: '',
  email: '',
  name: '',
  imgUrl: '',
  gender: '',
  age: 0,
  weight: 0,
  height: 0,
  bio: '',
);
