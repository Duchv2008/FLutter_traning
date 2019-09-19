import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_demo/src/models/list_video_model.dart';

abstract class VideoState extends Equatable {
}

class VideoInitialized extends VideoState {
  @override
  String toString() => "VideoInitialized";
}

class VideoSuccess extends VideoState {
  List<ListVideoModel> listVideos = List<ListVideoModel>();

  VideoSuccess(this.listVideos);

  @override
  String toString() => "VideoSuccess";
}

class VideoFail extends VideoState {
  @override
  String toString() => "VideoFail";
}

class VideoLoading extends VideoState {
  @override
  String toString() => "VideoLoading";
}