import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/src/models/list_video_model.dart';
import 'package:flutter_bloc_demo/src/widgets/button_text.dart';
import 'package:flutter_bloc_demo/src/widgets/gridview_video.dart';

class PlayVideoScreen extends StatefulWidget {
  ListVideoModel fetchVideoFavorite(TypeVideo type) {
    final List<ItemVideoModel> videos = List<ItemVideoModel>();

    for (var i = 0; i < 5; i++) {
      var item = ItemVideoModel.fromJson({
        "avatar_link": "https://www.superbabyonline.com/wp-content/uploads/2015/02/indian-baby-girl-names-n-superbaby.jpg",
        "title": "Tap $i: Doremon Mũi tên đảo ngược - Doremon series hêhheheheheh",
        "link": ""
      });
      videos.add(item);
    }

    final ListVideoModel favoriteVideos = ListVideoModel(type: type, items: videos);
    return favoriteVideos;
  }

  @override
  State<StatefulWidget> createState() {
    return _PlayVideoScreen(fetchVideoFavorite(TypeVideo.popular));
  }
}

class _PlayVideoScreen extends State<PlayVideoScreen> {
  ListVideoModel category;

  _PlayVideoScreen(this.category);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Play video screen"),
          ),
          body: Column(
            children: <Widget>[
              _videoPreview(),
              Flexible(
                  flex: 2,
                  child: _listViewDetail()
              )
            ],
          )
        )
      ],
    );
  }

  Widget _videoPreview() {
    return Flexible(
      flex: 1,
      child: Container(
        color: Colors.red,
      ),
    );
  }
  
  Widget _listViewDetail() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            _inforVideoCell(),
            Column(
              children: <Widget>[
                ButtonText(title: "Playlist dang xem"),
                GridviewVideo(
                  items: category.items,
                  scrollDirection: Axis.horizontal,
                  heightGridview: 220
                )
              ],
            ),
            Column(
              children: <Widget>[
                ButtonText(title: "Video de xuat"),
                GridviewVideo(
                  items: category.items,
                  scrollDirection: Axis.horizontal,
                  heightGridview: 430,
                  crossAxisCount: 2,
                )
              ],
            ),
            Column(
              children: <Widget>[
                ButtonText(title: "Video noi bat"),
                GridviewVideo(
                  items: category.items,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  heightImageView: 148,
                  isCanScroll: false,
                )
              ],
            )
          ],
        );
      },
    );
  }
  
  Widget _inforVideoCell() {
    return Container(
      child: Text("TETETETET wet asd asd ETETETET wet asd asd TETETETET wet asd asd TETETETET wet asd asd" ),
    );
  }
}