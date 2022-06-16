
import 'package:flutter/material.dart';

import '../controller.dart';
import '../podcast/podcast.dart';
import 'episode_route.dart';

class PodcastRoute {
  /// The select podcasts and episodes
  Widget selectionPodcast(BuildContext context, Controller controller) {
    return Scaffold(
        appBar: AppBar(title: const Text("Podcasts"), actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => _newPodcastPage(controller)));
              },
              icon: const Icon(Icons.add))
        ]),
        body: ListView(children: _podcastList(context, controller)));
  }

  /// Takes a podcast and returns list of all episodes as widgets
  List<Widget> _podcastList(BuildContext context, Controller controller) {
    List<Widget> list = [];
    for (Podcast p in controller.getPodcasts()) {
      list.add(ListTile(
        title: Text(p.title),
        onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    EpisodeRoute().selectionEpisodes(controller, p)));
        },
      ));
    }
    return list;
  }

  Widget _newPodcastPage(Controller controller) {
    return Scaffold(
        appBar: AppBar(title: const Text("New podcast")),
        body: Column(children: [
          TextField(onSubmitted: (url) {
            controller.addPodcast(url);
          }),
        ]));
  }
}