import 'dart:io';

import 'package:flutter/material.dart';

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
          return AspectRatio(
              aspectRatio: 1,
              child: Container(
                  height: height,
                  color: Colors.black12,
                  child: const FittedBox(
                    fit: BoxFit.fitWidth,
                    child:
                        Text(" ʕ•ᴥ•ʔ ", style: TextStyle(color: Colors.blueGrey)),
                  )));
        });
  }
}
