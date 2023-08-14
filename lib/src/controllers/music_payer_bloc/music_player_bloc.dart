import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/src/data/models/music_player_data.dart';
import 'package:spotify_clone/src/data/repositories/song_repository.dart';

import '../../data/models/song.dart';

part 'music_player_event.dart';
part 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final SongRepository _songRepository;

  static MusicPlayerBloc get(context) => BlocProvider.of(context);

  MusicPlayerBloc({required SongRepository songRepository})
      : _songRepository = songRepository,
        super(const MusicPlayerState()) {
    on<MusicPlayerStarted>(_onStarted);
    on<MusicPlayerPause>(_onPause);
    on<MusicPlayerPlay>(_onPlay);
    on<MusicPlayerSeek>(_onSeek);
    on<MusicPlayerSetCurrentSong>(_onSetCurrentSong);

    //? initilize listeners
    add(MusicPlayerStarted());
  }

  FutureOr<void> _onStarted(
      MusicPlayerStarted event, Emitter<MusicPlayerState> emit) async {
    await emit.forEach(
      _songRepository.musicPlayerDataStream,
      onData: (data) {
        if (state.status == MusicPlayerStatus.initial &&
            data.currentSong == null) {
          return state.copyWith(
            musicPlayerData: data,
            status: MusicPlayerStatus.initial,
          );
        }

        if (state.status == MusicPlayerStatus.initial &&
            data.currentSong != null) {
          return state.copyWith(
            musicPlayerData: data,
            status: MusicPlayerStatus.loaded,
          );
        }

        if (state.status == MusicPlayerStatus.paused) {
          return state.copyWith(
            musicPlayerData: data,
            status: MusicPlayerStatus.paused,
          );
        }

        if (state.status == MusicPlayerStatus.playing) {
          return state.copyWith(
            musicPlayerData: data,
            status: MusicPlayerStatus.playing,
          );
        }

        return state.copyWith(
          musicPlayerData: data,
          status: MusicPlayerStatus.initial,
        );
      },
    );
  }

  FutureOr<void> _onPause(
      MusicPlayerPause event, Emitter<MusicPlayerState> emit) async {
    await _songRepository.pause();

    emit(state.copyWith(status: MusicPlayerStatus.paused));
  }

  FutureOr<void> _onPlay(
      MusicPlayerPlay event, Emitter<MusicPlayerState> emit) async {
    await _songRepository.play();
    emit(state.copyWith(status: MusicPlayerStatus.playing));
  }

  FutureOr<void> _onSeek(
      MusicPlayerSeek event, Emitter<MusicPlayerState> emit) async {
    await _songRepository.seek(event.position);
    emit(state.copyWith(status: MusicPlayerStatus.initial));
  }

  FutureOr<void> _onSetCurrentSong(
      MusicPlayerSetCurrentSong event, Emitter<MusicPlayerState> emit) async {
    await _songRepository.setCurrentSong(event.song);
    emit(state.copyWith(status: MusicPlayerStatus.initial));
  }
}
