import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:spotify_clone/src/controllers/music_payer_bloc/music_player_cubit.dart';
import 'package:spotify_clone/src/core/services/audio_handler.dart';
import 'package:spotify_clone/src/data/repositories/song_repository.dart';

final sl = GetIt.instance;

Future<void> setupInjection() async {
  final audioService = await initAudioService();

  sl.registerLazySingleton<AudioHandler>(() => audioService);

  sl.registerLazySingleton(() => SongRepository(audioHandler: sl()));

  sl.registerFactory(() => MusicPlayerCubit(songRepository: sl()));
}
