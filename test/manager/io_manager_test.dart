import 'package:flutter_test/flutter_test.dart';
import 'package:lytt/manager/io_manager.dart';
import 'package:webfeed/domain/rss_feed.dart';

import '../io_thing.dart';

void main() {
  group('WebHandler', () {
    final webHandler = WebHandler();

    test('getAsString', () async {
      var text = await webHandler.getAsString(
          "https://no.wikipedia.org/w/index.php?title=%C3%85&oldid=411671");
      var expected = await getFileAsString("wiki.txt");
      text = text.replaceAll(RegExp(' '), ' ');
      expected = expected.replaceAll(RegExp('\\r\\n'), '\n');
      expect(text, expected);
    });

    test('aftenblabla ÆØÅ', () async {
      var text = await webHandler.getAsString(
          "https://podcast.stream.schibsted.media/sa/100153");
      expect(text.contains(RegExp("ø")), true);
    });
  });

  test('rssTing', () async {
    final name =
        RssFeed.parse(await getFileAsString("helloInternet_new")).description;
    expect(name, "ÆØÅ");
  });
}
