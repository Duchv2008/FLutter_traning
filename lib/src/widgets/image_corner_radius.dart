import "package:flutter/material.dart";

class ImageCornerRadius extends StatelessWidget {
  String link;
  double heightImageView;

  ImageCornerRadius({this.link, this.heightImageView});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
      child: Image.network(link, height: heightImageView, fit: BoxFit.fill),
    );
  }
}