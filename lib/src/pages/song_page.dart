import 'dart:math' show pi, min;
import 'package:spotify_clone/src/data/models/song.dart';
import '../controllers/music_payer_bloc/music_player_bloc.dart';
import '../core/utils/common_libs.dart';
import '../widgets/music_player.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key, required this.song});

  final Song song;

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => MusicPlayerBloc.get(context)
          .add(MusicPlayerSetCurrentSong(song: widget.song)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          radius: 30,
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            context.pop();
          },
          child: Transform.rotate(
            angle: pi / 2,
            child: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ),
        title: Text(
          widget.song.artist.name,
          style: context.titleMedium,
        ),
        actions: [
          const Icon(Icons.more_horiz),
          SizedBox(width: 10.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingLg.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SongMetaData(song: widget.song),
            const MusicPlayer(),
          ],
        ),
      ),
    );
  }
}

class SongMetaData extends StatelessWidget {
  const SongMetaData({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    final imageSize = min(1.sw, 0.4.sh);
    return Column(
      children: [
        SizedBox(height: 0.1.sh),
        Image.network(
          song.coverUrl,
          height: imageSize,
          width: imageSize,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 0.05.sh),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  song.artist.name,
                  style: context.titleSmall,
                ),
              ],
            ),
            Icon(
              Icons.favorite_border_outlined,
              size: 28.w,
            )
          ],
        ),
      ],
    );
  }
}
