import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lytt/controller.dart';

typedef PlayButtonPress = Function();

class PlayerWidget extends StatelessWidget {
  PlayerWidget({required this.controller,
  required this.playButtonPress})
      : super(key: ObjectKey(controller));

  final Controller controller;
  final PlayButtonPress playButtonPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: FutureBuilder(
                future: controller
                    .imageFile(controller.player.episode.podcastTitle),
                builder: (BuildContext context, AsyncSnapshot<File> file) {
                  return Image.file(file.requireData);
                })),
        Text(controller.player.episode.title),
        OutlinedButton(
          onPressed: () {
            playButtonPress();
          },
          child: Icon(controller.player.isPlaying() ? Icons.pause : Icons.play_arrow),
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
