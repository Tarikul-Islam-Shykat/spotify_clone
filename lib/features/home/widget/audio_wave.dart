import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify_clone/core/colors/app_pallete.dart';

class AudioWave extends StatefulWidget {
  final String path;
  const AudioWave({super.key, required this.path});

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  void initAudioPlayer() async {
    await playerController.preparePlayer(path: widget.path);
  }

  Future<void> playAndPause() async {
    if (!playerController.playerState.isPlaying) {
      await playerController.startPlayer();
    } else if (!playerController.playerState.isPaused) {
      await playerController.pausePlayer();
    }
    // for updating the state
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    playerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: playAndPause,
            icon: Icon(playerController.playerState.isPlaying
                ? Icons.pause
                : Icons.play_arrow)),
        Expanded(
          child: AudioFileWaveforms(
            size: const Size(double.infinity, 100),
            playerController: playerController,
            playerWaveStyle: const PlayerWaveStyle(
                fixedWaveColor: AppPallete.borderColor,
                liveWaveColor: AppPallete.gradient2,
                spacing: 6,
                showSeekLine: false),
          ),
        ),
      ],
    );
  }
}
