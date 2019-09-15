import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  LogoutEvent([List props = const []]) : super(props);
}

class PressLogout extends LogoutEvent {
  @override
  String toString() => "PressLogout";
}