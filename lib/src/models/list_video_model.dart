import 'package:flutter_bloc_demo/src/models/base_model.dart';

enum TypeVideo {
  slide, character, favorite, lastest, popular, categorypopular
}

abstract class VideoItem {

}

class ItemVideoModel extends BaseModel implements VideoItem {
  String avatarLink;
  String titleVideo;
  String linkVideo;

  ItemVideoModel.fromJson(parsedJson) : super.fromJson(parsedJson) {
    this.avatarLink = parsedJson["avatar_link"];
    this.titleVideo = parsedJson["title"];
    this.linkVideo = parsedJson["link"];
  }
}

class CategoryModel implements VideoItem {
  String id;
  String title;
  List<ItemVideoModel> items;

  CategoryModel({this.title, this.items});
}

class ListVideoModel {
  TypeVideo type;
  List<VideoItem> items;
  String title = "";

  ListVideoModel({this.type, this.items}) {
   switch (this.type) {
     case TypeVideo.lastest:
       title = "Video mới nhất";
       break;
     case TypeVideo.slide:
       title = "";
       break;
     case TypeVideo.character:
       title = "Nhân vật yêu thích";
       break;
     case TypeVideo.favorite:
       title = "Video yêu thích nhất";
       break;
     case TypeVideo.popular:
       title = "Video phổ biến nhất";
       break;
     case TypeVideo.categorypopular:
       title = "Danh mục phổ biến nhất";
       break;
   }
  }
}