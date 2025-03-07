import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/provider/current_song_notifier.dart';
import 'package:spotify_clone/core/widgets/loader.dart';
import 'package:spotify_clone/features/home/repository/local/home_local_repo.dart';
import 'package:spotify_clone/features/home/viewmodel/home_vierwmodel.dart';

class SongPage extends ConsumerStatefulWidget {
  const SongPage({super.key});

  @override
  ConsumerState<SongPage> createState() => _SongPageState();
}

class _SongPageState extends ConsumerState<SongPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var recentPlayedSongList =
        ref.read(homeViewModelProvider.notifier).getRecentlyPlayedSongs();

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.30,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                itemCount: recentPlayedSongList.length,
                itemBuilder: (context, index) {
                  var songs = recentPlayedSongList[index];

                  return Row(
                    children: [
                      Text("${songs.artist} === "),
                      ],
                  );
                }),
          ),
          Text(
            "Latest Today ",
            style: TextStyle(fontSize: height * 0.04),
          ),
          ref.watch(getAllSongProvider).when(
              data: (songList) {
                //return Text(songList[0].song_name);
                return SizedBox(
                  height: height * 0.4,
                  width: width * 0.35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: songList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(currentSongNotifierProvider.notifier)
                                .updateSong(songList[index]);
                            // ref
                            //     .read(currentSongNotifierProvider.notifier)
                            //     .playPauseSong();
                          },
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.35, // Set a width
                                height: height * 0.15, // Set a height
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            songList[index].thumbnail_url))),
                              ),
                              SizedBox(
                                // width: width * 0.25,
                                child: Text(
                                  songList[index].song_name.isEmpty
                                      ? "Unknown Song"
                                      : songList[index].song_name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              SizedBox(
                                // width: width * 0.25,
                                child: Text(
                                  songList[index].artist.isEmpty
                                      ? "Unknown"
                                      : songList[index].artist,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                );
              },
              error: ((error, stackTrace) {
                return const Center(
                  child: Text("Error Occured While Retrieving the data"),
                );
              }),
              loading: () => const Loader())
        ],
      ),
    ));
  }
}
