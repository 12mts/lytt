
import 'package:audioplayers/audioplayers.dart';
import 'package:lytt/player.dart';

class PlayerAudio implements Player {
  final _player = AudioPlayer();

  PlayerAudio(url) {
    _player.setSourceUrl(url);
  }

  @override
  bool isPlaying() {
    return _player.state == PlayerState.playing;
  }

  @override
  String progress() {
    return "---";
  }

  @override
  void setEpisode(Future<Uri> uri) async {
    _player.play(UrlSource((await uri).toString()));
  }

  @override
  void setTime(int time) async {
    await _player.seek(Duration(seconds: time));
  }

  @override
  bool startStop() {
    if (isPlaying()) {
      _player.pause();
      return false;
    }
    _player.resume();
    return true;
  }

}