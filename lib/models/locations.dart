import 'dart:convert';
import '../links.dart';
import 'package:http/http.dart' as http;

class Locations {
  late List<Results> results;

  Locations(this.results);

  Locations.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results.map((v) => v.toJson()).toList();
    return data;
  }
}

class Results {
  late String name;
  late String type;
  late String dimension;

  Results(
    this.name,
    this.dimension,
  );

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    dimension = json['dimension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['dimension'] = this.dimension;
    return data;
  }
}

Future<Locations> getLocationsFromAPI() async {
  var url = Uri.https(Links.authority, Links.unencodedPathLocate);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error response");
  }
}
