import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_rick_and_morty/models/episodes.dart';
import 'package:paging/paging.dart';

import 'Widgets/widgets.dart';

class PageEpisodes extends StatefulWidget {
  @override
  _Episodes createState() => _Episodes();
}

class _Episodes extends State<PageEpisodes> {
  static int pageNumber = 1;
  Future<List<Results>> getEpisodesFromAPI() async {
    var response = await http.get(
        Uri.parse("https://rickandmortyapi.com/api/episode/?page=$pageNumber"));
    pageNumber++;
    if (response.statusCode == 200) {
      var episodes = Episodes.fromJson(json.decode(response.body));
      return episodes.results;
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
              "Episodes",
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
                pageBuilder: (currentSize) => getEpisodesFromAPI(),
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
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleSubtitle().getTitle(item.name),
              TitleSubtitle().getSubTitle(item.airDate),
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: TitleSubtitle().getSubTitle(item.episode),
          ),
        )
      ],
    );
  }
}
