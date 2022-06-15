import 'package:just_audio/just_audio.dart';
import 'package:lytt/podcast.dart';
import 'package:lytt/storage_manager.dart';

class Player {
  final _player = AudioPlayer();
  final _storage = StorageHandler();

  Player(url) {
    _player.setUrl(url);
  }

  void setEpisode(Episode episode) async {
    _player.setAudioSource(await _storage.episodeSource(episode));
  }

  bool isPlaying() {
    return _player.playing;
  }

  bool startStop() {
    if (isPlaying()) {
      _player.pause();
      return isPlaying();
    }
    _player.play();
    return isPlaying();
  }

  String progress() {
    return '${(_player.position).toString()}'
        '/${(_player.duration).toString()}';
  }

  void setTime(int time) {
    _player.seek(Duration(seconds: time));
  }
}
