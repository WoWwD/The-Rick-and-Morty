import 'dart:convert';
import 'package:http/http.dart' as http;

import '../links.dart';

class CharactersList {
  List<Results> results;

  CharactersList(this.results);

  factory CharactersList.fromJson(Map<String, dynamic> json) {
    var charactersJson = json['results'] as List;

    List<Results> charactersList =
        charactersJson.map((i) => Results.fromJson(i)).toList();

    return CharactersList(
      charactersList,
    );
  }
}

class Results {
  int id;
  String name;
  String status;
  String species;
  String gender;
  String image;

  Results(
      this.id, this.name, this.status, this.species, this.gender, this.image);

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      json['id'],
      json['name'] as String,
      json['status'] as String,
      json['species'] as String,
      json['gender'] as String,
      json['image'] as String,
    );
  }
}

Future<CharactersList> getCharactersFromAPI() async {
  var url = Uri.https(Links.authority, Links.unencodedPathCharacter);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return CharactersList.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error response");
  }
}
