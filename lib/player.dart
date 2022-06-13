
import 'package:just_audio/just_audio.dart';


class Player {
  final player = AudioPlayer();

  Player(url) {
    player.setUrl(url);
  }

  void setURL(url) {
    player.setUrl(url);
  }

  bool isPlaying() {
    return player.playing;
  }

  bool startStop() {
    if (isPlaying()) {
      player.pause();
      return isPlaying();
    }
    player.play();
    return isPlaying();
  }

  String progress() {
    return '${(player.position).toString()}'
        '/${(player.duration).toString()}';
  }

  void setTime(int time) {
    player.seek(Duration(seconds: time));
  }
}
