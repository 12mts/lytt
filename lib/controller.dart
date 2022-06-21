import 'dart:convert';
import 'dart:io';

import 'package:lytt/player/player.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:lytt/podcast/podcast_library.dart';

import 'io_manager.dart';

class Controller {
  final _storage = StorageHandler();
  PodcastLibrary _library = PodcastLibrary();
  final _web = WebHandler();
  late final PlayerController player;

  Controller() {
      _storage.readPodcastInfo().then(
          (string) => {
            if (string != null) {
              _library = PodcastLibrary.fromJson(jsonDecode(string))
            }
          });
    player = PlayerController(this);
  }

  Stream<List<Podcast>> getPodcasts() {
    return _library.getPodcastStream();
  }

  void playEpisode(Episode episode) {
    player.playEpisode(episode);
  }

  Future<Podcast> addPodcast(String url) async {
    final podcast = await _library.addPodcast(_web.getAsString(url));
    _storage.downloadImage(podcast);
    _storage.writePodcastInfo(jsonEncode(_library));
    return podcast;
  }

  Future<File> imageFile(String podcastTitle) {
    return _storage.localFileImage(podcastTitle);
  }
}

class PlayerController {
  final _storage = StorageHandler();
  Episode episode = Episode(
      "http://traffic.libsyn.com/hellointernet/HI20320--20Four20Light20Bulbs.mp3",
      "H.I. #3: Four Light Bulbs",
      "Hello Internet");
  late final Player _player;

  PlayerController(Controller controller) {
    _player = Player(episode.url);
  }

  void playEpisode(Episode episode) {
    this.episode = episode;
    _player.setEpisode(_storage.episodeUri(episode));
  }

  bool startStop() {
    return _player.startStop();
  }

  Stream<PlayerDurationState> playerState() {
    return _player.playerState();
  }

  void setTime(Duration duration) {
    _player.setTime(duration);
  }
}
