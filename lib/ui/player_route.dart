import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lytt/ui/total_state.dart';

import '../player.dart';

class PlayerRoute {

  /// The player widget
  Widget playerWidget(Player player, State<LyttApp> state) {
    var playPause = "play";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Hello Internet"),
        OutlinedButton(
          onPressed: () {
              playPause = player.startStop() ? "Play" : "Pause";
          },
          child: Text(playPause),
        ),
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