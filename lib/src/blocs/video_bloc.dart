import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_demo/src/events/video_event.dart';
import 'package:flutter_bloc_demo/src/models/list_video_model.dart';
import 'package:flutter_bloc_demo/src/resources/video_repository.dart';
import 'package:flutter_bloc_demo/src/states/video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoRepository videoRepository;

  VideoBloc(this.videoRepository);

  @override
  VideoState get initialState => VideoInitialized();

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    if (event is FetchInitData) {
      final videosFavorite = await videoRepository.fetchVideoFavorite(TypeVideo.favorite);
      final videosLastest = await videoRepository.fetchVideoFavorite(TypeVideo.lastest);
      final videosPopular = await videoRepository.fetchVideoFavorite(TypeVideo.popular);
      final characters = await videoRepository.fetchVideoFavorite(TypeVideo.character);
      final categories = await videoRepository.fetchCategories();

      var newCategory = List<CategoryModel>();
      categories.forEach((category) async {

        final category = await videoRepository.fetchVideosOfCategory("");
        newCategory.add(category);
      });

      var result = List<ListVideoModel>();
      result.add(videosFavorite);
      result.add(videosLastest);
      result.add(videosPopular);
      result.add(characters);

      final ListVideoModel category = ListVideoModel();
      category.type = TypeVideo.categorypopular;
      category.items = newCategory;
      result.add(category);
      yield VideoSuccess(result);
    }
  }
}