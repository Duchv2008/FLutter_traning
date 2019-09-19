import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {
  VideoEvent([List props = const []]) : super(props);
}

class FetchInitData extends VideoEvent {
  @override
  String toString() => "FetchInitData";
}