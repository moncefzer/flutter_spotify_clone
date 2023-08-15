import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_clone/src/controllers/music_payer_bloc/music_player_cubit.dart';
import 'package:spotify_clone/src/core/config/app_router.dart';
import 'package:spotify_clone/src/core/config/app_themes.dart';
import 'package:spotify_clone/src/data/repositories/song_repository.dart';

import 'injection_container.dart';

class SpotifyApp extends StatelessWidget {
  const SpotifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => sl<MusicPlayerCubit>(),
          child: RepositoryProvider(
            create: (context) => sl<SongRepository>(),
            child: MaterialApp.router(
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: ThemeMode.dark,
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
            ),
          ),
        );
      },
    );
  }
}
