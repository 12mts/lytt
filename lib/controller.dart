
import 'package:lytt/player.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:lytt/podcast/podcast_library.dart';

import 'io_manager.dart';

class Controller {
  final _storage = StorageHandler();
  final _library = PodcastLibrary();
  final player = Player("http://traffic.libsyn.com/hellointernet/HI20320--20Four20Light20Bulbs.mp3");
  final _web = WebHandler();

  Controller() {
    _library.loadPodcast(_storage.readString());
  }

  List<Podcast> getPodcasts() {
    return _library.podcasts;
  }

  void downloadEpisode(Episode episode) {
    _storage.downloadFile(episode);
  }

  void playEpisode(Episode episode) {
    player.setEpisode(_storage.episodeUri(episode));
  }

  void addPodcast(String url) {
    _library.addPodcast(_web.getAsString(url));
  }

}