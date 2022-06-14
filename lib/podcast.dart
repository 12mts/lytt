import 'package:http/io_client.dart';
import 'package:webfeed/webfeed.dart';

class Episode {
  var url;
  var name;

  Episode(this.url, this.name);
}

class Podcast {
  var name;
  final list = [];

  Podcast(this.name);

  void addEpisode(Episode e) {
    list.add(e);
  }
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

  /// Returns HI for now
  Future<Podcast> getPodcast() async {
    return list[0];
  }

  void addPodcast(url) async {
    list.add(await _createPodcast(url));
  }

  Future<Podcast> _createPodcast(String url) async {
    final client = IOClient();
    var response = await client.get(Uri.parse(url));
    var feed = RssFeed.parse(response.body);

    final pod = Podcast(feed.title);
    var list = feed.items;
    if (list != null) {
      for (var ep in list) {
        pod.addEpisode(Episode(ep.enclosure?.url, ep.title));
      }
    }

    return pod;
  }
}
