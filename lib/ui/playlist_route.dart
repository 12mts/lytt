import 'package:flutter/material.dart';
import 'package:lytt/player/playing_item.dart';
import 'package:lytt/podcast/episode.dart';

import '../manager/controller.dart';
import '../podcast/playlist.dart';

class PlaylistListWidget extends StatelessWidget {
  final Controller controller;

  const PlaylistListWidget(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test"),
          actions: [
            IconButton(
                onPressed: () => _createPlaylistPopup(context),
                icon: const Icon(Icons.add))
          ],
        ),
        body: StreamBuilder(
            stream: controller.getPlaylists(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Playlist>> playlists) {
              if (playlists.hasData) {
                return ListView(
                  children: playlistWidgetList(playlists.data!, context),
                );
              }
              return ListView();
            }));
  }

  List<Widget> playlistWidgetList(
      List<Playlist> playlists, BuildContext context) {
    List<Widget> list = [];
    for (Playlist playlist in playlists) {
      list.add(ListTile(
        trailing: IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {
            controller.player.playItem(PlayingPlaylist(playlist, controller.playlistManager));
          },
        ),
        title: Text(playlist.name),
        onTap: () {
          selectPlaylist(playlist, context);
        },
      ));
    }
    return list;
  }

  Future<void> _createPlaylistPopup(context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("New playlist"),
            content: TextField(
              onSubmitted: (text) => controller.addPlaylist(text),
            ),
          );
        });
  }

  void selectPlaylist(Playlist playlist, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlaylistViewWidget(controller, playlist)));
  }
}


class PlaylistViewWidget extends StatelessWidget {
  final Controller controller;
  final Playlist playlist;

  PlaylistViewWidget(this.controller, this.playlist)
      : super(key: ObjectKey(playlist));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(playlist.name),
          actions: [
            IconButton(
                onPressed: () => controller.addRandom(playlist),
                icon: const Icon(Icons.add))
          ],
        ),
        body: StreamBuilder(
            stream: controller.getPlaylistEpisodes(playlist),
            builder:
                (BuildContext context, AsyncSnapshot<List<Episode>> playlists) {
              if (playlists.hasData) {
                return ListView(
                  children: episodeList(playlists.requireData),
                );
              }
              return ListView();
            }));
  }

  List<Widget> episodeList(List<Episode> playlists) {
    List<Widget> list = [];
    for (Episode episode in playlists) {
      list.add(ListTile(
        title: Text(episode.title),
      ));
    }
    return list;
  }
}
