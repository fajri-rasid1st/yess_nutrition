import 'package:equatable/equatable.dart';

class UserDataEntity extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String imgUrl;
  final String gender;
  final int age;
  final int weight;
  final int height;
  final String bio;

  const UserDataEntity({
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

  UserDataEntity copyWith({
    String? uid,
    String? email,
    String? name,
    String? imgUrl,
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? bio,
  }) {
    return UserDataEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bio: bio ?? this.bio,
    );
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
