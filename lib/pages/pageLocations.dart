import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_rick_and_morty/models/locations.dart';
import 'package:http/http.dart' as http;
import 'package:paging/paging.dart';
import 'Widgets/widgets.dart';

class PageLocations extends StatefulWidget {
  @override
  _PageLocations createState() => _PageLocations();
}

class _PageLocations extends State<PageLocations> {
  static int pageNumber = 1;
  Future<List<Results>> getLocationsFromAPI() async {
    var response = await http.get(Uri.parse(
        "https://rickandmortyapi.com/api/location/?page=$pageNumber"));
    pageNumber++;
    if (response.statusCode == 200) {
      var character = Locations.fromJson(json.decode(response.body));
      return character.results;
    } else {
      throw Exception("Error response");
    }
  }

  @override
  void initState() {
    super.initState();
    pageNumber = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Locations",
              style: TextStyle(
                  fontFamily: "get-schwifty",
                  color: Color.fromRGBO(13, 198, 203, 1),
                  fontSize: 25),
            ),
            backgroundColor: Color.fromRGBO(13, 24, 33, 1)),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(13, 24, 33, 1),
              ),
            ),
            Pagination<Results>(
                pageBuilder: (currentSize) => getLocationsFromAPI(),
                itemBuilder: (index, item) {
                  return Cards().getCard(BodyOfCard().getInfo(item));
                })
          ],
        ));
  }
}

class BodyOfCard {
  Widget getInfo(Results item) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleSubtitle().getTitle(item.name),
              TitleSubtitle().getSubTitle(item.type),
            ],
          ),
        ),
        Expanded(
            child: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "${item.dimension}",
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
                fontFamily: "GowunDodum"),
          ),
        )),
      ],
    );
  }
}
