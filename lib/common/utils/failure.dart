import 'package:equatable/equatable.dart';

/// A base Failure class.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// A class that will be returned when a **Auth Failure** occurs.
class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);
}
