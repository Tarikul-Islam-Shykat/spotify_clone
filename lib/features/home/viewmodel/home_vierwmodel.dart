import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/fpdart.dart%20';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/provider/current_user_notifier.dart';
import 'package:spotify_clone/core/widgets/utils.dart';
import 'package:spotify_clone/features/home/model/song_model.dart';
import 'package:spotify_clone/features/home/repository/home_repository.dart';
import 'package:spotify_clone/features/home/repository/local/home_local_repo.dart';
part 'home_vierwmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSong(GetAllSongRef ref) async {
  var token = ref.watch(currentUserNotifierProvider)!.token;
  final res = await ref.watch(homeRepositoryProvider).getSongList(token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  late HomeLocalRepo _homeLocalRepo;

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _homeLocalRepo = ref.watch(homeLocalRepoProvider);
    return null;
  }

  Future<void> uploadSong(
      {required File selectedThumbNail,
      required File selectedAudio,
      required String songName,
      required String artistName,
      required Color selectedColor}) async {
    state = const AsyncValue.loading();
    log('Starting upload...'); // Debug print
    log('Audio path: ${selectedAudio.path}');
    log('Thumbnail path: ${selectedThumbNail.path}');
    final res = await _homeRepository.uploadSong(
        selectedThumbNail: selectedThumbNail,
        x_auth_token: ref.read(currentUserNotifierProvider)!.token,
        selectedAudio: selectedAudio,
        songName: songName,
        aritstName: artistName,
        hexCode: rgbToHex(selectedColor));

    final val = switch (res) {
      Left(value: final l) => AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => AsyncValue.data(r),
    };

    state = val;
  }

  getSong() async {
    final res = _homeRepository
        .getSongList(ref.read(currentUserNotifierProvider)!.token);
  }

  List<SongModel> getRecentlyPlayedSongs() {
    return _homeLocalRepo.fetchSongFromLocal();
  }
}
