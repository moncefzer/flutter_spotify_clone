import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/src/data/models/music_player_data.dart';
import 'package:spotify_clone/src/data/repositories/song_repository.dart';

import '../../data/models/song.dart';

part 'music_player_state.dart';

class MusicPlayerCubit extends Cubit<MusicPlayerState> {
  final SongRepository _songRepository;
  late final StreamSubscription subscription;

  static MusicPlayerCubit get(context) => BlocProvider.of(context);

  MusicPlayerCubit({required SongRepository songRepository})
      : _songRepository = songRepository,
        super(const MusicPlayerState()) {
    //? initilize listeners
    _onStarted();
  }

  FutureOr<void> _onStarted() async {
    subscription = _songRepository.musicPlayerDataStream.listen((data) async {
      print(data.songQueue.length);
      if (state.status == MusicPlayerStatus.initial &&
          data.currentSong == null) {
        return emit(
          state.copyWith(
            musicPlayerData: data,
            status: MusicPlayerStatus.initial,
          ),
        );
      }

      if (state.status == MusicPlayerStatus.initial &&
          data.currentSong != null) {
        return emit(
          state.copyWith(
            musicPlayerData: data,
            status: MusicPlayerStatus.loaded,
          ),
        );
      }

      if (state.status == MusicPlayerStatus.paused) {
        return emit(state.copyWith(
          musicPlayerData: data,
          status: MusicPlayerStatus.paused,
        ));
      }

      if (state.status == MusicPlayerStatus.playing) {
        return emit(state.copyWith(
          musicPlayerData: data,
          status: MusicPlayerStatus.playing,
        ));
      }

      return emit(state.copyWith(
        musicPlayerData: data,
        status: MusicPlayerStatus.initial,
      ));
    });
  }

  FutureOr<void> pause() async {
    await _songRepository.pause();
    emit(state.copyWith(status: MusicPlayerStatus.paused));
  }

  FutureOr<void> play() async {
    await _songRepository.play();
    emit(state.copyWith(status: MusicPlayerStatus.playing));
  }

  FutureOr<void> skipToNext() async {
    await _songRepository.skipToNext();
    emit(state.copyWith(status: MusicPlayerStatus.initial));
  }

  FutureOr<void> skipToPrevious() async {
    await _songRepository.skipToPrevious();
    emit(state.copyWith(status: MusicPlayerStatus.initial));
  }

  FutureOr<void> seek(Duration position) async {
    await _songRepository.seek(position);
    emit(state.copyWith(status: MusicPlayerStatus.initial));
  }

  FutureOr<void> updateQueue(List<Song> songs) async {
    await _songRepository.updateQueue(songs);
    emit(state.copyWith(status: MusicPlayerStatus.initial));
  }

  FutureOr<void> setCurrentSong(Song song) async {
    await _songRepository.setCurrentSong(song);
    emit(state.copyWith(status: MusicPlayerStatus.initial));
  }

  FutureOr<void> changeRepeatMode(AudioServiceRepeatMode currentMode) async {
    await _songRepository.changeRepeatMode(currentMode);
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
