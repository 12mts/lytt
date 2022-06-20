import 'package:flutter/material.dart';
import 'package:lytt/download_handler.dart';

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
      required this.playEpisode})
      : super(key: ObjectKey(controller));

  final Podcast podcast;
  final Controller controller;
  final PlayEpisode playEpisode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(podcast.title)),
        body: Column(children: [
          Row(children: [
            ImageWidget(
                imageFile: controller.imageFile(podcast.title), height: 60),
            Text(podcast.title)
          ]),
          Expanded(child: ListView(children: episodeList(controller, podcast)))
        ]));
  }

  List<Widget> episodeList(Controller controller, Podcast podcast) {
    List<Widget> list = [];
    for (Episode episode in podcast.episodes) {
      list.add(EpisodeListItemWidget(episode: episode,
          playEpisode: playEpisode,));
    }
    return list;
  }
}

class EpisodeListItemWidget extends StatelessWidget {
  EpisodeListItemWidget(
      {required this.episode, required this.playEpisode, Key? key})
      : super(key: key) {
    handler = DownloadHandler(episode);
  }

  final Episode episode;
  late final DownloadHandler handler;
  final PlayEpisode playEpisode;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: IconButton(
            onPressed: () {
              playEpisode(episode);
            },
            icon: const Icon(Icons.play_arrow)),
        title: Text(episode.title),
        trailing: StreamBuilder(
          stream: handler.getDownloadState(),
          builder:
              (BuildContext context, AsyncSnapshot<DownloadState> downloaded) {
            if (downloaded.hasData) {
              final data = downloaded.requireData;
              if (data == DownloadState.notDownloaded) {
                return IconButton(
                    onPressed: () {
                      handler.download();
                    },
                    icon: const Icon(Icons.download));
              } else if (data == DownloadState.isDownloading) {
                return IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.downloading),
                );
              } else {
                return IconButton(
                    onPressed: () {
                      handler.download();
                    },
                    icon: const Icon(Icons.download_done));
              }
            }
            return const Text("ok");
          },
        ));
  }
}
