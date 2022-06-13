import 'package:flutter/material.dart';
import 'package:lytt/player.dart';
import 'package:lytt/podcast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the front page
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lytt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Player'),
    );
  }
}

// Homepage
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Hompage state
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top bare
      appBar: AppBar(title: Text(widget.title), actions: [
        IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PodcastList())
              );
            },
            tooltip: 'Saved Suggestions'),
      ]),
      body: const PlayerWidget(),
    );
  }
}

class PodcastList extends StatefulWidget {
  const PodcastList({super.key});

  @override
  State createState() => _PodcastList();
}

class _PodcastList extends State<PodcastList> {
  var lib = PodcastLibrary();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("List")
        ),
        body: FutureBuilder(
          future: lib.getPodcast(),
          builder: (BuildContext context, AsyncSnapshot<Podcast> pod) {
            return ListView(children: podcast(pod.requireData));
          },
        )
    );
  }

  List<Widget> podcast(Podcast p) {
    List<Widget> list = [];
    for (Episode e in p.list) {
      list.add(Text(e.name));
    }
    return list;
  }
}
