import 'package:flutter_test/flutter_test.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:webfeed/domain/rss_feed.dart';

import '../io_thing.dart';

void main() {
  late Podcast podcast;

  group('finished', () {
    setUp(() async {
      podcast = Podcast.fromFeed(
          "", RssFeed.parse(await getFileAsString("helloInternet")));
    });

    test('Get id', () {
      expect(podcast.id, "1");
    });
  });

  /*
  test('Update', () async {
    var feed = RssFeed.parse(await getFileAsString("helloInternet_pri"));
    podcast = Podcast.fromFeed("url", feed);
    expect(await podcast.updatePodcast(feed), false);
    expect(podcast.rssUrl, "url");
    feed = RssFeed.parse(await getFileAsString("helloInternet"));
    expect(await podcast.updatePodcast(feed), true);
    expect(podcast.rssUrl, "url");
    feed = RssFeed.parse(await getFileAsString("helloInternet_new"));
    expect(await podcast.updatePodcast(feed), true);
    expect(podcast.rssUrl, "newUrl");
  });

  test('Web update', () async {
    final web = WebHandler();
    var feed = RssFeed.parse(await web
        .getAsString("http://www.hellointernet.fm/podcast?format=rss"));
    podcast = Podcast.fromFeed("rssUrl", feed);
    feed = RssFeed.parse(await web
        .getAsString("http://www.hellointernet.fm/podcast?format=rss"));
    expect(await podcast.updatePodcast(feed), false);
  });

  test("rss file ÆØÅ", () async {
    podcast = Podcast.fromFeed(
        "rssUrl", RssFeed.parse(await getFileAsString("100153.xml")));
    expect(
        podcast.description
            ?.replaceAll(RegExp('\r\n'), '')
            .replaceAll(RegExp(' '), ''),
        "Ukesaktuelt nyhetsmagasin med lause snipp. Programledere er Aftenbladets journalister Jan Zahl og Leif Tore Lindø, som har med seg kommentator Harald Birkevold og forfatter og professor Janne Stigen Drangsholt. Publiseres hver onsdag. Følg Aftenbla-bla på Instagram: instagram.com/aftenblabla"
            .replaceAll(RegExp(' '), ''));
  });

   */
}
