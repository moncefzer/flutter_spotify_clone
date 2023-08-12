import 'package:flutter/material.dart';
import 'package:spotify_clone/src/core/config/app_colors.dart';
import 'package:spotify_clone/src/core/config/app_sizes.dart';
import 'package:spotify_clone/src/core/extension/context_extensions.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    super.key,
  });
  final navData = [
    NavBarItemData(icon: Icons.home_filled, label: 'Home'),
    NavBarItemData(icon: Icons.search, label: 'Search'),
    NavBarItemData(icon: Icons.library_books_rounded, label: 'Your Library'),
  ];
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      child: BottomNavigationBar(
        backgroundColor: AppColors.black,
        currentIndex: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: AppColors.grey,
        iconSize: 29,
        items: navData
            .map(
              (item) => BottomNavigationBarItem(
                  icon: Icon(item.icon), label: item.label),
            )
            .toList(),
      ),
    );
    // return Container(
    //   clipBehavior: Clip.hardEdge,
    //   decoration: BoxDecoration(
    //     color: Colors.grey.withOpacity(0.2),
    //     borderRadius: BorderRadius.circular(AppSizes.radiusSm),
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       for (int index = 0; index < navData.length; index++)
    //         CustomNavBarItem(
    //           icon: navData[index].icon,
    //           label: navData[index].label,
    //           index: index,
    //           isSelected: index == 0,
    //         )
    //     ],
    //   ),
    // );
  }
}

class CustomNavBarItem extends StatelessWidget {
  const CustomNavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.index,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        onTap: () {
          // todo : with index
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            Text(label, style: context.bodySmall),
          ],
        ),
      ),
    );
  }
}

class NavBarItemData {
  final IconData icon;
  final String label;

  NavBarItemData({
    required this.icon,
    required this.label,
  });
}
