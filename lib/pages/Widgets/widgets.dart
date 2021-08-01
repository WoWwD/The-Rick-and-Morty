import 'package:flutter/material.dart';

class TitleSubtitle {
  Widget getTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Color.fromRGBO(241, 246, 249, 1),
          fontSize: 15,
          fontFamily: "GowunDodum"),
    );
  }

  Widget getSubTitle(String subTitle) {
    return Text(
      subTitle,
      style: TextStyle(
          color: Colors.grey[400], fontSize: 12, fontFamily: "GowunDodum"),
    );
  }
}

class Cards {
  Widget getCard(Widget child) {
    return Card(
        color: Color.fromRGBO(52, 73, 102, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(10),
        child:
            Container(padding: EdgeInsets.all(10), height: 125, child: child));
  }
}
