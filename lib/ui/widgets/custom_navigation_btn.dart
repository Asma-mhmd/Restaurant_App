import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/themes/app_colors.dart';

class CustomNavigationBtn extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomNavigationBtn({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.navigate_next,
          size: 18.sp,
          color: AppColors.textPrimary,
        ),
        onPressed:onPressed,
      ),
    );
  }
}
