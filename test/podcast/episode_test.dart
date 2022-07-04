import 'package:flutter_test/flutter_test.dart';
import 'package:lytt/podcast/episode.dart';

void main() {
  final episode1 = Episode(
      "http://traffic.libsyn.com/hellointernet/136FinalFinal.mp3",
      "H.I. #136: Dog Bingo",
      "r77mft");

  final episode2 = Episode(
      "http://traffic.libsyn.com/hellointernet/136FinalFinal.wav?hduisi=rska",
      "H.I. #136: Dog Bingo",
      "r77mft");

  test('Episode ID test', () {
    final s = episode2.id;
    expect(episode1.id, isNot(s));
    episode2.guid =
        "52d66949e4b0a8cec3bcdd46:52d67282e4b0cca8969714fa:5e58de8a37459e0d069efda0";

    expect(s, isNot(episode2.id));
  });

  test('Episode filename test', () {
    expect(episode1.filename, "${episode1.id}.mp3");
    expect(episode2.filename, "${episode2.id}.wav");
  });
}
