import 'package:flutter/material.dart';
import 'package:spotify_clone/src/core/config/app_themes.dart';
import 'package:spotify_clone/src/pages/layout_page.dart';

class SpotifyApp extends StatelessWidget {
  const SpotifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: LayoutPage(),
    );
  }
}
