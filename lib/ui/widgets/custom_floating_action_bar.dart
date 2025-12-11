import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/themes/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double fabSize;

  const CustomFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.fabSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fabSize,
      height: fabSize,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: AppColors.primaryPurple,
        child: Image.asset(
          'assets/images/basket_ic.png',
          width: 30.w,
          height: 30.w,
        ),
        shape: CircleBorder(),
        elevation: 4.0,
      ),
    );
  }
}