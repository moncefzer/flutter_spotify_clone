part of 'music_player_bloc.dart';

abstract class MusicPlayerEvent extends Equatable {
  const MusicPlayerEvent();
  @override
  List<Object> get props => [];
}

class MusicPlayerStarted extends MusicPlayerEvent {}

class MusicPlayerPlay extends MusicPlayerEvent {}

class MusicPlayerPause extends MusicPlayerEvent {}

class MusicPlayerSeek extends MusicPlayerEvent {
  final Duration position;

  const MusicPlayerSeek({required this.position});

  @override
  List<Object> get props => [position];
}

class MusicPlayerSetCurrentSong extends MusicPlayerEvent {
  final Song song;

  const MusicPlayerSetCurrentSong({required this.song});

  @override
  List<Object> get props => [song];
}
