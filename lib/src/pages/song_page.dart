import 'dart:math' show pi, min;
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/src/data/models/song.dart';
import '../core/utils/common_libs.dart';
import '../widgets/music_player.dart';
import '../widgets/seek_bar.dart';
import 'package:rxdart/rxdart.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key, required this.song});

  final Song song;

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  late final AudioPlayer audioPlayer;
  final sonUrl =
      'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3';
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    try {
      // audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(sonUrl)));
      // audioPlayer.setAsset('assets/songs/marinate__zorro.mp3');
      audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children: [
            // AudioSource.uri(Uri.parse(sonUrl)),
            AudioSource.asset(widget.song.songPath),
          ],
        ),
        initialPosition: Duration.zero,
        preload: true,
      );
    } catch (err) {
      print(err);
    }
  }

  @override
  void dispose() {
    audioPlayer.pause();
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarData =>
      Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        audioPlayer.positionStream,
        audioPlayer.durationStream,
        (Duration position, Duration? duration) {
          return SeekBarData(position, duration ?? Duration.zero);
        },
      );

  @override
  Widget build(BuildContext context) {
    final imageSize = min(1.sw, 0.4.sh);

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
            SizedBox(height: 0.1.sh),
            Image.network(
              widget.song.coverUrl,
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
                    Text(widget.song.title,
                        style: context.titleMedium
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      widget.song.artist.name,
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
            MusicPlayer(
              seekBarData: _seekBarData,
              audioPlayer: audioPlayer,
            )
          ],
        ),
      ),
    );
  }
}
