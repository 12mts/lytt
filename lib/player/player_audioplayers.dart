
import 'package:audioplayers/audioplayers.dart';

class PlayerAudio {
  final _player = AudioPlayer();

  PlayerAudio(url) {
    _player.setSourceUrl(url);
  }

  bool isPlaying() {
    return _player.state == PlayerState.playing;
  }

  void setEpisode(Future<Uri> uri) async {
    _player.play(UrlSource((await uri).toString()));
  }

  void setTime(Duration duration) async {
    await _player.seek(duration);
  }

  bool startStop() {
    if (isPlaying()) {
      _player.pause();
      return false;
    }
    _player.resume();
    return true;
  }

  Stream<Duration> durationStream() {
    return _player.onDurationChanged;
  }

  Stream<Duration> positionStream() {
    return _player.onPositionChanged;
  }
}