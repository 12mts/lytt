import 'package:flutter/material.dart';
import 'package:lytt/ui/episode_route.dart';
import 'package:lytt/ui/player_route.dart';
import 'package:lytt/ui/playlist_route.dart';
import 'package:lytt/ui/podcast_route.dart';

import '../manager/controller.dart';
import '../podcast/episode.dart';
import '../podcast/podcast.dart';

class LyttApp extends StatefulWidget {
  const LyttApp({Key? key}) : super(key: key);

  @override
  State<LyttApp> createState() => _LyttApp();
}

class _LyttApp extends State<LyttApp> {
  // App state
  final controller = Controller();

  void _playEpisode(Episode episode) {
    setState(() {
      controller.playEpisode(episode);
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  void _selectPodcast(Podcast podcast) {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EpisodeListWidget(
                  podcast: podcast,
                  controller: controller,
                  playEpisode: _playEpisode)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Player"), actions: [
        IconButton(
            icon: const Icon(
              Icons.grid_view_outlined,
            ),

            // Changes the page to list of episodes when
            // clicking the menu button
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PodcastListWidget(
                            controller: controller,
                            selectPodcast: _selectPodcast,
                          )));
            }),
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => PlaylistListWidget(controller)
              )
            );
          },
        )
      ]),
      body: PlayerWidget(controller: controller),
    );
  }
}
