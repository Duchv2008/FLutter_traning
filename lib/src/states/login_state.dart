import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
}

class LoginInitialized extends LoginState {
  @override
  String toString() => "LoginInitialized";
}

class LoginSuccess extends LoginState {
  @override
  String toString() => "LoginSuccess";
}

class LoginFail extends LoginState {
  final String message;

  LoginFail(this.message);

  @override
  String toString() => "LoginFail";
}

class LoginLoading extends LoginState {
  @override
  String toString() => "LoginLoading";
}