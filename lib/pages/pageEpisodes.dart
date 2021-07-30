import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_rick_and_morty/models/episodes.dart';

class PageEpisodes extends StatefulWidget {
  @override
  _Episodes createState() => _Episodes();
}

class _Episodes extends State<PageEpisodes> {
  @override
  void initState() {
    super.initState();
    getEpisodesFromAPI();
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
              child: FutureBuilder<Episodes>(
                  future: getEpisodesFromAPI(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.results.length,
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: EdgeInsets.all(10),
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    "${snapshot.data!.results[index].name}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: "GFowunDodum"),
                                  ),
                                  subtitle: Text(
                                    "${snapshot.data!.results[index].airDate}",
                                    style: TextStyle(
                                        color: Colors.grey[350],
                                        fontSize: 14,
                                        fontFamily: "GFowunDodum"),
                                  ),
                                  trailing: Text(
                                    "${snapshot.data!.results[index].episode}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: "GFowunDodum"),
                                  ),
                                ),
                              ));
                        },
                      );
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
