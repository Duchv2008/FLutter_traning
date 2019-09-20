import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/src/models/list_video_model.dart';

import 'image_corner_radius.dart';

class GridviewVideo extends StatelessWidget {
  final List<ItemVideoModel> items;
  double heightGridview;

  Axis scrollDirection;
  int crossAxisCount;
  double heightImageView;
  double fontSizeTitle;
  bool isCanScroll;

  GridviewVideo({
    @required this.items,
    @required this.heightGridview,
    this.crossAxisCount = 1,
    this.heightImageView = 150,
    this.scrollDirection = Axis.horizontal,
    this.fontSizeTitle = 24,
    this.isCanScroll = true
  });

  @override
  Widget build(BuildContext context) {
    Widget _titleVideo(String title) {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
      );
    }

    BoxDecoration _viewShadownAnCorner() {
      return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
                color: Colors.black45,
                blurRadius: 1.0,
                offset: Offset(0, 0))
          ]
      );
    }

    Widget _gridView() {
      return Padding(
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: isCanScroll ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
            scrollDirection: scrollDirection,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final ItemVideoModel item = items[index];
              return Container(
                decoration: _viewShadownAnCorner(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ImageCornerRadius(link: item.avatarLink, heightImageView: heightImageView),
                    _titleVideo(item.titleVideo)
                  ],
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1),
          )
      );
    }

    if (heightGridview == 0) {
      return _gridView();
    } else {
      return SizedBox(
        height: heightGridview,
        child: _gridView(),
      );
    }
  }
}