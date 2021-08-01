// @dart=2.9
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
                fontSize: 25),
          ),
          backgroundColor: Color.fromRGBO(13, 24, 33, 1)),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(52, 73, 102, 1),
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    getButton("Episodes", "pageEpisodes", context),
                    SizedBox(height: 200),
                  ],
                )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 200),
                    getButton("Characters", "pageCardsCharacters", context)
                  ],
                )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    getButton("Locations", "pageLocations", context),
                    SizedBox(height: 200),
                  ],
                )),
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
        fixedSize: Size(100, 100),
        primary: Color.fromRGBO(13, 24, 33, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        text,
        style: TextStyle(
            color: Color.fromRGBO(241, 246, 249, 1),
            fontSize: 10,
            fontFamily: "GFowunDodum"),
      ));
}
