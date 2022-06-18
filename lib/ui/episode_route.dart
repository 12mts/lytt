import 'dart:io';

import 'package:flutter/material.dart';

import '../controller.dart';
import '../podcast/episode.dart';
import '../podcast/podcast.dart';

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
            FutureBuilder(
                future: controller
                    .imageFile(podcast.title),
                builder: (BuildContext context, AsyncSnapshot<File> file) {
                  return Image.file(file.requireData, height: 50);
                }),
            Text(podcast.title)
          ]),
          Expanded(child: ListView(children: episodeList(controller, podcast)))
        ]));
  }

  List<Widget> episodeList(Controller controller, Podcast podcast) {
    List<Widget> list = [];
    for (Episode episode in podcast.episodes) {
      list.add(Card(
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  playEpisode(episode);
                },
                icon: const Icon(Icons.play_arrow)),
            Text(episode.title),

            IconButton(
                onPressed: () {
                  downloadEpisode(episode);
                },
                icon: const Icon(Icons.file_download))
          ],
        ),
      ));
    }
    return list;
  }
}
