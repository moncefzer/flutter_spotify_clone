import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_clone/src/core/config/app_colors.dart';
import 'package:spotify_clone/src/core/config/app_sizes.dart';
import 'package:spotify_clone/src/data/models/playlist.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/playlists_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.black,
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     AppColors.primary.withOpacity(0.6),
        //     Colors.black,
        //   ],
        //   stops: const [
        //     0.1,
        //     0.7,
        //   ],
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
        child: Column(
          children: [
            SizedBox(height: ScreenUtil().statusBarHeight + 15.h),
            const CustomAppBar(),
            PlaylistsSection(
              title: 'Recently Played',
              playlists: Playlist.playlists,
            ),
            SizedBox(height: 10.h),
            PlaylistsSection(
              title: 'Episodes For you',
              playlists: Playlist.playlists,
            ),
          ],
        ),
      ),
    );
  }
}
