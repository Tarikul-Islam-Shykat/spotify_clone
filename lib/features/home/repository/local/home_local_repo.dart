import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/home/model/song_model.dart';

part 'home_local_repo.g.dart';

@riverpod
HomeLocalRepo homeLocalRepo(HomeLocalRepoRef ref) {
  return HomeLocalRepo();
}

class HomeLocalRepo {
  final Box homeLocalBox = Hive.box("localSongBox");

  void uploadSong(SongModel song) {
    homeLocalBox.put(song.id, song.toJson());
  }

  List<SongModel> fetchSongFromLocal() {
    List<SongModel> song = [];
    for (final key in homeLocalBox.keys) {
      song.add(SongModel.fromJson(homeLocalBox.get(key)));
    }
    return song;
  }
}
