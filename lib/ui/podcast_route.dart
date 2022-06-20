import 'package:flutter/material.dart';
import 'package:lytt/ui/image_widget.dart';

import '../controller.dart';
import '../podcast/podcast.dart';

typedef SelectPodcast = Function(Podcast podcast);
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPodcastWidget(
                            controller: controller, addPodcast: addPodcast)));
              },
              icon: const Icon(Icons.add))
        ]),
        body: StreamBuilder(
          stream: controller.getPodcasts(),
          builder: (context, AsyncSnapshot<List<Podcast>> podcasts) {
            return ListView(children: _podcastList(podcasts.requireData));
          },
        )

        );
  }

  List<Widget> _podcastList(List<Podcast> podcastList) {
    List<Widget> list = [];
    for (Podcast podcast in podcastList) {
      list.add(ListTile(
        leading: ImageWidget(imageFile: controller.imageFile(podcast.title)),
        title: Text(podcast.title),
        onTap: () {
          selectPodcast(podcast);
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
                  border: UnderlineInputBorder(), labelText: "RSS url"),
              onSubmitted: (url) {
                addPodcast(url);
              }),
          OutlinedButton(
              onPressed: () {
                addPodcast(textEditingController.text);
              },
              child: const Text("Save"))
        ]));
  }
}
