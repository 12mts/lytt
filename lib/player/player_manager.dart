import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'player.dart';
import 'playing_item.dart';
import '../podcast/episode.dart';
import '../manager/io_manager.dart';

class PlayerManager {
  PlayingItem _playingItem = PlayingNull();
  late final Player _player = Player(nextItem);
  final _storage = StorageHandler(); //Read only!
  final episodeStream = BehaviorSubject<Episode?>();

  PlayerManager() {
    episodeStream.add(null);
  }


  void playItem(PlayingItem playingItem) {
    _playingItem = playingItem;
    _setEpisode();
  }

  bool startStop() {
    return _player.startStop();
  }

  Stream<PlayerDurationState> playerState() {
    return _player.playerState();
  }

  void setTime(Duration duration) {
    _player.setTime(duration);
  }

  void _setEpisode() async {
    final episode = _playingItem.getCurrentEpisode();
    episodeStream.add(await episode);
    _player.setEpisode(_storage
        .episodeUri(episode));
  }

  Future<void> nextItem() async {
    await _playingItem.getGetNext();
    _setEpisode();
  }
}
