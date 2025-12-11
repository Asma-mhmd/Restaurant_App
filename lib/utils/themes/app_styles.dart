import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';



class AppStyles {
  static TextStyle appBarTitle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 18.0.sp,
    color: AppColors.primaryPurple,
    height: 1.0,
  );

  static TextStyle categoryText = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    color: AppColors.textPrimary,
    height: 1.0,
  );
  static TextStyle listTitle= TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  fontSize: 16.sp,
  color: AppColors.textPrimary,
  );
}