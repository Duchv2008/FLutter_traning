import 'package:flutter_bloc_demo/src/models/list_video_model.dart';

class VideoRepository {
  Future<ListVideoModel> fetchVideoFavorite(TypeVideo type) async {
    final List<ItemVideoModel> videos = List<ItemVideoModel>();

    for (var i = 0; i < 10; i++) {
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

  Future<List<CategoryModel>> fetchCategories() async {
    List<CategoryModel> categories = List<CategoryModel>();
    categories.add(CategoryModel(title: "Vuon uom tai nang nhi - Mam choi la"));
    categories.add(CategoryModel(title: "Pokemon"));
    categories.add(CategoryModel(title: "Dragon ball - Bay vien ngoc rong"));
    categories.add(CategoryModel(title: "Doreamon - Moi nhat 2019"));
    categories.add(CategoryModel(title: "Bibabibo - Chuong trinh giao duc giai"));
    categories.add(CategoryModel(title: "kikiRiki - Nhung ban nho tinh nghich"));
    categories.add(CategoryModel(title: "Biet doi chim canh cut"));
    return categories;
  }

  Future<CategoryModel> fetchVideosOfCategory(String categoryId) async {
    final List<ItemVideoModel> videos = List<ItemVideoModel>();

    for (var i = 0; i < 10; i++) {
      var item = ItemVideoModel.fromJson({
        "avatar_link": "https://www.superbabyonline.com/wp-content/uploads/2015/02/indian-baby-girl-names-n-superbaby.jpg",
        "title": "Tap $i: Doremon Mũi tên đảo ngược - Doremon series hêhheheheheh",
        "link": ""
      });
      videos.add(item);
    }

    final category = CategoryModel(title: "Vuon uom tai nang nhi - Mam choi la", items: videos);
    return category;
  }
}