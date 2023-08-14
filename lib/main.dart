import 'package:flutter/material.dart';
import 'package:spotify_clone/src/injection_container.dart';
import 'package:spotify_clone/src/spotify_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupInjection();

  runApp(const SpotifyApp());
}
