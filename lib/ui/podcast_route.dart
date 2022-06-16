
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../podcast/podcast.dart';
import '../podcast/total_podcast.dart';
import 'episode_route.dart';

class PodcastRoute {
  /// The select podcasts and episodes
  Widget selectionPodcast(context, PodcastLibrary lib) {
    return Scaffold(
        appBar: AppBar(title: const Text("Podcasts"), actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => _newPodcastPage(lib)));
              },
              icon: const Icon(Icons.add))
        ]),
        body: FutureBuilder(
          future: lib.getPodcasts(),
          builder: (BuildContext context, AsyncSnapshot<List<Podcast>> pod) {
            return ListView(children: _podcastList(context, pod.requireData));
          },
        ));
  }

  /// Takes a podcast and returns list of all episodes as widgets
  List<Widget> _podcastList(context, List<Podcast> podcastList) {
    List<Widget> list = [];
    for (Podcast p in podcastList) {
      list.add(ListTile(
        title: Text(p.title),
        onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EpisodeRoute().selectionEpisodes(p)));
        },
      ));
    }
    return list;
  }

  Widget _newPodcastPage(PodcastLibrary lib) {
    return Scaffold(
        appBar: AppBar(title: const Text("New podcast")),
        body: Column(children: [
          TextField(onSubmitted: (url) {
            lib.addPodcast(url);
          }),
        ]));
  }
}