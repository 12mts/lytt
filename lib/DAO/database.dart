
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:lytt/DAO/podcast_dao.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../podcast/podcast.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Podcast, Episode])
abstract class PodcastDatabase extends FloorDatabase {
  PodcastDAO get podcastDao;
}