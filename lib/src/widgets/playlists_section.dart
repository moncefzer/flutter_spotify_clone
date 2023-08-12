import '../core/utils/common_libs.dart';
import '../data/models/playlist.dart';

class PlaylistsSection extends StatelessWidget {
  const PlaylistsSection({
    super.key,
    required this.title,
    required this.playlists,
  });
  final String title;
  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: title),
        SectionBody(playlists: playlists),
      ],
    );
  }
}

class SectionBody extends StatelessWidget {
  const SectionBody({
    super.key,
    required this.playlists,
  });

  final List<Playlist> playlists;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: ListView.separated(
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(width: 15.w),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return PlaylistItem(playlist: playlist);
        },
      ),
    );
  }
}

class PlaylistItem extends StatelessWidget {
  const PlaylistItem({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.playlist.name,
          extra: playlist,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            height: 150.h,
            width: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: Image.network(
              playlist.coverUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            playlist.title,
            style: context.titleSmall,
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.action = 'View All',
  });

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            ),
          ),
          const Spacer(),
          Text(
            action,
            style: context.labelMedium.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
