import 'package:http/io_client.dart';
import 'package:webfeed/webfeed.dart';

class Episode {
  var url;
  var name;

  Episode(this.url, this.name);

  Map<String, dynamic> toJson() => {
    'url' : url,
    'name' : name
  };
}

class Podcast {
  String name;
  String url;
  final List<Episode> episodes = [];

  Podcast(this.name, this.url);

  void addEpisode(Episode e) {
    episodes.add(e);
  }

  Map<String, dynamic> toJson() => {
    'name' : name,
    'url' : url,
    'episodes' : episodes
  };
}

/// Library for managing podcasts
class PodcastLibrary {
  final List<Podcast> list = [];

  /// Creates HI when started
  PodcastLibrary() {
    addPodcast("http://www.hellointernet.fm/podcast?format=rss");
  }

  Future<List<Podcast>> getPodcasts() async {
    return list;
  }

  void addPodcast(url) async {
    list.add(await _createPodcast(url));
  }

  Future<Podcast> _createPodcast(String url) async {
    final client = IOClient();
    var response = await client.get(Uri.parse(url));
    var feed = RssFeed.parse(response.body);

    final pod = Podcast(feed.title ?? "-", url);
    var list = feed.items;
    if (list != null) {
      for (var ep in list) {
        pod.addEpisode(Episode(ep.enclosure?.url, ep.title));
      }
    }

    return pod;
  }

  Map<String, dynamic> toJson() => {
    "podcasts" : list
  };
}
