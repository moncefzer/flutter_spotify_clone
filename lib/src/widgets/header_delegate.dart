import '../core/utils/common_libs.dart';
import '../data/models/playlist.dart';

var _minHeaderHeight = kToolbarHeight;
var _maxHeaderHeight = 0.4.sh;

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Playlist playlist;

  HeaderDelegate({required this.playlist});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderHeight;
    final maxImageSize = _maxHeaderHeight * 0.7;
    final minImageSize = 80.h;
    var imageSize = maxImageSize;
    if (_maxHeaderHeight - shrinkOffset <= imageSize) {
      imageSize = _maxHeaderHeight - shrinkOffset;
    }

    imageSize = imageSize.clamp(minImageSize, maxImageSize);
    final imageOpacity = (1 - percent + 0.4).clamp(0.0, 1.0);
    final isAppBarHidden = percent < 0.8;

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.1, 0.95],
                colors: [
                  AppColors.primary.withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          height: kToolbarHeight,
          top: isAppBarHidden ? -kToolbarHeight : 0.0,
          left: 0,
          right: 0,
          duration: const Duration(milliseconds: 300),
          child: AppBar(
            leading: const BackButton(),
            leadingWidth: 30,
            title: Text(
              playlist.title,
              style: context.titleMedium,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: AppSizes.durationMid,
          top: 15.h,
          left: isAppBarHidden ? AppSizes.paddingLg : AppSizes.paddingSm,
          child: AnimatedOpacity(
            duration: AppSizes.durationFast,
            opacity: isAppBarHidden ? 1.0 : 0.0,
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.4),
              child: const BackButton(color: Colors.white),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isAppBarHidden ? imageOpacity : 0.0,
          child: Center(
            child: Image.network(
              playlist.coverUrl,
              height: imageSize,
              width: imageSize,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => _maxHeaderHeight;

  @override
  double get minExtent => _minHeaderHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
