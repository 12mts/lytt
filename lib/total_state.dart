import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lytt/player.dart';
import 'package:lytt/podcast.dart';

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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => episodes()));
            }),
      ]),
      body: playerWidget(player),
    );
  }

  /// The player widget
  Widget playerWidget(Player player) {
    var playPause = "play";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Hello Internet"),
        OutlinedButton(
          onPressed: () {
            setState(() {
              playPause = player.startStop() ? "Play" : "Pause";
            });
          },
          child: Text(playPause),
        ),
        Text(player.progress()),
        TextField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          onSubmitted: (time) {
            player.setTime(int.parse(time));
          },
        )
      ],
    );
  }

  /// The episode list widget
  Widget episodes() {
    return Scaffold(
        appBar: AppBar(title: const Text("List")),
        body: FutureBuilder(
          future: lib.getPodcast(),
          builder: (BuildContext context, AsyncSnapshot<Podcast> pod) {
            return ListView(children: podcast(pod.requireData));
          },
        ));
  }

  /// Takes a podcast and returns list of all episodes as widgets
  List<Widget> podcast(Podcast p) {
    List<Widget> list = [];
    for (Episode e in p.list) {
      list.add(ListTile(
        title: Text(e.name),
        onTap: () {
          setState(() {
            player.setURL(e.url);
          });
        },
      ));
    }
    return list;
  }
}
