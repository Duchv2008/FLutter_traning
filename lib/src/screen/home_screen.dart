import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/video_bloc.dart';
import 'package:flutter_bloc_demo/src/events/video_event.dart';
import 'package:flutter_bloc_demo/src/models/list_video_model.dart';
import 'package:flutter_bloc_demo/src/resources/video_repository.dart';
import 'package:flutter_bloc_demo/src/states/video_state.dart';
import 'package:flutter_bloc_demo/src/widgets/button_text.dart';
import 'package:flutter_bloc_demo/src/widgets/gridview_video.dart';
import 'package:flutter_bloc_demo/src/widgets/image_corner_radius.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VideoRepository videoRepository = VideoRepository();

    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Home screen"),
          ),
          body: BlocProvider(
            builder: (context) {
              return VideoBloc(videoRepository)..dispatch(FetchInitData());
            },
            child: BlocBuilder<VideoBloc, VideoState>(
              builder: (context, VideoState state) {
                if (state is VideoSuccess) {
                  final listVideos = state.listVideos;
                  return ListView.builder(
                    itemCount: listVideos.length,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      final childArrList = listVideos[index];
                      if (listVideos[index].type == TypeVideo.character) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _titleCategory(title: childArrList.title),
                            GridviewVideo(
                              items: childArrList.items,
                              scrollDirection: Axis.horizontal,
                              heightGridview: 220,
                            ),
                          ],
                        );
                      } else if (listVideos[index].type == TypeVideo.favorite) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _titleCategory(title: childArrList.title),
                            GridviewVideo(
                              items: childArrList.items,
                              scrollDirection: Axis.vertical,
                              crossAxisCount: 2,
                              heightImageView: 148,
                              heightGridview: 0,
                              isCanScroll: false,
                            ),
                          ],
                        );
                      } else if (listVideos[index].type ==
                          TypeVideo.categorypopular) {

                        return _categoryCell(childArrList);
                      } else if (listVideos[index].type == TypeVideo.lastest) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _titleCategory(title: childArrList.title),
                            GridviewVideo(
                              items: childArrList.items,
                              scrollDirection: Axis.horizontal,
                              crossAxisCount: 2,
                              heightGridview: 430,
                            ),
                          ],
                        );
                      }
                      return Text("Waiting");
                    },
                  );
                } else {
                  return Text("null");
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _titleCategory({String title, double fontSize = 24}) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _categoryCell(ListVideoModel category) {
    final List<CategoryModel> itemsCategories = category.items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
              category.title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              )
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemsCategories.length,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          itemBuilder: (context, index) {
            final category = itemsCategories[index];
            return _categoryItemsCell(category);
          },
        )
      ],
    );
  }

  Widget _categoryItemsCell(CategoryModel subCategory) {
    final List<ItemVideoModel> items = subCategory.items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ButtonText(title: subCategory.title),
        GridviewVideo(
          items: items,
          heightGridview: 220,
          scrollDirection: Axis.horizontal,
        ),
      ],
    );
  }
}