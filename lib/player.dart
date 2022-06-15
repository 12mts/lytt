import 'package:just_audio/just_audio.dart';
import 'package:lytt/podcast/podcast.dart';

class Player {
  final _player = AudioPlayer();

  Player(url) {
    _player.setUrl(url);
  }

  void setEpisode(Podcast podcast, Episode episode) async {
    _player.setAudioSource(AudioSource.uri(await episode.uri()));
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
