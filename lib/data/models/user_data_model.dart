import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';

class UserDataModel extends Equatable {
  final String uid;
  final String email;
  final String? name;
  final String? imgUrl;
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;

  const UserDataModel({
    required this.uid,
    required this.email,
    this.name,
    this.imgUrl,
    this.gender,
    this.age,
    this.weight,
    this.height,
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
    );
  }

  UserDataEntity toEntity() {
    return UserDataEntity(
      uid: uid,
      email: email,
      name: name ?? '',
      imgUrl: imgUrl ?? '',
      gender: gender ?? '',
      age: age ?? 0,
      weight: weight ?? 0,
      height: height ?? 0,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'email': email,
      'name': name ?? '',
      'imgUrl': imgUrl ?? '',
      'gender': gender ?? '',
      'age': age ?? 0,
      'weight': weight ?? 0,
      'height': height ?? 0,
    };
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        name,
        imgUrl,
        gender,
        age,
        weight,
        height,
      ];
}
