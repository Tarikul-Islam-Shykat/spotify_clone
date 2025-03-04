// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/constants/server_constants.dart';
import 'package:spotify_clone/core/failure/failure.dart';
import 'package:spotify_clone/features/home/model/song_model.dart';
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, String>> uploadSong(
      {required File selectedThumbNail,
      required String? x_auth_token,
      required File selectedAudio,
      required String songName,
      required String aritstName,
      required String hexCode}) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('${ServerConstant.serverBaseUrl}song/upload'));
      log('Adding files and fields to request...');

      request
        ..files.addAll([
          await http.MultipartFile.fromPath('song', selectedAudio.path),
          await http.MultipartFile.fromPath(
              'thumbnail', selectedThumbNail.path),
        ])
        ..fields.addAll(
            {'artist': aritstName, 'song_name': songName, 'hex_code': hexCode})
        ..headers.addAll({"x-auth-token": x_auth_token!});
      log('Sending request...');
      final res = await request.send();
      log('Response status code: ${res.statusCode}');

      if (res.statusCode != 201) {
        return Left(AppFailure(await res.stream.bytesToString()));
      }

      return Right(await res.stream.bytesToString());
    } catch (e) {
      log('Exception caught: ${e.toString()}');

      return Left(AppFailure("Home Repo Error : ${e.toString()}"));
    }
  }

  //Future<Either<AppFailure, String>>
  Future<Either<AppFailure, List<SongModel>>> getSongList(String? token) async {
    try {
      final res = await http.get(
        Uri.parse("${ServerConstant.serverBaseUrl}song/listSong"),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token!},
      );

      var responseBody = jsonDecode(res.body);
      if (res.statusCode != 200) {
        responseBody = responseBody as Map<String, dynamic>;
        return Left(AppFailure("Response Error ${responseBody['detail']}"));
      }
      responseBody = responseBody as List;
      List<SongModel> songList = [];
      for (final map in responseBody) {
        songList.add(SongModel.fromMap(map));
      }

      log("songList ${songList.length} ${songList[0].hex_code} $responseBody");

      return Right(songList);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> addSongFav(
      {required String? token, required String songID}) async {
    try {
      final res = await http.post(
          Uri.parse("${ServerConstant.serverBaseUrl}song/favorite"),
          headers: {'Content-Type': 'application/json', 'x-auth-token': token!},
          body: jsonEncode({
            'song_id': songID,
          }));
      var responseBody = jsonDecode(res.body);
      log("addSongFav $responseBody");
      if (res.statusCode != 200) {
        responseBody = responseBody as Map<String, dynamic>;
        return Left(AppFailure("Response Error ${responseBody['detail']}"));
      }

      return Right(responseBody['message']);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, List<SongModel>>> getAllFavSongs(
      {required String token}) async {
    try {
      final res = await http.get(
        Uri.parse("${ServerConstant.serverBaseUrl}song/listSong/favorites"),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      var resbodyMap = jsonDecode(res.body);
      if (res.statusCode != 200) {
        resbodyMap = resbodyMap as Map<String, dynamic>;
        return Left(AppFailure(resbodyMap['detail']));
      }
      log("getAllFavSongs $resbodyMap");

      List<SongModel> songs = [];
      for (final item in resbodyMap) {
        var songMap = item['song']; 
        if (songMap != null) {
          songs.add(SongModel.fromMap(songMap));
        }
      }
      return Right(songs);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
