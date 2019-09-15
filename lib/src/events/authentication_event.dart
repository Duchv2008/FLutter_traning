import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {}

// Start app
class AppStarted extends AuthenticationEvent {
  @override
  String toString() => "AppStarted";
}

// App logged in
class AppLoggedIn extends AuthenticationEvent {
  final String token;
  AppLoggedIn({
    this.token
  });

  @override
  String toString() => "AppLoggedIn";
}

// App logged out
class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}