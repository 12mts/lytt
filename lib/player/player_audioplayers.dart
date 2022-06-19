
import 'package:audioplayers/audioplayers.dart';
import 'package:rxdart/rxdart.dart';

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

  Stream<PlayerDurationState> playerState() {
    return Rx.combineLatest2(positionStream(), durationStream(),
            (a, b) => PlayerDurationState(progress: a as Duration, total: b as Duration));
  }
}

class PlayerDurationState {
  PlayerDurationState({required this.progress, required this.total});

  final Duration progress;
  final Duration total;
}
