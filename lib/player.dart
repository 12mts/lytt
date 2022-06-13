import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
//import 'package:lytt/audiofiles.dart';

class Player {
  final player = AudioPlayer();

  Player(url) {
    //var file = AudioFile(url);
    //player.setSource(DeviceFileSource(file.path));
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

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});

  @override
  State createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final player = Player("http://traffic.libsyn.com/hellointernet/HI201.mp3");
  var playpause = "play";

  void setTimer() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Hello Internet"),
        OutlinedButton(
          onPressed: () {
            setState(() {
              playpause = player.startStop() ? "Play" : "Pause";
              if (player.isPlaying()) {
                Timer.periodic(const Duration(seconds: 1), (_) => setTimer());
              }
            });
          },
          child: Text(playpause),
        ),
        /*
        FutureBuilder(
          future: player.progress(),
            builder: (BuildContext context, AsyncSnapshot<String> progress) {
            return Text(progress.requireData);
            }
        ),
        */
        Text(player.progress()),
        TextField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          onSubmitted: (time) {
            player.setTime(int.parse(time));
          },
        )
      ],
    );
  }
}
