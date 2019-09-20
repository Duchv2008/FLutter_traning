import "package:flutter/material.dart";

class ButtonText extends StatelessWidget {

  String title;

  ButtonText({this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );
  }
}