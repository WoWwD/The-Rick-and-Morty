import 'package:flutter/material.dart';
import 'package:the_rick_and_morty/models/characters.dart';
import 'package:the_rick_and_morty/pages/pageInfoAboutCharacter.dart';

class PageCardsCharacters extends StatefulWidget {
  @override
  _CardsCharacters createState() => _CardsCharacters();
}

class _CardsCharacters extends State<PageCardsCharacters> {
  @override
  void initState() {
    super.initState();
    getCharactersFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Characters",
              style: TextStyle(
                  fontFamily: "get-schwifty",
                  color: Color.fromRGBO(13, 198, 203, 1),
                  fontSize: 28),
            ),
            backgroundColor: Colors.grey[800]),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/RaM.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              child: FutureBuilder<CharactersList>(
                  future: getCharactersFromAPI(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.results.length,
                          itemBuilder: (context, index) {
                            return getCard(snapshot, index, context);
                          });
                    } else if (snapshot.hasError) {
                      return Text("Error");
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ));
  }
}

class BodyOfCard {
  Widget getImage(AsyncSnapshot snapshot, int index) {
    return Expanded(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "${snapshot.data!.results[index].image}",
              fit: BoxFit.fill,
            )));
  }

  Widget getInfo(AsyncSnapshot snapshot, int index) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${snapshot.data!.results[index].name}",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontFamily: "get-schwifty",
                        color: Color.fromRGBO(234, 245, 59, 1),
                        fontSize: 23)),
                Divider(
                  color: Color.fromRGBO(234, 245, 59, 1),
                  thickness: 2,
                  endIndent: 0,
                  indent: 0,
                ),
                getTitleAndSubtitle(snapshot, "Live status:",
                    "${snapshot.data!.results[index].status}"),
                getTitleAndSubtitle(snapshot, "Species (gender):",
                    "${snapshot.data!.results[index].species} (${snapshot.data!.results[index].gender})"),
              ],
            )),
      ],
    ));
  }

  Widget getTitleAndSubtitle(
      AsyncSnapshot snapshot, String title, String subTitle) {
    return Container(
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
          Text(
            subTitle,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: "GFowunDodum"),
          ),
        ],
      ),
    );
  }
}

Widget getCard(AsyncSnapshot snapshot, int index, BuildContext context) {
  return Card(
      color: Colors.grey[600],
      shadowColor: Colors.grey[300],
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(10),
      child: InkWell(
          onTap: () {
            Character character = Character(snapshot.data!.results[index].id);
            Route route = MaterialPageRoute(
                builder: (context) => PageInfoAboutCharacter(character));
            Navigator.push(context, route);
          },
          child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 200,
              child: Row(
                children: <Widget>[
                  BodyOfCard().getImage(snapshot, index),
                  BodyOfCard().getInfo(snapshot, index),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  )
                ],
              ))));
}

class Character {
  final int id;
  Character(this.id);
}

// Вертикальные карточки ()

// FutureBuilder<CharactersList>(
//                 future: getCharactersFromAPI(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: snapshot.data!.results.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                             height: 300,
//                             padding: EdgeInsets.all(15),
//                             margin: EdgeInsets.only(
//                                 left: 50, right: 50, top: 85, bottom: 85),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[600],
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: InkWell(
//                               onTap: () {
//                                 Character character =
//                                     Character(snapshot.data!.results[index].id);
//                                 Route route = MaterialPageRoute(
//                                     builder: (context) =>
//                                         PageInfoAboutCharacter(character));
//                                 Navigator.push(context, route);
//                               },
//                               splashColor: Colors.lightGreenAccent,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: <Widget>[
//                                   BodyOfCard().getTitle(snapshot, index),
//                                   SizedBox(height: 15),
//                                   BodyOfCard().getImage(snapshot, index),
//                                   SizedBox(height: 15),
//                                   BodyOfCard().getInfo(snapshot, index)
//                                 ],
//                               ),
//                             ));
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return Text("Error");
//                   }
//                   return Center(child: CircularProgressIndicator());
//                 }),
