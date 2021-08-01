class DetailsCharacter {
  late int id;
  late String name;
  late String status;
  late String species;
  late String gender;
  late Origin origin;
  late Origin location;
  late String image;
  late String created;
  late List<String> episode;

  DetailsCharacter(this.id, this.name, this.status, this.species, this.gender,
      this.origin, this.location, this.image, this.episode, this.created);

  DetailsCharacter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    gender = json['gender'];
    origin =
        (json['origin'] != null ? new Origin.fromJson(json['origin']) : null)!;
    location = (json['location'] != null
        ? new Origin.fromJson(json['location'])
        : null)!;
    image = json['image'];
    episode = json['episode'].cast<String>();
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['species'] = this.species;
    data['gender'] = this.gender;
    data['origin'] = this.origin.toJson();
    data['location'] = this.location.toJson();
    data['image'] = this.image;
    data['episode'] = this.episode;
    data['created'] = this.created;
    return data;
  }
}

class Origin {
  late String name;

  Origin(this.name);

  Origin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
