
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
  final list = [];

  void addPodcast(url) {
    _createPodcast(url).then((value) {
      list.add(value);
    });
  }

  Future<Podcast> _createPodcast(String url) async {
    final client = IOClient();
    var response = await client.get(Uri.parse(url));
    var feed = RssFeed.parse(response.body);

    final pod = Podcast(feed.title);
    var list = feed.items;
    if (list!=null) {
      for (var ep in list) {
        pod.addEpisode(Episode(ep.enclosure?.url, ep.title));
      }
    }

    return pod;
  }
}
