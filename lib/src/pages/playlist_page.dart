import 'package:spotify_clone/src/data/models/playlist.dart';

import '../core/utils/common_libs.dart';
import '../widgets/header_delegate.dart';
import '../widgets/song_item.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key, required this.playlist});
  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              delegate: HeaderDelegate(playlist: playlist),
              pinned: true,
              floating: false,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingLg,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          playlist.title,
                          style: context.headlineSmall.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(playlist.coverUrl),
                              radius: 12.w,
                            ),
                            SizedBox(width: 5.w),
                            Text('The Beatles', style: context.bodyMedium),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Text('Album - 2000'),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(Icons.favorite_border),
                            SizedBox(width: 10.w),
                            Icon(Icons.download_for_offline_rounded,
                                color: AppColors.primary),
                            SizedBox(width: 10.w),
                            Icon(Icons.more_horiz),
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.play_circle_fill_outlined,
                      size: 60,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
            SliverList.builder(
              itemCount: playlist.songs.length * 2,
              itemBuilder: (context, index) {
                final song = playlist.songs[index % playlist.songs.length];
                return SongItem(song: song);
              },
            )
          ],
        ),
      ),
    );
  }
}
