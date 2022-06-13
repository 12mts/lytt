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

class PodcastLibrary {
  final List<Podcast> list = [];

  PodcastLibrary();

  /**
   * Not done propery. Needs to be handled with futrure
   */
  Future<Podcast> getPodcast() {
    return _createPodcast("http://www.hellointernet.fm/podcast?format=rss");
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
