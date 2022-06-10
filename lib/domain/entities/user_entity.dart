import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String imgUrl;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    required this.imgUrl,
  });

  UserDataEntity toUserData() {
    return UserDataEntity(
      uid: uid,
      email: email,
      name: name,
      imgUrl: imgUrl,
      gender: '',
      age: 0,
      weight: 0,
      height: 0,
    );
  }

  @override
  List<Object> get props => [uid, email, name, imgUrl];
}
