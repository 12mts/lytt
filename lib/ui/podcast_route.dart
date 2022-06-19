import 'package:flutter/material.dart';
import 'package:lytt/ui/image_widget.dart';

import '../controller.dart';
import '../podcast/podcast.dart';

typedef SelectPodcast = Function(Podcast podcast);
//typedef AddPodcastRoute = Function();
typedef AddPodcast = Function(String url);

class PodcastListWidget extends StatelessWidget {
  PodcastListWidget(
      {required this.controller,
      required this.selectPodcast,
      required this.addPodcast})
      : super(key: ObjectKey(controller));

  final Controller controller;
  final SelectPodcast selectPodcast;
  final AddPodcast addPodcast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Podcasts"), actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AddPodcastWidget(controller: controller,
                      addPodcast: addPodcast)
                ));
              },
              icon: const Icon(Icons.add))
        ]),
        body: ListView(children: _podcastList(context, controller)));
  }

  List<Widget> _podcastList(BuildContext context, Controller controller) {
    List<Widget> list = [];
    for (Podcast p in controller.getPodcasts()) {
      list.add(ListTile(
        leading: ImageWidget(imageFile: controller.imageFile(p.title)),
        title: Text(p.title),
        onTap: () {
          selectPodcast(p);
        },
      ));
    }
    return list;
  }
}


class AddPodcastWidget extends StatelessWidget {
  AddPodcastWidget({required this.controller, required this.addPodcast})
      : super(key: ObjectKey(controller));

  final Controller controller;
  final AddPodcast addPodcast;
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("New podcast")),
        body: Column(children: [
          TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "RSS url"
            ),
              onSubmitted: (url) {
            addPodcast(url);
          }),
          OutlinedButton(onPressed: () {addPodcast(textEditingController.text);},
              child: const Text("Save"))
        ]));
  }
}
