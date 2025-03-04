import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/colors/app_pallete.dart';
import 'package:spotify_clone/core/provider/current_song_notifier.dart';
import 'package:spotify_clone/features/home/view/upload_song_page.dart';
import 'package:spotify_clone/features/home/viewmodel/home_vierwmodel.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllFavSongProvider).when(
        data: (data) {
          return ListView.builder(
              itemCount: data.length + 1,
              itemBuilder: (context, index) {
                if (index == data.length) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UploadSongPage()));
                    },
                    child: const ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundColor: AppPallete.backgroundColor,
                        child: Icon(Icons.add),
                      ),
                      title: Text("Upload New Song"),
                    ),
                  );
                }
                final songData = data[index];
                log("LibraryPage ${songData.thumbnail_url}");
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(currentSongNotifierProvider.notifier)
                        .updateSong(songData);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundColor: AppPallete.backgroundColor,
                      backgroundImage: NetworkImage(songData.thumbnail_url),
                    ),
                    title: Text(songData.song_name == ""
                        ? "Unknown"
                        : songData.song_name),
                    subtitle: Text(
                        songData.artist == "" ? "Unknown" : songData.artist),
                  ),
                );
              });
        },
        error: ((error, stackTrace) => Center(
              child: Text("eRRO : ${error.toString()}"),
            )),
        loading: () => const CircularProgressIndicator());
  }
}
