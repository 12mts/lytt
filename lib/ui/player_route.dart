import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:lytt/controller.dart';
import 'package:lytt/player/player.dart';
import 'package:lytt/ui/image_widget.dart';

typedef PlayButtonPress = Function();

class PlayerWidget extends StatelessWidget {
  PlayerWidget({required this.controller, required this.playButtonPress})
      : super(key: ObjectKey(controller));

  final Controller controller;
  final PlayButtonPress playButtonPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ImageWidget(
                imageFile: controller
                    .imageFile(controller.player.episode.podcastTitle))),
        Text(controller.player.episode.title),
        OutlinedButton(
          onPressed: () {
            playButtonPress();
          },
          child: Icon(
              controller.player.isPlaying() ? Icons.pause : Icons.play_arrow),
        ),
        StreamBuilder(
            stream: controller.player.playerState(),
            builder: (BuildContext context, AsyncSnapshot<PlayerDurationState> time) {
              final state = time.data;
              return ProgressBar(
                progress: state?.progress ?? Duration.zero,
                total: state?.total ?? Duration.zero,
                onSeek: (duration) {
                  controller.player.setTime(duration);
                },
              );
            }),
      ],
    );
  }
}
