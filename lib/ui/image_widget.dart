import 'dart:io';

import 'package:flutter/widgets.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget({
    required this.imageFile,
    this.height
  }) : super(key: ObjectKey(imageFile));

  final Future<File> imageFile;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> file) {
          return Image.file(file.requireData, height: height,);
        });
  }
}