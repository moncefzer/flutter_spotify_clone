import '../core/utils/common_libs.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Good Evening',
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Icon(Icons.notifications_none_rounded),
            SizedBox(width: 15.w),
            Icon(Icons.history),
            SizedBox(width: 15.w),
            Icon(Icons.settings),
          ],
        )
      ],
    );
  }
}
