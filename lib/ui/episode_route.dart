
import 'package:flutter/material.dart';

import '../podcast/episode.dart';
import '../podcast/podcast.dart';

class EpisodeRoute {
  Widget selectionEpisodes(Podcast p) {
    return Scaffold(
        appBar: AppBar(title: Text(p.title)),
        body: ListView(children: episodeList(p)));
  }

  List<Widget> episodeList(Podcast p) {
    List<Widget> list = [];
    for (Episode e in p.episodes) {
      list.add(Card(
        child: Row(
          children: [
            Text(e.title),
            IconButton(onPressed: () {
              """player.setEpisode(p, e)""";},
                icon: const Icon(Icons.play_arrow)),
            IconButton(onPressed: () {
              e.download();
            }, icon: const Icon(Icons.file_download))
          ],
        ),
      ));
    }
    return list;
  }
}