import 'dart:async';

import 'package:lytt/io_manager.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:rxdart/rxdart.dart';

class DownloadHandler {
  DownloadHandler(this._episode) {
    _createController();
  }

  final Episode _episode;
  final StorageHandler _storageHandler = StorageHandler();
  DownloadState? _state;
  late final StreamController<DownloadState> _controller;

  void _createController() {
    _controller =  BehaviorSubject();
    _checkState();
  }

  void _checkState() async {
    _state = (await _storageHandler.isEpisodeDownloaded(_episode)
        ? DownloadState.downloaded
        : DownloadState.notDownloaded);
    _changeState(_state!);
  }

  void _changeState(DownloadState newState) async {
    _state = newState;
    _controller.add(_state!);
  }

  void download() {
    _changeState(DownloadState.isDownloading);
    _storageHandler.downloadEpisode(_episode).then(
        (value) => _checkState()
    );
  }

  void delete() {
    _storageHandler.removeEpisode(_episode).then(
            (value) => _checkState()
    );
  }

  Stream<DownloadState> getDownloadState() async* {
    yield* _controller.stream;
  }
}

enum DownloadState { notDownloaded, isDownloading, downloaded }
