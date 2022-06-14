import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lytt/player.dart';
import 'package:lytt/podcast.dart';
import 'package:lytt/storage_manager.dart';

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
                  MaterialPageRoute(builder: (context) => selectionPodcast()));
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

  /// The select podcasts and episodes
  Widget selectionPodcast() {
    return Scaffold(
        appBar: AppBar(title: const Text("Podcasts"), actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => newPodcastPage()));
              },
              icon: const Icon(Icons.add))
        ]),
        body: FutureBuilder(
          future: lib.getPodcasts(),
          builder: (BuildContext context, AsyncSnapshot<List<Podcast>> pod) {
            return ListView(children: podcastList(pod.requireData));
          },
        ));
  }

  /// Takes a podcast and returns list of all episodes as widgets
  List<Widget> podcastList(List<Podcast> podcastList) {
    List<Widget> list = [];
    for (Podcast p in podcastList) {
      list.add(ListTile(
        title: Text(p.name),
        onTap: () {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => selectionEpisodes(p)));
          });
        },
      ));
    }
    return list;
  }

  Widget selectionEpisodes(Podcast p) {
    return Scaffold(
        appBar: AppBar(title: Text(p.name)),
        body: ListView(children: episodeList(p)));
  }

  List<Widget> episodeList(Podcast p) {
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

  Widget newPodcastPage() {
    final s = StorageHandler();
    return Scaffold(
        appBar: AppBar(title: const Text("New podcast")),
        body: Column(children: [
          TextField(onSubmitted: (url) {
            lib.addPodcast(url);
            s.writeString(url);
          }),
          FutureBuilder(
              future: s.readString(),
              builder: (BuildContext context, AsyncSnapshot<String> last) {
                return Text(last.requireData);
              }),
        ]));
  }
}
