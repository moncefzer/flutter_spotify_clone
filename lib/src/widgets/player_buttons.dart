import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'package:spotify_clone/src/data/repositories/song_repository.dart';

import '../controllers/music_payer_bloc/music_player_bloc.dart';
import '../core/utils/common_libs.dart';
import '../data/models/music_player_data.dart';
import '../data/models/song.dart';

class PlayerButtons extends StatefulWidget {
  const PlayerButtons({
    Key? key,
    required this.musicPlayerState,
  }) : super(key: key);

  final MusicPlayerState musicPlayerState;

  @override
  State<PlayerButtons> createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<PlayerButtons> {
  final AudioPlayer audioPlayer = AudioPlayer();

  late final MusicPlayerBloc bloc;

  @override
  void initState() {
    super.initState();

    Future.microtask(() => bloc = MusicPlayerBloc.get(context));
  }

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

  int count = 1;
  Widget _buildPausePlayButton() {
    //? default is ready
    var icon = Icons.play_circle_filled_rounded;
    var onTap = () => bloc.add(MusicPlayerPlay());

    final playerState = widget.musicPlayerState.musicPlayerData?.playbackState;

    if (playerState?.playing ?? false) {
      icon = Icons.pause_circle_filled_outlined;
      onTap = () => bloc.add(MusicPlayerPause());
    }

    if (playerState?.processingState == AudioProcessingState.completed) {
      icon = Icons.replay_outlined;
      onTap = () => bloc.add(const MusicPlayerSeek(position: Duration.zero));
    }

    return AnimatedSwitcher(
      duration: AppSizes.durationFast,
      child: ControlButton(
        key: Key(icon.toString()),
        icon: icon,
        onTap: onTap,
        isEnabled: true,
        size: 60,
      ),
    );
  }

  Widget _buildSeedNextButton() {
    // widget.musicPlayerState.musicPlayerData.playbackState.

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
    var mode = AudioServiceRepeatMode.all;

    mode = widget.musicPlayerState.musicPlayerData?.playbackState.repeatMode ??
        mode;

    final color =
        mode == AudioServiceRepeatMode.none ? Colors.white : AppColors.primary;
    var icon =
        mode == AudioServiceRepeatMode.one ? Icons.repeat_one : Icons.repeat;

    return ControlButton(
      icon: icon,
      color: color,
      isEnabled: true,
      onTap: () {
        if (mode == AudioServiceRepeatMode.all) {
          audioPlayer.setLoopMode(LoopMode.one);
        } else if (mode == AudioServiceRepeatMode.one) {
          audioPlayer.setLoopMode(LoopMode.off);
        } else {
          audioPlayer.setLoopMode(LoopMode.all);
        }
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
