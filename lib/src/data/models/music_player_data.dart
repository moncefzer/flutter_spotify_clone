import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';

import 'song.dart';

class MusicPlayerData extends Equatable {
  final Song? currentSong;
  final List<Song> songQueue;
  final PlaybackState playbackState;
  final Duration? currentSongDuration;
  final Duration? currentSongPosition;

  const MusicPlayerData({
    this.currentSong,
    required this.songQueue,
    required this.playbackState,
    this.currentSongDuration,
    this.currentSongPosition,
  });

  bool get currentSongHasNext => currentSong != songQueue.lastOrNull;

  bool get currentSongHasPrevious => currentSong != songQueue.firstOrNull;

  @override
  List<Object?> get props => [
        currentSong,
        songQueue,
        playbackState,
        currentSongDuration,
        currentSongPosition
      ];
}
