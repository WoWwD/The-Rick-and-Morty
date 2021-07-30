import 'package:flutter/material.dart';
import 'package:the_rick_and_morty/models/infoAboutCharacter.dart';
import 'package:the_rick_and_morty/pages/pageCardsCharacters.dart';
import '../links.dart';

class PageInfoAboutCharacter extends StatelessWidget {
  final Character character;
  PageInfoAboutCharacter(this.character);

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
              fontSize: 28),
        ),
        backgroundColor: Colors.grey[800],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(37, 37, 37, 1),
            ),
          ),
          Container(
            child: FutureBuilder<GetInfoCharacter>(
              future: getCharacterFromAPI(Links.authority,
                  Links.unencodedPathCharacter + "/${character.id.toString()}"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  InfoAboutCharacterForListview().getValue(snapshot);
                  return Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Information().getImage(snapshot),
                      ),
                      Expanded(flex: 4, child: Information().getInfo(snapshot)),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("Error");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}

class Information {
  Widget getImage(AsyncSnapshot snapshot) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            "${snapshot.data!.image}",
            fit: BoxFit.fill,
          )),
    );
  }

  Widget getContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: child,
    );
  }

  Widget getInfo(AsyncSnapshot snapshot) {
    return getContainer(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${InfoAboutCharacterForListview.name}",
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontFamily: "GFowunDodum"),
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
            getTitle(snapshot, "Live status:"),
            getSubTitle(snapshot, "${snapshot.data!.status}"),
            SizedBox(height: 20),
            getTitle(snapshot, "Species:"),
            getSubTitle(snapshot, "${snapshot.data!.species}"),
            SizedBox(height: 20),
            getTitle(snapshot, "Gender:"),
            getSubTitle(snapshot, "${snapshot.data!.gender}"),
            SizedBox(height: 20),
            getTitle(snapshot, "Last known location:"),
            getSubTitle(
                snapshot, "${InfoAboutCharacterForListview.lastLocation}"),
            SizedBox(height: 20),
            getTitle(snapshot, "First seen in:"),
            getSubTitle(
                snapshot, "${InfoAboutCharacterForListview.firstSeenIn}"),
            SizedBox(height: 20),
            getTitle(snapshot, "Episodes featuring:"),
            getSubTitle(
                snapshot, "${InfoAboutCharacterForListview.episodesFeat}"),
            SizedBox(height: 20),
            getTitle(snapshot, "Created:"),
            getSubTitle(snapshot, "${InfoAboutCharacterForListview.created}"),
          ],
        ))
      ],
    ));
  }

  Widget getTitle(AsyncSnapshot snapshot, String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.grey[300], fontSize: 14, fontFamily: "GowunDodum"),
    );
  }

  Widget getSubTitle(AsyncSnapshot snapshot, String subTitle) {
    return Text(
      subTitle,
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontFamily: "GFowunDodum"),
    );
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
