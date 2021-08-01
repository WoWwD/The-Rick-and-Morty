import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:the_rick_and_morty/models/detailsCharacter.dart';
import 'package:http/http.dart' as http;
import 'Widgets/widgets.dart';

class PageInfoAboutCharacter extends StatefulWidget {
  final int id;
  PageInfoAboutCharacter(this.id);

  @override
  _PageInfoAboutCharacterState createState() => _PageInfoAboutCharacterState();
}

class _PageInfoAboutCharacterState extends State<PageInfoAboutCharacter> {
  List<String> episodesCharacter = [];

  Future<DetailsCharacter> getDetailsCharacterFromAPI(int idCharacter) async {
    var url = Uri.https("rickandmortyapi.com", "/api/character/$idCharacter");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var episodess = DetailsCharacter.fromJson(json.decode(response.body));
      episodesCharacter = episodess.episode;
      return DetailsCharacter.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error response");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "About character",
          style: TextStyle(
              fontFamily: "get-schwifty",
              color: Color.fromRGBO(13, 198, 203, 1),
              fontSize: 25),
        ),
        backgroundColor: Color.fromRGBO(13, 24, 33, 1),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(13, 24, 33, 1),
            ),
          ),
          FutureBuilder<DetailsCharacter>(
            future: getDetailsCharacterFromAPI(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                InfoAboutCharacterForListview().getValue(snapshot);
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Information().getImage(snapshot),
                      ),
                      Expanded(flex: 4, child: Information().getInfo(snapshot)),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Error");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}

class Information {
  Widget getImage(AsyncSnapshot snapshot) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          "${snapshot.data!.image}",
          fit: BoxFit.fill,
        ));
  }

  Widget getInfo(AsyncSnapshot snapshot) {
    return Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(52, 73, 102, 1),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 10),
        child: (Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${InfoAboutCharacterForListview.name}",
              style: TextStyle(
                  color: Colors.white, fontSize: 26, fontFamily: "GowunDodum"),
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
              endIndent: 0,
              indent: 0,
            ),
            Expanded(
                child: ListView(
              children: [
                TitleSubtitle().getSubTitle("Live status:"),
                TitleSubtitle().getTitle("${snapshot.data!.status}"),
                SizedBox(height: 20),
                TitleSubtitle().getSubTitle("Species:"),
                TitleSubtitle().getTitle("${snapshot.data!.species}"),
                SizedBox(height: 20),
                TitleSubtitle().getSubTitle("Gender:"),
                TitleSubtitle().getTitle("${snapshot.data!.gender}"),
                SizedBox(height: 20),
                TitleSubtitle().getSubTitle("Last known location:"),
                TitleSubtitle().getTitle("${snapshot.data!.location.name}"),
                SizedBox(height: 20),
                TitleSubtitle().getSubTitle("First seen in:"),
                TitleSubtitle().getTitle("${snapshot.data!.origin.name}"),
                SizedBox(height: 20),
                TitleSubtitle().getSubTitle("Episodes featuring:"),
                TitleSubtitle().getTitle("${snapshot.data!.episode.length}"),
                SizedBox(height: 20),
                TitleSubtitle().getSubTitle("Created:"),
                TitleSubtitle().getTitle("${snapshot.data!.created}"),
              ],
            ))
          ],
        )));
  }
}

class InfoAboutCharacterForListview {
  static String name = "";
  static String lastLocation = "";
  static String firstSeenIn = "";
  static int episodesFeat = 0;
  static String created = "";

  void getValue(AsyncSnapshot snapshot) {
    InfoAboutCharacterForListview.name = snapshot.data!.name;
    InfoAboutCharacterForListview.lastLocation = snapshot.data!.location.name;
    InfoAboutCharacterForListview.firstSeenIn = snapshot.data!.origin.name;
    InfoAboutCharacterForListview.episodesFeat = snapshot.data!.episode.length;
    InfoAboutCharacterForListview.created = snapshot.data!.created;
  }
}
