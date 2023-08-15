# spotify_clone

A new Flutter project.

## Packages explanation

In the project we have used just_audio and audio_service packages

audio_service package works to handle audio in the background and show the media notification,
it offer a framework by implement the [BaseAudioHandler] class using any audio package, here we used just_audio package

```dart
    class MyAudioHandler extends BaseAudioHandler {

        final _player = AudioPlayer();
        @override
        Future<void> play() => _player.play();

        @override
        Future<void> pause() => _player.pause();

        @override
        Future<void> seek(Duration position) => _player.seek(position);

        @override
        Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
            return _player.setLoopMode(
            AudioPackagesHelper.serviceToJustAudioLoopMode(repeatMode),
            );
        }

        @override
        Future<void> skipToNext() async {
            return _player.seekToNext();
        }

        @override
        Future<void> skipToPrevious() async {
            return _player.seekToPrevious();
        }

        //...

    }
```

## Integration

we add required changes for android and ios after
in the main methode we initialize the audio service

```dart
    void main() async {
        WidgetsFlutterBinding.ensureInitialized();

        await setupInjection();

        runApp(const SpotifyApp());
    }


    final sl = GetIt.instance;

    Future<void> setupInjection() async {
        final audioService = await initAudioService();

        sl.registerLazySingleton<AudioHandler>(() => audioService);

        sl.registerLazySingleton(() => SongRepository(audioHandler: sl()));

        sl.registerFactory(() => MusicPlayerCubit(songRepository: sl()));
    }


```

## Resources :

- packages on pub.dev [audio_service](https://pub.dev/packages/audio_service) [just_audio](https://pub.dev/packages/just_audio)
- demo project of the package owner [demo_project](https://github1s.com/suragch/flutter_audio_service_demo/blob/HEAD/final)
- music app be maxonflutter [music_app](https://github.com/maxonflutter/atomsbox_music_app_with_bloc/tree/10_bottom_nav_bar)
- medium articles [one](https://suragch.medium.com/background-audio-in-flutter-with-audio-service-and-just-audio-3cce17b4a7d) [two](https://suragch.medium.com/managing-playlists-in-flutter-with-just-audio-c4b8f2af12eb)
