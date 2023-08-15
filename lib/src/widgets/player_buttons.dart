import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/src/core/extension/audio_ext.dart';
import 'package:spotify_clone/src/core/extension/bool_ext.dart';

import '../controllers/music_payer_bloc/music_player_cubit.dart';
import '../core/utils/common_libs.dart';

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

  late final MusicPlayerCubit bloc;

  @override
  void initState() {
    super.initState();
    bloc = MusicPlayerCubit.get(context);
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
    final hasPrevious = widget
        .musicPlayerState.musicPlayerData?.currentSongHasPrevious.ifNullFalse;

    return ControlButton(
      icon: Icons.skip_previous_rounded,
      isEnabled: hasPrevious,
      onTap: bloc.skipToPrevious,
      size: 45,
    );
  }

  Widget _buildPausePlayButton() {
    //? default is ready
    var icon = Icons.play_circle_filled_rounded;
    var onTap = bloc.play;

    final playerState = widget.musicPlayerState.musicPlayerData?.playbackState;

    if (playerState?.playing ?? false) {
      icon = Icons.pause_circle_filled_outlined;
      onTap = bloc.pause;
    }

    if (playerState?.processingState == AudioProcessingState.completed) {
      icon = Icons.replay_outlined;
      onTap = () => bloc.seek(Duration.zero);
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
    final hasNext =
        widget.musicPlayerState.musicPlayerData?.currentSongHasNext ?? false;

    return ControlButton(
      icon: Icons.skip_next_rounded,
      isEnabled: hasNext,
      onTap: bloc.skipToNext,
      size: 45,
    );
  }

  Widget _buildLoopModeButton() {
    final mode = widget.musicPlayerState.musicPlayerData?.playbackState
        .repeatMode.ifNullNoneMode;

    final color =
        mode == AudioServiceRepeatMode.none ? Colors.white : AppColors.primary;
    var icon =
        mode == AudioServiceRepeatMode.one ? Icons.repeat_one : Icons.repeat;

    return ControlButton(
      icon: icon,
      color: color,
      isEnabled: true,
      onTap: () => bloc.changeRepeatMode(mode),
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
