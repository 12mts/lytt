import 'dart:io';

import 'package:flutter/material.dart';

import '../controller.dart';
import '../podcast/podcast.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget({required this.imageFile, this.height})
      : super(key: ObjectKey(imageFile));

  final Future<File> imageFile;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> file) {
          if (file.hasData) {
            return Image.file(
              file.requireData,
              height: height,
            );
          }
          return Container(
              height: height,
              color: Colors.black12,
              child: const AspectRatio(
                  aspectRatio: 1,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(" ʕ•ᴥ•ʔ ",
                        style: TextStyle(color: Colors.blueGrey)),
                  )));
        });
  }
}

class PodcastInfoWidget extends StatelessWidget {
  final Podcast podcast;
  final controller = Controller();

  PodcastInfoWidget({Key? key, required this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ImageWidget(imageFile: controller.imageFile(podcast.title), height: 60),
      Expanded(
          child: SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            Text(podcast.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(podcast.description ?? ""),
          ]))),
    ]);
  }
}
