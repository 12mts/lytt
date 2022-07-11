import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:lytt/manager/controller.dart';
import 'package:lytt/ui/help_widgets.dart';

import '../player/player.dart';
import '../podcast/episode.dart';

typedef PlayButtonPress = Function();

class PlayerWidget extends StatelessWidget {
  PlayerWidget({required this.controller}) : super(key: ObjectKey(controller));

  final Controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StreamBuilder(
          stream: controller.player.episodeStream.stream,
          builder: (BuildContext context, AsyncSnapshot<Episode?> episode) {
            if (!episode.hasData) {
              return Expanded(
                  child:
                  Column(
                    children: [
                      Expanded( child:ImageWidget.noImageWidget(null)),
                      const Text("-"),
                    ],
                  ));
            }
            final ep = episode.data!;
            return Expanded(
            child:
              Column(
              children: [
              Expanded( child:ImageWidget(
                  imageFile: controller.imageFile(ep.podcastId),
                )),
                Text(ep.title),
              ],
            ));
          }),
      StreamBuilder(
          stream: controller.player.playerState(),
          builder:
              (BuildContext context, AsyncSnapshot<PlayerDurationState> time) {
            final state = time.data;
            return Column(children: [
              OutlinedButton(
                key: const Key("play_button"),
                onPressed: () {
                  controller.player.startStop();
                },
                child: Icon((state?.isPlaying ?? false)
                    ? Icons.pause
                    : Icons.play_arrow),
              ),
              ProgressBar(
                progress: state?.progress ?? Duration.zero,
                total: state?.total ?? Duration.zero,
                onSeek: (duration) {
                  controller.player.setTime(duration);
                },
              )
            ]);
          })
    ]);
  }
}
