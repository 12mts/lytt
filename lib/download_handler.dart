import 'dart:async';

import 'package:lytt/io_manager.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:rxdart/rxdart.dart';

class DownloadHandler {
  DownloadHandler(this.episode) {
    _createController();
  }

  final Episode episode;
  final StorageHandler storageHandler = StorageHandler();
  DownloadState? state;
  late final StreamController<DownloadState> controller;

  void _createController() {
    controller =  BehaviorSubject();
    _checkState();
  }

  void _checkState() async {
    state = (await storageHandler.isEpisodeDownloaded(episode)
        ? DownloadState.downloaded
        : DownloadState.notDownloaded);
    _changeState(state!);
  }

  void _changeState(DownloadState newState) async {
    state = newState;
    controller.add(state!);
  }

  void download() {
    _changeState(DownloadState.isDownloading);
    storageHandler.downloadEpisode(episode).then(
        (value) => _checkState()
    );
  }

  void delete() {
    storageHandler.removeEpisode(episode).then(
            (value) => _checkState()
    );
  }

  Stream<DownloadState> getDownloadState() async* {
    yield* controller.stream;
  }
}

enum DownloadState { notDownloaded, isDownloading, downloaded }
