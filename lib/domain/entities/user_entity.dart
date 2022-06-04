import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String imgUrl;
  final String gender;
  final int age;
  final int weight;
  final int height;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    required this.imgUrl,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
  });

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
      ];
}
