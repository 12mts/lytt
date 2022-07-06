
import 'package:floor/floor.dart';

@Entity()
class Playlist {
  @primaryKey
  late final String id;

  final String name;
  late int counter;

  Playlist(this.id, this.name, this.counter);

  Playlist.name(this.name) {
    id = name.hashCode.toRadixString(32);
    counter = 0;
  }
  int getNextRank() {
    return counter++;
  }
}
