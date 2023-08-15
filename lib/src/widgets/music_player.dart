import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/src/controllers/music_payer_bloc/music_player_cubit.dart';
import 'package:spotify_clone/src/widgets/player_buttons.dart';

import '../core/utils/common_libs.dart';
import 'seek_bar.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
      builder: (context, state) {
        final musicPlayerData = state.musicPlayerData;

        return Column(
          children: [
            SeekBar(
              duration: musicPlayerData?.currentSongDuration ?? Duration.zero,
              position: musicPlayerData?.currentSongPosition ?? Duration.zero,
              onChanged: (value) => onSeekPosition(value, context),
              onChangedEnd: (value) => onSeekPosition(value, context),
            ),
            PlayerButtons(musicPlayerState: state),
          ],
        );
      },
    );
  }

  void onSeekPosition(Duration value, BuildContext context) {
    MusicPlayerCubit.get(context).seek(value);
  }
}
