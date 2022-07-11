
import 'package:flutter/material.dart';

import '../manager/controller.dart';
import '../podcast/podcast.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget({required this.imageFile, this.height})
      : super(key: ObjectKey(imageFile));

  final Future<Image?> imageFile;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: imageFile,
        builder: (BuildContext context, AsyncSnapshot<Image?> file) {
          if (file.hasData) {
            return SizedBox(
              height: height,
                child: file.data ?? noImageWidget(height));
          }
          return noImageWidget(height);
        });
  }

  static Widget noImageWidget(double? height) {
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
  }
}

class PodcastInfoWidget extends StatelessWidget {
  final Podcast podcast;
  final controller = Controller();

  PodcastInfoWidget({Key? key, required this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ImageWidget(imageFile: controller.imageFilePodcast(podcast), height: 60),
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
