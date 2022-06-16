import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lytt/controller.dart';
import 'package:lytt/ui/total_state.dart';

class PlayerRoute {
  /// The player widget
  static Widget playerWidget(Controller controller, State<LyttApp> state) {
    String playPause = "play";
    final episode = controller.player.episode;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: FutureBuilder(
                future: controller.imageFile(episode.podcastTitle),
                builder: (BuildContext context, AsyncSnapshot<File> file) {
                  return Image.file(file.requireData);
                })),
        Text(episode.title),
        OutlinedButton(
          onPressed: () {
            playPause = controller.player.startStop() ? "Play" : "Pause";
          },
          child: Text(playPause),
        ),
        Text(controller.player.progress()),
        TextField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          onSubmitted: (time) {
            controller.player.setTime(int.parse(time));
          },
        )
      ],
    );
  }
}
