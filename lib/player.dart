import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:lytt/audiofiles.dart';

class Player {
  final player = AudioPlayer();

  Player(url) {
    //var file = AudioFile(url);
    //player.setSource(DeviceFileSource(file.path));
    player.setSourceUrl(url);
  }

  void setURL(url) {
    player.setSourceUrl(url);
  }

  bool isPlaying() {
    return player.state == PlayerState.playing;
  }

  bool startStop() {
    if (isPlaying()) {
      player.pause();
      return false;
    }
    player.resume();
    return true;
  }

  Future<String> progress() async {
    return '${(await player.getCurrentPosition()).toString()}'
        '/${(await player.getDuration()).toString()}';
  }

  void setTime(int time) {
    player.seek(Duration(seconds: time));
  }

}

class PlayerWidget extends StatefulWidget{
  const PlayerWidget({super.key});

  @override
  State createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final player = Player("http://traffic.libsyn.com/hellointernet/HI201.mp3");
  var playpause = "play";

  void setTimer() {

  }

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
                Timer.periodic(const Duration(seconds: 1),
                        (_) => setTimer());
              }
            });
          },
          child: Text(playpause),
        ),
        FutureBuilder(
          future: player.progress(),
            builder: (BuildContext context, AsyncSnapshot<String> progress) {
            return Text(progress.requireData);
            }
        ),
        //Text(player.progress()),
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
