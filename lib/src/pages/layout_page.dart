import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_clone/src/pages/home_page.dart';
import 'package:spotify_clone/src/pages/search_page.dart';
import 'package:spotify_clone/src/pages/your_lib_page.dart';

import '../widgets/custom_bottom_nav_bar.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: IndexedStack(
              index: 0,
              children: [
                HomePage(),
                SearchPage(),
                YourLibPage(),
              ],
            ),
          ),
          Positioned(
            bottom: 10.h,
            left: 10.w,
            right: 10.w,
            height: 60.h,
            child: CustomBottomNavBar(),
          )
        ],
      ),
    );
  }
}
