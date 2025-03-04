import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/home/model/song_model.dart';

part 'home_local_repo.g.dart';

@riverpod
HomeLocalRepo homeLocalRepo(HomeLocalRepoRef ref) {
  return HomeLocalRepo();
}

class HomeLocalRepo {
  late final Box box;

  HomeLocalRepo() {
    if (!Hive.isBoxOpen("localSongBox")) {
      throw HiveError(
          'localSongBox is not open. Make sure to open it before using HomeLocalRepo.');
    }
    box = Hive.box("localSongBox");
  }

  void uploadSong(SongModel song) {
    box.put(song.id, song.toJson());
  }

  List<SongModel> fetchSongFromLocal() {
    List<SongModel> song = [];
    for (final key in box.keys) {
      song.add(SongModel.fromJson(box.get(key)));
    }
    return song;
  }
}
