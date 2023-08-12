import 'package:just_audio/just_audio.dart';

import '../core/utils/common_libs.dart';
import 'seek_bar.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({
    super.key,
    required Stream<SeekBarData> seekBarData,
    required this.audioPlayer,
  }) : _seekBarData = seekBarData;

  final Stream<SeekBarData> _seekBarData;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: _seekBarData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final seekData = snapshot.data ?? SeekBarData.zero();
              return SeekBar(
                duration: seekData.duration,
                position: seekData.position,
                onChanged: audioPlayer.seek,
                onChangedEnd: audioPlayer.seek,
              );
            }

            return SeekBar(
              duration: Duration.zero,
              position: Duration.zero,
              onChanged: audioPlayer.seek,
              onChangedEnd: audioPlayer.seek,
            );
          },
        ),
        StreamBuilder(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data as PlayerState;
              final processingState = playerState.processingState;

              // if (processingState == ProcessingState.loading ||
              //     processingState == ProcessingState.buffering) {
              //   return const CircularProgressIndicator();
              // }
            }
            return PlayerButtons(audioPlayer: audioPlayer);
          },
        )
      ],
    );
  }
}

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ControlButton(
              icon: Icons.shuffle,
              isEnabled: true,
              onTap: () {},
            ),
            ControlButton(
              icon: Icons.skip_previous_rounded,
              isEnabled: audioPlayer.hasPrevious,
              onTap: audioPlayer.seekToPrevious,
              size: 45,
            ),
            ControlButton(
              icon: audioPlayer.playing
                  ? Icons.pause_circle_filled_outlined
                  : Icons.play_circle_filled_rounded,
              onTap: audioPlayer.playing ? audioPlayer.pause : audioPlayer.play,
              isEnabled: true,
              size: 60,
            ),
            ControlButton(
              icon: Icons.skip_next_rounded,
              isEnabled: audioPlayer.hasNext,
              onTap: audioPlayer.seekToNext,
              size: 45,
            ),
            ControlButton(
              icon: Icons.repeat,
              isEnabled: true,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class ControlButton extends StatelessWidget {
  const ControlButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isEnabled,
    this.size = 25,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isEnabled;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(size),
      onTap: isEnabled ? onTap : null,
      child: Icon(
        icon,
        size: size,
        color: isEnabled ? Colors.white : AppColors.grey,
      ),
    );
  }
}
