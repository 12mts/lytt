import 'package:flutter/material.dart';
import 'package:lytt/download_handler.dart';

import '../controller.dart';
import '../podcast/episode.dart';
import '../podcast/podcast.dart';
import 'help_widgets.dart';

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
        appBar: AppBar(title: Text(podcast.title),
        actions: [
          IconButton(onPressed: () => controller.updatePodcast(podcast),
              icon: const Icon(Icons.replay))
        ],),
        body: Column(children: [
          PodcastInfoWidget(podcast: podcast),
          Expanded(child: ListView(children: episodeList(controller, podcast)))
        ]));
  }

  List<Widget> episodeList(Controller controller, Podcast podcast) {
    List<Widget> list = [];
    for (Episode episode in podcast.episodeList) {
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
              } else if (data == DownloadState.downloaded) {
                return IconButton(
                    onPressed: () {
                      handler.delete();
                    },
                    icon: const Icon(Icons.download_done));
              }
            }
            return const Text("ok");
          },
        ));
  }
}
