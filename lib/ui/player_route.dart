import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lytt/controller.dart';
import 'package:lytt/ui/total_state.dart';

class PlayerRoute {

  /// The player widget
  static Widget playerWidget(PlayerController player, State<LyttApp> state) {
    String playPause = "play";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(player.episode.title),
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