import 'package:flutter_test/flutter_test.dart';
import 'package:lytt/manager/io_manager.dart';

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
  });
}
