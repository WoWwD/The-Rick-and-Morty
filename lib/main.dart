import 'package:flutter/material.dart';
import 'package:the_rick_and_morty/pages/pageCardsCharacters.dart';
import 'package:the_rick_and_morty/pages/pageEpisodes.dart';
import 'package:the_rick_and_morty/pages/pageLocations.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Menu(), routes: {
      "pageCardsCharacters": (context) => PageCardsCharacters(),
      "pageEpisodes": (context) => PageEpisodes(),
      "pageLocations": (context) => PageLocations()
    });
  }
}

class Menu extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "The Rick and Morty",
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
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                getButton("Characters", "pageCardsCharacters", context),
                getButton("Episodes", "pageEpisodes", context),
                getButton("Locations", "pageLocations", context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget getButton(String text, String route, BuildContext context) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(100, 50),
        shadowColor: Colors.grey[600],
        primary: Colors.grey[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        text,
        style: TextStyle(
            color: Colors.grey[300], fontSize: 13, fontFamily: "GFowunDodum"),
      ));
}
