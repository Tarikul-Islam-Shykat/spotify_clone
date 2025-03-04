import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/core/colors/app_pallete.dart';
import 'package:spotify_clone/core/provider/current_song_notifier.dart';
import 'package:spotify_clone/core/widgets/utils.dart';
import 'package:spotify_clone/features/home/viewmodel/home_vierwmodel.dart';
import 'package:spotify_clone/features/home/widget/music_player.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);

    if (currentSong == null) {
      return const SizedBox.shrink(); // meaning nothing is playing currently
    }

    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return const MusicPlayer();
        // }));

        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration:
                const Duration(milliseconds: 300), // Animation speed
            pageBuilder: (context, animation, secondaryAnimation) {
              return const MusicPlayer();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final tween = Tween(begin: const Offset(1, 0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeIn));

              final offsetAnimationn = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimationn,
                child: child,
              );
            },
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(color: hexToColor(currentSong.hex_code)),
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: 'music_image',
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                  currentSong.thumbnail_url,
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Song Name ${currentSong.song_name}"),
                        Text(
                          "Artist Name ${currentSong.artist}",
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          await ref
                              .read(homeViewModelProvider.notifier)
                              .makeSongFav(songID: currentSong.id);
                        },
                        icon: const Icon(
                          CupertinoIcons.heart,
                          color: AppPallete.whiteColor,
                        )),
                    IconButton(
                        onPressed: () {
                          songNotifier.playPauseSong();
                        },
                        icon: Icon(
                          songNotifier.isPlaying == true
                              ? CupertinoIcons.pause
                              : CupertinoIcons.play_fill,
                          color: AppPallete.whiteColor,
                        ))
                  ],
                )
              ],
            ),
          ),
          // MUSIC LINE

          Positioned(
              left: 8,
              bottom: 0,
              child: Container(
                height: 3,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppPallete.inActiveColor,
                ),
              )),
          StreamBuilder(
              stream: songNotifier.audioPlayer?.positionStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                }

                var position = snapshot.data;
                final totalDuration = songNotifier.audioPlayer!.duration;
                double sliderValue = 0.0;
                if (position != null && totalDuration != null) {
                  sliderValue =
                      position.inMilliseconds / totalDuration.inMilliseconds;
                }

                return Positioned(
                    left: 8,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppPallete.activeColor,
                      ),
                      width: sliderValue *
                          (MediaQuery.of(context).size.width - 32),
                      height: 2,
                    ));
              }),
        ],
      ),
    );
  }
}
