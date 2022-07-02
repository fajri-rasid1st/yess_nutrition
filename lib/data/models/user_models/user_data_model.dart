import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';

class UserDataModel extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String imgUrl;
  final String gender;
  final int age;
  final int weight;
  final int height;
  final String bio;

  const UserDataModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.imgUrl,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.bio,
  });

  factory UserDataModel.fromEntity(UserDataEntity userData) {
    return UserDataModel(
      uid: userData.uid,
      email: userData.email,
      name: userData.name,
      imgUrl: userData.imgUrl,
      gender: userData.gender,
      age: userData.age,
      weight: userData.weight,
      height: userData.height,
      bio: userData.bio,
    );
  }

  factory UserDataModel.fromDocument(Map<String, dynamic> userData) {
    return UserDataModel(
      uid: userData['uid'],
      email: userData['email'],
      name: userData['name'],
      imgUrl: userData['imgUrl'],
      gender: userData['gender'],
      age: userData['age'],
      weight: userData['weight'],
      height: userData['height'],
      bio: userData['bio'],
    );
  }

  UserDataEntity toEntity() {
    return UserDataEntity(
      uid: uid,
      email: email,
      name: name,
      imgUrl: imgUrl,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      bio: bio,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'imgUrl': imgUrl,
      'gender': gender,
      'age': age,
      'weight': weight,
      'height': height,
      'bio': bio,
    };
  }

  @override
  List<Object> get props => [
        uid,
        email,
        name,
        imgUrl,
        gender,
        age,
        weight,
        height,
        bio,
      ];
}
