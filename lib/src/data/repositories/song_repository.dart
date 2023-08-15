import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotify_clone/src/core/services/audio_handler.dart';
import 'package:spotify_clone/src/core/utils/audio_packages_adapter.dart';
import 'package:spotify_clone/src/core/utils/util_func.dart';

import '../models/music_player_data.dart';
import '../models/song.dart';

class SongRepository {
  SongRepository({required AudioHandler audioHandler})
      : _audioHandler = audioHandler;

  final AudioHandler _audioHandler;

  Future<List<Song>?> getSongs() async {
    try {
      List<Song> songs = await Future.delayed(
        const Duration(seconds: 1),
        () => Song.songs,
      );

      return songs;
    } catch (_) {
      return null;
    }
  }

  Future<Song?> getSongById(String songId) async {
    try {
      Song? song = await Future.delayed(
        const Duration(seconds: 1),
        () => Song.songs.where((song) => song.id == songId).first,
      );

      return song;
    } catch (_) {
      return null;
    }
  }

  Future<void> play() => _audioHandler.play();

  Future<void> pause() => _audioHandler.pause();

  Future<void> skipToNext() => _audioHandler.skipToNext();

  Future<void> skipToPrevious() => _audioHandler.skipToPrevious();

  Future<void> updateQueue(List<Song> songs) => _audioHandler.updateQueue(
        songs.map((song) => song.toMediaItem()).toList(),
      );

  Future<void> seek(Duration position) => _audioHandler.seek(position);

  Future<void> changeRepeatMode(AudioServiceRepeatMode currentMode) {
    final mode = AudioPackagesHelper.getNextRepeatMode(currentMode);
    return _audioHandler.setRepeatMode(mode);
  }

  /// A stream reporting the combined state of the current media item and its
  /// current position.
  Stream<MusicPlayerData> get musicPlayerDataStream => Rx.combineLatest4<
              PlaybackState,
              List<MediaItem>,
              MediaItem?,
              Duration,
              MusicPlayerData>(_audioHandler.playbackState, _audioHandler.queue,
          _audioHandler.mediaItem, AudioService.position, (
        PlaybackState playbackState,
        List<MediaItem> queue,
        MediaItem? mediaItem,
        Duration position,
      ) {
        return MusicPlayerData(
          currentSong:
              (mediaItem == null) ? null : Song.fromMediaItem(mediaItem),
          songQueue: queue.map((mediaItem) {
            return Song.fromMediaItem(mediaItem);
          }).toList(),
          playbackState: playbackState,
          currentSongPosition: minDuration(
            position.abs(),
            mediaItem?.duration ?? Duration.zero,
          ),
          currentSongDuration:
              (mediaItem == null) ? null : mediaItem.duration?.abs(),
        );
      });

  Future<void> setCurrentSong(Song song) async {
    _audioHandler.removeQueueItemAt(0);
    _audioHandler.addQueueItem(song.toMediaItem());
  }
}
