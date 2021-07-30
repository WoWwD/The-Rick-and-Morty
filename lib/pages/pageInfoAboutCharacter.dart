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
                  return Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Information().getImageAndShortInfo(snapshot),
                        Information().getInfo(snapshot)
                      ],
                    ),
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
  Widget getImageAndShortInfo(AsyncSnapshot snapshot) {
    return Expanded(
        flex: 2,
        child: Container(
            alignment: Alignment.center,
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "${snapshot.data!.image}",
                          fit: BoxFit.cover,
                        )),
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 15, top: 8, bottom: 8),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                              child: Expanded(
                            child: Column(
                              children: <Widget>[
                                getTitleAndSubtitle(snapshot, "Live status:",
                                    "${snapshot.data!.status}"),
                                getTitleAndSubtitle(snapshot, "Species:",
                                    "${snapshot.data!.species}"),
                                getTitleAndSubtitle(snapshot, "Gender:",
                                    "${snapshot.data!.gender}"),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ))))
                ],
              ),
            )));
  }

  Widget getInfo(AsyncSnapshot snapshot) {
    return Expanded(
        flex: 3,
        child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 15, right: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${snapshot.data!.name}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: "GFowunDodum"),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                    endIndent: 0,
                    indent: 0,
                  ),
                  SizedBox(height: 10),
                  getTitleAndSubtitle(snapshot, "Last known location",
                      "${snapshot.data!.location.name}"),
                  getTitleAndSubtitle(snapshot, "First seen in",
                      "${snapshot.data!.origin.name}"),
                  getTitleAndSubtitle(snapshot, "Episodes featuring",
                      "${snapshot.data!.episode.length}"),
                  getTitleAndSubtitle(
                      snapshot, "Created", "${snapshot.data!.created}"),
                ],
              ),
            )));
  }

  Widget getTitleAndSubtitle(
      AsyncSnapshot snapshot, String title, String subTitle) {
    return Container(
      child: Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.grey[350],
                fontSize: 14,
                fontFamily: "GowunDodum"),
          ),
          Expanded(
            child: Text(
              subTitle,
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: "GFowunDodum"),
            ),
          )
        ],
      )),
    );
  }
}
