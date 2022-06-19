
import 'dart:convert';
import 'dart:io';

import 'package:lytt/player/player_audioplayers.dart';
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
    final podcast = await _library.addPodcast(_web.getAsString(url));
    _storage.downloadImage(podcast);
    _storage.writePodcastInfo(jsonEncode(_library));
  }

  Future<File> imageFile(String podcastTitle) {
    return _storage.localFileImage(podcastTitle);
  }
}

class PlayerController {
  final _storage = StorageHandler();
  Episode episode = Episode(
      "http://traffic.libsyn.com/hellointernet/HI20320--20Four20Light20Bulbs.mp3",
      "H.I. #3: Four Light Bulbs", "Hello Internet");
  late final PlayerAudio _player;

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

  Stream<Duration> positionStream() {
    return _player.positionStream();
  }

  Stream<Duration> durationStream() {
    return _player.durationStream();
  }

  Stream<PlayerDurationState> playerState() {
    return _player.playerState();
  }

  void setTime(Duration duration) {
    _player.setTime(duration);
  }

  bool isPlaying() {
    return _player.isPlaying();
  }

}
