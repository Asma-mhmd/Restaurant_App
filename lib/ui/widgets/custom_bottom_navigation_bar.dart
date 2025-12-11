import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/themes/app_colors.dart';
import '../screens/home_screen.dart';
import 'bottom_bar_with_hole_painter.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final double fabSize;
  final double notchWidth;
  final double notchHeight;
  final double bottomBarHeight;
  final double notchCornerRadius;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.fabSize,
    required this.notchWidth,
    required this.notchHeight,
    required this.bottomBarHeight,
    required this.notchCornerRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      child: Container(
        height: bottomBarHeight,
        child: CustomPaint(
          painter: BottomBarWithHolePainter(
            color: Colors.white,
            notchWidth: notchWidth,
            notchHeight: notchHeight,
            cornerRadius: notchCornerRadius,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false,
          );},
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      selectedIndex == 0 ? AppColors.selectedIcon : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/images/home.png',
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => onItemTapped(1),
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      selectedIndex == 1 ? AppColors.selectedIcon : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/images/shop_ic.png',
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                ),
                SizedBox(width: fabSize),
                IconButton(
                  icon: Icon(Icons.favorite_border,
                      color: selectedIndex == 2 ? AppColors.selectedIcon : Colors.grey),
                  onPressed: () => onItemTapped(2),
                ),
                IconButton(
                  onPressed: () => onItemTapped(3),
                  icon: Image.asset(
                    'assets/images/profile_img.png',
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}