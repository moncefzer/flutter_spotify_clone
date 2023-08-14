import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/src/data/models/playlist.dart';
import 'package:spotify_clone/src/pages/layout_page.dart';

import '../../data/models/song.dart';
import '../../pages/playlist_page.dart';
import '../../pages/song_page.dart';

//? context.go()   will start a new navigation stack unless the destination is a sub-level route
//? context.push() will push in the same navigation stack even it's not a sub-level route

enum Routes {
  home('/'),
  playlist('/playlist'),
  song('/song');

  final String path;
  const Routes(this.path);
}

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: Routes.home.path,
    routes: [
      GoRoute(
        path: Routes.home.path,
        name: Routes.home.name,
        builder: (context, state) => const LayoutPage(),
      ),
      GoRoute(
        path: Routes.playlist.path,
        name: Routes.playlist.name,
        builder: (context, GoRouterState state) {
          final playlist = state.extra as Playlist;
          return PlaylistPage(playlist: playlist);
        },
      ),
      GoRoute(
        path: Routes.song.path,
        name: Routes.song.name,
        // builder: (context, state) {
        // final song = Song.songs[0];
        // return SongPage(song: song);
        // },
        pageBuilder: (context, state) {
          final song = state.extra as Song;
          return CustomTransitionPage(
            child: SongPage(song: song),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final animPosit = Tween<Offset>(
                begin: const Offset(0, 0.5),
                end: const Offset(0, 0),
              ).animate(animation);
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: animPosit,
                  child: child,
                ),
              );
            },
          );
        },
      ),
    ],
  );
}
