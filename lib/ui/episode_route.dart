import 'package:flutter/material.dart';

import '../controller.dart';
import '../podcast/episode.dart';
import '../podcast/podcast.dart';
import 'image_widget.dart';

typedef DownloadEpisode = Function(Episode episode);
typedef PlayEpisode = Function(Episode episode);

class EpisodeListWidget extends StatelessWidget {
  EpisodeListWidget(
      {required this.podcast,
      required this.controller,
      required this.downloadEpisode,
      required this.playEpisode})
      : super(key: ObjectKey(controller));

  final Podcast podcast;
  final Controller controller;
  final DownloadEpisode downloadEpisode;
  final PlayEpisode playEpisode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(podcast.title)),
        body: Column(children: [
          Row(children: [
            ImageWidget(
                imageFile: controller.imageFile(podcast.title),
                height: 60),
            Text(podcast.title)
          ]),
          Expanded(child: ListView(children: episodeList(controller, podcast)))
        ]));
  }

  List<Widget> episodeList(Controller controller, Podcast podcast) {
    List<Widget> list = [];
    for (Episode episode in podcast.episodes) {
      list.add(ListTile(
        leading: IconButton(
            onPressed: () {
              playEpisode(episode);
            },
            icon: const Icon(Icons.play_arrow)),
        title: Text(episode.title),
        trailing: IconButton(
            onPressed: () {
              downloadEpisode(episode);
            },
            icon: const Icon(Icons.file_download))
      ));
    }
    return list;
  }
}
