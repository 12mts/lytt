
import 'package:flutter/material.dart';

import '../controller.dart';
import '../podcast/episode.dart';
import '../podcast/podcast.dart';

class EpisodeRoute {
  Widget selectionEpisodes(Controller controller, Podcast p) {
    return Scaffold(
        appBar: AppBar(title: Text(p.title)),
        body: ListView(children: episodeList(controller, p)));
  }

  List<Widget> episodeList(Controller controller, Podcast p) {
    List<Widget> list = [];
    for (Episode e in p.episodes) {
      list.add(Card(
        child: Row(
          children: [
            Text(e.title),
            IconButton(onPressed: () {
              controller.playEpisode(e);},
                icon: const Icon(Icons.play_arrow)),
            IconButton(onPressed: () {
              controller.downloadEpisode(e);
            }, icon: const Icon(Icons.file_download))
          ],
        ),
      ));
    }
    return list;
  }
}