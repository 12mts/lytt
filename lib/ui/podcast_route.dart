import 'package:flutter/material.dart';
import 'package:lytt/ui/help_widgets.dart';

import '../controller.dart';
import '../podcast/podcast.dart';

typedef SelectPodcast = Function(Podcast podcast);
typedef AddPodcast = Function(String url);

class PodcastListWidget extends StatelessWidget {
  PodcastListWidget({
    required this.controller,
    required this.selectPodcast,
  }) : super(key: ObjectKey(controller));

  final Controller controller;
  final SelectPodcast selectPodcast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Podcasts"), actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddPodcastWidget(controller: controller)));
              },
              icon: const Icon(Icons.add))
        ]),
        body: StreamBuilder(
          stream: controller.getPodcasts(),
          builder: (context, AsyncSnapshot<List<Podcast>> podcasts) {
            if (podcasts.hasData) {
              return ListView(children: _podcastList(podcasts.requireData));
            }
            return ListView();
          },
        ));
  }

  List<Widget> _podcastList(List<Podcast> podcastList) {
    List<Widget> list = [];
    for (Podcast podcast in podcastList) {
      list.add(ListTile(
        leading: ImageWidget(imageFile: controller.imageFilePodcast(podcast)),
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
  AddPodcastWidget({
    required this.controller,
  }) : super(key: ObjectKey(controller));

  final Controller controller;
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
                controller.addPodcast(url);
                textEditingController.clear();
              }),
          Row(children: [
            Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      controller.addPodcast(textEditingController.text);
                      textEditingController.clear();
                    },
                    child: const Text("Save"))),
            Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      final Future<Podcast> podcast =
                          controller.podcastURL(textEditingController.text);
                      podcastPreview(podcast, context);
                    },
                    child: const Text("Preview"))),
          ])
        ]));
  }

  void podcastPreview(Future<Podcast> podcast, BuildContext context) async {
    Podcast pod = await podcast;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PodcastInfoWidget(podcast: pod);
      }
    );
  }
}


