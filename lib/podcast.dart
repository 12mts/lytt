
class Episode {
  var url;
  var name;
  var id;
  var description;

  Episode(this.url, this.name, this.description);
}

class Podcast {
  var name;
  final list = [];

  Podcast(this.name);

  void addEpisode(Episode e) {
    list.add(e);
  }
}