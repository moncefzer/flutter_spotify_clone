import '../core/utils/common_libs.dart';
import '../data/models/song.dart';

class SongItem extends StatelessWidget {
  const SongItem({
    super.key,
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.song.name,
          extra: song,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: AppSizes.paddingLg,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(song.title, style: context.bodyLarge),
                Row(
                  children: [
                    Icon(
                      Icons.download_for_offline_rounded,
                      color: AppColors.primary,
                      size: 17,
                    ),
                    SizedBox(width: 5.w),
                    Text(song.artist.name,
                        style: context.labelSmall.copyWith(letterSpacing: 0)),
                  ],
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }
}
