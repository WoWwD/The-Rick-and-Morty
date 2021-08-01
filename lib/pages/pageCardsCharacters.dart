import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:the_rick_and_morty/models/cardsCharacters.dart';
import 'package:the_rick_and_morty/pages/pageDetailsCharacter.dart';
import 'package:paging/paging.dart';

class PageCardsCharacters extends StatefulWidget {
  @override
  _CardsCharacters createState() => _CardsCharacters();
}

class _CardsCharacters extends State<PageCardsCharacters> {
  static int pageNumber = 1;
  Future<List<Results>> getCharactersFromAPI() async {
    var response = await http.get(Uri.parse(
        "https://rickandmortyapi.com/api/character/?page=$pageNumber"));
    pageNumber++;
    if (response.statusCode == 200) {
      var character = CardsCharacters.fromJson(json.decode(response.body));
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
            "Characters",
            style: TextStyle(
                fontFamily: "get-schwifty",
                color: Color.fromRGBO(13, 198, 203, 1),
                fontSize: 25),
          ),
          backgroundColor: Color.fromRGBO(13, 24, 33, 1)),
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(13, 24, 33, 1),
          ),
        ),
        Pagination<Results>(
            pageBuilder: (currentSize) => getCharactersFromAPI(),
            itemBuilder: (index, item) {
              return BodyOfCard().getCard(item, context);
            })
      ]),
    );
  }
}

class BodyOfCard {
  Widget getCard(Results item, BuildContext context) {
    return Card(
        color: Color.fromRGBO(52, 73, 102, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(10),
        child: InkWell(
            highlightColor: Color.fromRGBO(13, 24, 33, 1),
            splashColor: Color.fromRGBO(13, 24, 33, 1),
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Character character = Character(item.id);
              Route route = MaterialPageRoute(
                  builder: (context) => PageInfoAboutCharacter(character.id));
              Navigator.push(context, route);
            },
            child: Container(
                height: 140,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    BodyOfCard().getImage(item),
                    BodyOfCard().getInfo(item),
                    Expanded(
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(241, 246, 249, 1),
                          )),
                    )
                  ],
                ))));
  }

  Widget getImage(Results item) {
    return Expanded(
        flex: 2,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              "${item.image}",
              fit: BoxFit.fill,
            )));
  }

  Widget getInfo(Results item) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        alignment: Alignment.center,
        child: Text("${item.name}",
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: TextStyle(
                color: Color.fromRGBO(234, 245, 59, 1),
                fontSize: 21,
                fontFamily: "get-schwifty")),
      ),
    );
  }
}

class Character {
  final int id;
  Character(this.id);
}
