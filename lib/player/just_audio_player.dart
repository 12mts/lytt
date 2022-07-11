/*
import 'package:just_audio/just_audio.dart';
import 'package:lytt/player/player.dart';
import 'package:rxdart/rxdart.dart';


 */
///
/// NO LEFT SOUND; NOT IN USE
///
/*
class PlayerJA implements Player {
  final _player = AudioPlayer();

  PlayerJA(url) {
    _player.setUrl(url);
  }

  Stream<Duration?> _durationStream() {
    return _player.durationStream;
  }

  @override
  bool isPlaying() {
    return _player.playing;
  }

  Stream<bool> _isPlayingStream() {
    return _player.playingStream;
  }

  @override
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

  Stream<Duration> _positionStream() {
    return _player.positionStream;
  }

  @override
  void setEpisode(Future<Uri> uri) async {
    _player.setAudioSource(AudioSource.uri(await uri));
  }

  @override
  void setTime(Duration duration) {
    _player.seek(duration);
  }

  @override
  bool startStop() {
    if (isPlaying()) {
      _player.pause();
      return false;
    }
    _player.play();
    return true;
  }
}

 */