class Cast {
  List<Actor> actores = [];

  Cast.fromJsonMap(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((element) {
      final actor = Actor.fromJsonMap(element);
      actores.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.order,
    this.name,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    try {
      castId = json['cast_id'];
      character = json['character'];
      creditId = json['credit_id'];
      gender = json['gender'];
      id = json['id'];
      order = json['order'];
      name = json['name'];
      profilePath = json['profile_path'];
    } catch (e) {
      print(e);
    }
  }

  getFotoImg() {
    if (profilePath == null)
      return 'https://748073e22e8db794416a-cc51ef6b37841580002827d4d94d19b6.ssl.cf3.rackcdn.com/not-found.png';
    else
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
