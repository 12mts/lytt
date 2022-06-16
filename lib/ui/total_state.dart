import 'package:flutter/material.dart';
import 'package:lytt/player.dart';
import 'package:lytt/podcast/total_podcast.dart';
import 'package:lytt/ui/player_route.dart';
import 'package:lytt/ui/podcast_route.dart';

class LyttApp extends StatefulWidget {
  const LyttApp({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LyttApp> createState() => _LyttApp();
}

class _LyttApp extends State<LyttApp> {
  // App state
  final lib = PodcastLibrary();
  final player = Player(
      "http://traffic.libsyn.com/hellointernet/HI20320--20Four20Light20Bulbs.mp3");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [
        IconButton(
            icon: const Icon(Icons.list),

            // Changes the page to list of episodes when
            // clicking the menu button
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      PodcastRoute().selectionPodcast(context, lib)));
            })
      ]),
      body: PlayerRoute().playerWidget(player, this),
    );
  }
}
