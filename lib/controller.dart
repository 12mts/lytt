
import 'dart:convert';

import 'package:lytt/player.dart';
import 'package:lytt/player_audioplayers.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:lytt/podcast/podcast_library.dart';

import 'io_manager.dart';

class Controller {
  final _storage = StorageHandler();
  final _library = PodcastLibrary();
  final _web = WebHandler();
  late final PlayerController player;

  Controller() {
    player = PlayerController(this);
    _storage.readPodcastInfo().then(
        (string) => {
          _library.loadPodcasts(jsonDecode(string))
        }
    );
  }

  List<Podcast> getPodcasts() {
    return _library.podcasts;
  }

  void downloadEpisode(Episode episode) {
    _storage.downloadEpisode(episode);
  }

  void playEpisode(Episode episode) {
    player.playEpisode(episode);
  }

  void addPodcast(String url) async {
    await _library.addPodcast(_web.getAsString(url));
    _storage.writePodcastInfo(jsonEncode(_library));
  }
}

class PlayerController {
  final _storage = StorageHandler();
  Episode episode = Episode(
      "http://traffic.libsyn.com/hellointernet/HI20320--20Four20Light20Bulbs.mp3",
      "H.I. #3: Four Light Bulbs", "Hello Internet");
  late final Player _player;

  PlayerController(Controller controller) {
    _player = PlayerAudio(episode.url);
  }

  void playEpisode(Episode episode) {
    this.episode = episode;
    _player.setEpisode(_storage.episodeUri(episode));
  }

  bool startStop() {
    return _player.startStop();
  }

  String progress() {
    return _player.progress();
  }

  void setTime(int parse) {
    _player.setTime(parse);
  }

}