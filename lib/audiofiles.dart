
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class AudioFile {
  String url;
  String path = "";

  AudioFile(this.url) {
    downloadFile(url).then((value){
        path = value;
    });
    print(path);
  }

  Future<String> downloadFile(String url) async {
    final path = await getApplicationDocumentsDirectory();
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: '$path/thing.mp3',
      showNotification: false, // show download progress in status bar (for Android)
      openFileFromNotification: false, // click on notification to open downloaded file (for Android)
    );
    return '$path/thing.mp3';
  }
}