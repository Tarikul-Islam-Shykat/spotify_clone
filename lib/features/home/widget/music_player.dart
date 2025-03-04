import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/colors/app_pallete.dart';
import 'package:spotify_clone/core/provider/current_song_notifier.dart';
import 'package:spotify_clone/features/home/viewmodel/home_vierwmodel.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueGrey, Colors.white30])),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_downward_rounded)),
          backgroundColor: AppPallete.transparentColor,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: 'music_image',
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            currentSong!.thumbnail_url,
                          ),
                        )),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            currentSong.song_name != ''
                                ? currentSong.song_name.toString()
                                : "Unknown",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            currentSong.artist != ''
                                ? currentSong.artist.toString()
                                : "Unknown Artist",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                          onPressed: () async {
                            await ref
                              .read(homeViewModelProvider.notifier)
                              .makeSongFav(songID: currentSong.id);
                          },
                          icon: const Icon(CupertinoIcons.heart))
                    ],
                  ),
                  Column(
                    children: [
                      StreamBuilder(
                          stream: songNotifier.audioPlayer!.positionStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox();
                            }
                            final currentPostion = snapshot.data;
                            final totalDuration =
                                songNotifier.audioPlayer!.duration;
                            // ! slider value will be between 0 and 1.
                            double sliderValue = 0.0;
                            if (currentPostion != null &&
                                totalDuration != null) {
                              sliderValue = currentPostion.inMilliseconds /
                                  totalDuration.inMilliseconds;
                            }

                            return Column(
                              children: [
                                SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: AppPallete.whiteColor,
                                        inactiveTrackColor:
                                            AppPallete.greyColor,
                                        thumbColor: AppPallete.whiteColor,
                                        overlayShape:
                                            SliderComponentShape.noOverlay,
                                        trackHeight: 4),
                                    child: Slider(
                                      value: sliderValue,
                                      min: 0,
                                      max: 1,
                                      onChanged: (val) {
                                        sliderValue = val;
                                      },
                                      onChangeEnd: (value) {
                                        songNotifier.seek(value);
                                      },
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${currentPostion!.inMinutes} : ${currentPostion!.inSeconds}",
                                      style: const TextStyle(
                                          color: AppPallete.greyColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "${totalDuration!.inMinutes} : ${totalDuration!.inSeconds}",
                                      style: const TextStyle(
                                          color: AppPallete.greyColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.shuffle),
                            color: AppPallete.whiteColor,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.skip_previous,
                              size: MediaQuery.of(context).size.height * 0.04,
                            ),
                            color: AppPallete.whiteColor,
                          ),
                          IconButton(
                            onPressed: () {
                              songNotifier.playPauseSong();
                            },
                            icon: Icon(
                              songNotifier.isPlaying != true
                                  ? Icons.play_arrow
                                  : Icons.pause,
                              size: MediaQuery.of(context).size.height * 0.06,
                            ),
                            color: AppPallete.whiteColor,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.skip_next,
                              size: MediaQuery.of(context).size.height * 0.04,
                            ),
                            color: AppPallete.whiteColor,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.loop_outlined),
                            color: AppPallete.whiteColor,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share,
                              size: MediaQuery.of(context).size.height * 0.02,
                            ),
                            color: AppPallete.whiteColor,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.featured_play_list,
                              size: MediaQuery.of(context).size.height * 0.02,
                            ),
                            color: AppPallete.whiteColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
