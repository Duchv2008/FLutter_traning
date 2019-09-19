import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/video_bloc.dart';
import 'package:flutter_bloc_demo/src/events/video_event.dart';
import 'package:flutter_bloc_demo/src/models/list_video_model.dart';
import 'package:flutter_bloc_demo/src/resources/video_repository.dart';
import 'package:flutter_bloc_demo/src/states/video_state.dart';

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
                    itemBuilder: (context, index) {
                      final childArrList = listVideos[index];
                      if (listVideos[index].type == TypeVideo.favorite) {
                        return _favoriteCell(context, childArrList);
                      }
                      else if (listVideos[index].type == TypeVideo.categorypopular) {
                        return _categoryCell(childArrList);
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

  Widget _favoriteCell(BuildContext pContext, ListVideoModel favorite) {
    final List<ItemVideoModel> items = favorite.items;
    double widthScreen = MediaQuery.of(pContext).size.width;
    return Column(
      children: <Widget>[
        Text(
          "favorite",
          textAlign: TextAlign.left,
        ),
        Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final ItemVideoModel item = items[index];
                return Padding(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 1.0,
                              offset: Offset(0, 0)
                          )
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          child: Image.network(
                              item.avatarLink,
                              height: 148,
                              fit:BoxFit.fill
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(item.titleVideo,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1
              ),
            ))
      ],
    );
  }

  Widget _categoryCell(ListVideoModel category) {
    final List<CategoryModel> itemsCategories = category.items;
    return Column(
      children: <Widget>[
        Text("Categories"),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemsCategories.length,
          itemBuilder: (context, index) {
            final category = itemsCategories[index];
            return _categoryItemsCell(category);
          },
        )
      ],
    );
  }

  Widget _categoryItemsCell(CategoryModel category) {
    final List<ItemVideoModel> items = category.items;
    return Column(
      children: <Widget>[
        Text(
          category.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 220,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10),
            itemCount: items.length,
            itemBuilder: (contex, index) {
              final ItemVideoModel item = items[index];
              // double widthScreen = MediaQuery.of(context).size.width;
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 1.0,
                          offset: Offset(0, 0)
                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      child: Image.network(
                          item.avatarLink,
                          height: 150,
                          fit:BoxFit.fill
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(item.titleVideo,
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              );
            },
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1),
          ),
        ),
      ],
    );
  }

// Widget _lastestCell(List<ItemVideoModel> items) {
//   return Column(
//     children: <Widget>[
//       Text("Latest"),
//       GridView.builder(
//         scrollDirection: Axis.vertical,
//         padding: EdgeInsets.all(10),
//         itemCount: items.length,
//         itemBuilder: (contex, index) {
//           final ItemVideoModel item = items[index];
//           double widthScreen = MediaQuery.of(context).size.width;
//           return Container(
//             width: widthScreen / 2 - 20,
//             height: widthScreen / 2 - 20,
//             child: Column(
//               children: <Widget>[Image.network(""), Text(item.titleVideo)],
//             ),
//           );
//         },
//         gridDelegate: null,
//       )
//     ],
//   );
// }
}
