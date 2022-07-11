// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorPodcastDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PodcastDatabaseBuilder databaseBuilder(String name) =>
      _$PodcastDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PodcastDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$PodcastDatabaseBuilder(null);
}

class _$PodcastDatabaseBuilder {
  _$PodcastDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$PodcastDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$PodcastDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<PodcastDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$PodcastDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$PodcastDatabase extends PodcastDatabase {
  _$PodcastDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PodcastDAO? _podcastDaoInstance;

  PlaylistDAO? _playlistDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Podcast` (`id` TEXT NOT NULL, `rssUrl` TEXT NOT NULL, `title` TEXT NOT NULL, `link` TEXT NOT NULL, `image` TEXT NOT NULL, `description` TEXT, `owner` TEXT, `ownerEmail` TEXT, `author` TEXT, `lastBuildDate` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Episode` (`id` TEXT NOT NULL, `url` TEXT NOT NULL, `title` TEXT NOT NULL, `podcastId` TEXT NOT NULL, `description` TEXT, `explicit` INTEGER, `guid` TEXT, `durationString` TEXT, `pubDateString` TEXT, FOREIGN KEY (`podcastId`) REFERENCES `Podcast` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Playlist` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, `counter` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PlaylistEntry` (`playlistId` TEXT NOT NULL, `episodeId` TEXT NOT NULL, `rank` INTEGER NOT NULL, FOREIGN KEY (`playlistId`) REFERENCES `Playlist` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`episodeId`) REFERENCES `Episode` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`episodeId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PodcastDAO get podcastDao {
    return _podcastDaoInstance ??= _$PodcastDAO(database, changeListener);
  }

  @override
  PlaylistDAO get playlistDao {
    return _playlistDaoInstance ??= _$PlaylistDAO(database, changeListener);
  }
}

class _$PodcastDAO extends PodcastDAO {
  _$PodcastDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _podcastInsertionAdapter = InsertionAdapter(
            database,
            'Podcast',
            (Podcast item) => <String, Object?>{
                  'id': item.id,
                  'rssUrl': item.rssUrl,
                  'title': item.title,
                  'link': item.link,
                  'image': item.image,
                  'description': item.description,
                  'owner': item.owner,
                  'ownerEmail': item.ownerEmail,
                  'author': item.author,
                  'lastBuildDate': item.lastBuildDate
                },
            changeListener),
        _episodeInsertionAdapter = InsertionAdapter(
            database,
            'Episode',
            (Episode item) => <String, Object?>{
                  'id': item.id,
                  'url': item.url,
                  'title': item.title,
                  'podcastId': item.podcastId,
                  'description': item.description,
                  'explicit':
                      item.explicit == null ? null : (item.explicit! ? 1 : 0),
                  'guid': item.guid,
                  'durationString': item.durationString,
                  'pubDateString': item.pubDateString
                },
            changeListener),
        _podcastUpdateAdapter = UpdateAdapter(
            database,
            'Podcast',
            ['id'],
            (Podcast item) => <String, Object?>{
                  'id': item.id,
                  'rssUrl': item.rssUrl,
                  'title': item.title,
                  'link': item.link,
                  'image': item.image,
                  'description': item.description,
                  'owner': item.owner,
                  'ownerEmail': item.ownerEmail,
                  'author': item.author,
                  'lastBuildDate': item.lastBuildDate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Podcast> _podcastInsertionAdapter;

  final InsertionAdapter<Episode> _episodeInsertionAdapter;

  final UpdateAdapter<Podcast> _podcastUpdateAdapter;

  @override
  Stream<List<Podcast>> getPodcastList() {
    return _queryAdapter.queryListStream('SELECT * FROM Podcast',
        mapper: (Map<String, Object?> row) => Podcast(
            id: row['id'] as String,
            title: row['title'] as String,
            link: row['link'] as String,
            image: row['image'] as String,
            rssUrl: row['rssUrl'] as String,
            description: row['description'] as String?,
            owner: row['owner'] as String?,
            author: row['author'] as String?,
            lastBuildDate: row['lastBuildDate'] as String?),
        queryableName: 'Podcast',
        isView: false);
  }

  @override
  Stream<List<Episode>> getEpisodes(String podcastId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Episode WHERE podcastId = ?1',
        mapper: (Map<String, Object?> row) => Episode(
            row['url'] as String,
            row['title'] as String,
            row['podcastId'] as String,
            row['id'] as String,
            row['description'] as String?,
            row['explicit'] == null ? null : (row['explicit'] as int) != 0,
            row['guid'] as String?,
            row['durationString'] as String?,
            row['pubDateString'] as String?),
        arguments: [podcastId],
        queryableName: 'Episode',
        isView: false);
  }

  @override
  Future<Episode?> getEpisode(String id) async {
    return _queryAdapter.query('SELECT * FROM Episode WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Episode(
            row['url'] as String,
            row['title'] as String,
            row['podcastId'] as String,
            row['id'] as String,
            row['description'] as String?,
            row['explicit'] == null ? null : (row['explicit'] as int) != 0,
            row['guid'] as String?,
            row['durationString'] as String?,
            row['pubDateString'] as String?),
        arguments: [id]);
  }

  @override
  Future<Episode?> getRandomEpisode() async {
    return _queryAdapter.query(
        'SELECT * FROM Episode ORDER BY RANDOM() LIMIT 1',
        mapper: (Map<String, Object?> row) => Episode(
            row['url'] as String,
            row['title'] as String,
            row['podcastId'] as String,
            row['id'] as String,
            row['description'] as String?,
            row['explicit'] == null ? null : (row['explicit'] as int) != 0,
            row['guid'] as String?,
            row['durationString'] as String?,
            row['pubDateString'] as String?));
  }

  @override
  Future<void> addPodcast(Podcast podcast) async {
    await _podcastInsertionAdapter.insert(podcast, OnConflictStrategy.abort);
  }

  @override
  Future<void> addEpisode(Episode episode) async {
    await _episodeInsertionAdapter.insert(episode, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePodcast(Podcast podcast) async {
    await _podcastUpdateAdapter.update(podcast, OnConflictStrategy.abort);
  }
}

class _$PlaylistDAO extends PlaylistDAO {
  _$PlaylistDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _playlistEntryInsertionAdapter = InsertionAdapter(
            database,
            'PlaylistEntry',
            (PlaylistEntry item) => <String, Object?>{
                  'playlistId': item.playlistId,
                  'episodeId': item.episodeId,
                  'rank': item.rank
                }),
        _playlistInsertionAdapter = InsertionAdapter(
            database,
            'Playlist',
            (Playlist item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'counter': item.counter
                },
            changeListener),
        _playlistUpdateAdapter = UpdateAdapter(
            database,
            'Playlist',
            ['id'],
            (Playlist item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'counter': item.counter
                },
            changeListener),
        _playlistEntryDeletionAdapter = DeletionAdapter(
            database,
            'PlaylistEntry',
            ['episodeId'],
            (PlaylistEntry item) => <String, Object?>{
                  'playlistId': item.playlistId,
                  'episodeId': item.episodeId,
                  'rank': item.rank
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlaylistEntry> _playlistEntryInsertionAdapter;

  final InsertionAdapter<Playlist> _playlistInsertionAdapter;

  final UpdateAdapter<Playlist> _playlistUpdateAdapter;

  final DeletionAdapter<PlaylistEntry> _playlistEntryDeletionAdapter;

  @override
  Stream<List<Episode>> getPlaylistStream(String playlistId) {
    return _queryAdapter.queryListStream(
        'SELECT e.* FROM PlaylistEntry AS l INNER JOIN Episode AS e ON l.episodeId=e.id WHERE l.playlistId = ?1',
        mapper: (Map<String, Object?> row) => Episode(
            row['url'] as String,
            row['title'] as String,
            row['podcastId'] as String,
            row['id'] as String,
            row['description'] as String?,
            row['explicit'] == null ? null : (row['explicit'] as int) != 0,
            row['guid'] as String?,
            row['durationString'] as String?,
            row['pubDateString'] as String?),
        arguments: [playlistId],
        queryableName: 'Episode',
        isView: false);
  }

  @override
  Future<List<Episode>> getPlaylistFuture(String playlistId) async {
    return _queryAdapter.queryList(
        'SELECT e.* FROM PlaylistEntry AS l INNER JOIN Episode AS e ON l.episodeId=e.id WHERE l.playlistId = ?1',
        mapper: (Map<String, Object?> row) => Episode(row['url'] as String, row['title'] as String, row['podcastId'] as String, row['id'] as String, row['description'] as String?, row['explicit'] == null ? null : (row['explicit'] as int) != 0, row['guid'] as String?, row['durationString'] as String?, row['pubDateString'] as String?),
        arguments: [playlistId]);
  }

  @override
  Stream<List<Playlist>> getPlaylistList() {
    return _queryAdapter.queryListStream('SELECT * FROM playlist',
        mapper: (Map<String, Object?> row) => Playlist(
            row['id'] as String, row['name'] as String, row['counter'] as int),
        queryableName: 'Playlist',
        isView: false);
  }

  @override
  Future<PlaylistEntry?> getPlaylistEntry(
      String playlistId, String episodeId) async {
    return _queryAdapter.query(
        'SELECT * FROM playlistEntry WHERE playlistId = ?1 AND episodeId = ?2',
        mapper: (Map<String, Object?> row) => PlaylistEntry(
            row['playlistId'] as String,
            row['episodeId'] as String,
            row['rank'] as int),
        arguments: [playlistId, episodeId]);
  }

  @override
  Future<void> addPlaylistEntry(PlaylistEntry playlistEntry) async {
    await _playlistEntryInsertionAdapter.insert(
        playlistEntry, OnConflictStrategy.abort);
  }

  @override
  Future<void> addPlaylist(Playlist playlist) async {
    await _playlistInsertionAdapter.insert(playlist, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePlaylist(Playlist playlist) async {
    await _playlistUpdateAdapter.update(playlist, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEpisode(PlaylistEntry playlistEntry) async {
    await _playlistEntryDeletionAdapter.delete(playlistEntry);
  }
}
