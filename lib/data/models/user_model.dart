import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String? name;
  final String? imgUrl;
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;

  const UserModel({
    required this.uid,
    required this.email,
    this.name,
    this.imgUrl,
    this.gender,
    this.age,
    this.weight,
    this.height,
  });

  factory UserModel.fromUserCredential(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email!,
      name: user.displayName,
      imgUrl: user.photoURL,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
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
