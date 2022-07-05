import 'package:audioplayers/audioplayers.dart';
import 'package:rxdart/rxdart.dart';

class Player {
  final _player = AudioPlayer();

  Player(url) {
    _player.setSourceUrl(url);
  }

  bool isPlaying() {
    return _player.state == PlayerState.playing;
  }

  Stream<bool> _isPlayingStream() async* {
    await for (PlayerState state in _player.onPlayerStateChanged) {
      yield state == PlayerState.playing;
    }
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

  Stream<Duration> _durationStream() {
    return _player.onDurationChanged;
  }

  Stream<Duration> _positionStream() {
    return _player.onPositionChanged;
  }

  Stream<PlayerDurationState> playerState() {
    return Rx.combineLatest3(
        _positionStream(),
        _durationStream(),
        _isPlayingStream(),
        (a, b, c) => PlayerDurationState(
            progress: a as Duration,
            total: b as Duration,
            isPlaying: c as bool));
  }
}

class PlayerDurationState {
  PlayerDurationState(
      {required this.progress, required this.total, required this.isPlaying});

  final Duration progress;
  final Duration total;
  final bool isPlaying;
}
