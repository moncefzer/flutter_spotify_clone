part of 'music_player_bloc.dart';

enum MusicPlayerStatus { initial, loaded, playing, paused }

class MusicPlayerState extends Equatable {
  final MusicPlayerStatus status;
  final MusicPlayerData? musicPlayerData;

  const MusicPlayerState({
    this.status = MusicPlayerStatus.initial,
    this.musicPlayerData,
  });

  MusicPlayerState copyWith({
    MusicPlayerStatus? status,
    MusicPlayerData? musicPlayerData,
  }) {
    return MusicPlayerState(
      status: status ?? this.status,
      musicPlayerData: musicPlayerData ?? this.musicPlayerData,
    );
  }

  @override
  List<Object?> get props => [status, musicPlayerData];
}
