import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String? name;
  final String? imgUrl;

  const UserModel({
    required this.uid,
    required this.email,
    this.name,
    this.imgUrl,
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
    );
  }

  @override
  List<Object?> get props => [uid, email, name, imgUrl];
}
