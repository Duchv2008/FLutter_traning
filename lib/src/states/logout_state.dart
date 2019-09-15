import 'package:equatable/equatable.dart';

abstract class LogoutState extends Equatable {
}

class LogoutInitialized extends LogoutState {
  @override
  String toString() => "LogoutInitialized";
}

class LogoutSuccess extends LogoutState {
  @override
  String toString() => "LogoutSuccess";
}

class LogoutFail extends LogoutState {
  @override
  String toString() => "LogoutFail";
}

class LogoutLoading extends LogoutState {
  @override
  String toString() => "LogoutLoading";
}