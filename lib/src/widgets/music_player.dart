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
            var seekData = SeekBarData.zero();
            if (snapshot.hasData) {
              seekData = snapshot.data ?? SeekBarData.zero();
            }

            return SeekBar(
              duration: seekData.duration,
              position: seekData.position,
              onChanged: audioPlayer.seek,
              onChangedEnd: audioPlayer.seek,
            );
          },
        ),
        PlayerButtons(audioPlayer: audioPlayer),
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
            _buildShuffleButton(),
            _buildSeedPreviousButton(),
            _buildPausePlayButton(),
            _buildSeedNextButton(),
            _buildLoopModeButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildShuffleButton() {
    return StreamBuilder(
      stream: audioPlayer.shuffleModeEnabledStream,
      builder: (context, snapshot) {
        var isEnabled = false;

        if (snapshot.hasData) {
          isEnabled = snapshot.data ?? false;
        }

        return ControlButton(
          icon: Icons.shuffle,
          color: isEnabled ? AppColors.primary : Colors.white,
          isEnabled: true,
          onTap: audioPlayer.shuffle,
        );
      },
    );
  }

  Widget _buildSeedPreviousButton() {
    return StreamBuilder(
      stream: audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        return ControlButton(
          icon: Icons.skip_previous_rounded,
          isEnabled: audioPlayer.hasPrevious,
          onTap: audioPlayer.seekToPrevious,
          size: 45,
        );
      },
    );
  }

  Widget _buildPausePlayButton() {
    return StreamBuilder(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        //? default is ready
        var icon = Icons.play_circle_filled_rounded;
        var onTap = audioPlayer.play;

        if (snapshot.hasData) {
          final playerState = snapshot.data as PlayerState;
          final processingState = playerState.processingState;

          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
          } else if (processingState == ProcessingState.ready) {
            if (audioPlayer.playing) {
              icon = Icons.pause_circle_filled_outlined;
              onTap = audioPlayer.pause;
            }
          } else if (processingState == ProcessingState.completed) {
            icon = Icons.replay_outlined;
            onTap = () => audioPlayer.seek(
                  Duration.zero,
                  index: audioPlayer.effectiveIndices?.first ?? 0,
                );
          }
        }
        return AnimatedSwitcher(
          duration: AppSizes.durationFast,
          child: ControlButton(
            key: Key(icon.toString() + DateTime.timestamp().toIso8601String()),
            icon: icon,
            onTap: onTap,
            isEnabled: true,
            size: 60,
          ),
        );
      },
    );
  }

  Widget _buildSeedNextButton() {
    return StreamBuilder(
      stream: audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        return ControlButton(
          icon: Icons.skip_next_rounded,
          isEnabled: audioPlayer.hasNext,
          onTap: audioPlayer.seekToNext,
          size: 45,
        );
      },
    );
  }

  Widget _buildLoopModeButton() {
    return StreamBuilder(
      stream: audioPlayer.loopModeStream,
      builder: (context, snapshot) {
        var mode = LoopMode.off;

        if (snapshot.hasData) {
          mode = snapshot.data as LoopMode;
        }

        final color = mode == LoopMode.off ? Colors.white : AppColors.primary;
        var icon = mode == LoopMode.one ? Icons.repeat_one : Icons.repeat;

        return ControlButton(
          icon: icon,
          color: color,
          isEnabled: true,
          onTap: () {
            if (mode == LoopMode.off) {
              audioPlayer.setLoopMode(LoopMode.one);
            } else if (mode == LoopMode.one) {
              audioPlayer.setLoopMode(LoopMode.all);
            } else {
              audioPlayer.setLoopMode(LoopMode.off);
            }
          },
        );
      },
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
    this.color = Colors.white,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isEnabled;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(size),
      onTap: isEnabled ? onTap : null,
      child: Icon(
        icon,
        size: size,
        color: isEnabled ? color : AppColors.grey.withOpacity(0.5),
      ),
    );
  }
}
