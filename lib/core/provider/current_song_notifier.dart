// ignore_for_file: avoid_public_notifier_properties
import 'package:just_audio_background/just_audio_background.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/home/model/song_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/features/home/repository/local/home_local_repo.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? audioPlayer;
  late HomeLocalRepo _homeLocalRepo;
  bool isPlaying = false;
  SongModel? build() {
    _homeLocalRepo = ref.watch(homeLocalRepoProvider);
    return null;
  }

  void updateSong(SongModel currentSong) async {
    await audioPlayer?.stop();
    audioPlayer = AudioPlayer();
    final audioSource = AudioSource.uri(Uri.parse(currentSong.song_url),
        tag: MediaItem(
            id: currentSong.id,
            title:
                currentSong.song_name == "" ? "Unknown" : currentSong.song_name,
            artist: currentSong.artist == ""
                ? "Unknown Artist"
                : currentSong.artist,
            artUri: Uri.parse(currentSong.thumbnail_url)));
    await audioPlayer!.setAudioSource(audioSource);

    audioPlayer!.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
        isPlaying = false;
        state = state?.copyWith(hex_code: state?.hex_code);
      }
    });

    // ! uploading the current song in locally.
    _homeLocalRepo.uploadSong(currentSong);

    audioPlayer!.play();
    isPlaying = true;
    state = currentSong;
  }

  void playPauseSong() {
    if (isPlaying == true) {
      audioPlayer!.pause();
    } else {
      audioPlayer!.play();
    }

    isPlaying = !isPlaying;
    // just to trigger the new state.
    state = state?.copyWith(hex_code: state?.hex_code);
  }

  void seek(double value) {
    audioPlayer!.seek(Duration(
        milliseconds: (value * audioPlayer!.duration!.inMilliseconds).toInt()));
  }
}
