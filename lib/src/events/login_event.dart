import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class PressLogin extends LoginEvent {
  String email;
  String password;
  PressLogin(this.email, this.password) : super([email, password]);

  @override
  String toString() => "PressLogin";
}