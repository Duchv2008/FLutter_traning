import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

// bắt đầu vào app hien splash
class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => "AuthenticationUninitialized";

}

// Neu da loggin -> home
class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => "AuthenticationAuthenticated";
}

// Hien login form
class AuthenticationUnAuthenticated extends AuthenticationState {
  @override
  String toString() => "AuthenticationUnAuthenticated";
}

// Loading.
class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => "AuthenticationLoading";
}