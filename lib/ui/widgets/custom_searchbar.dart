import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/themes/app_colors.dart';

class CustomSearchbar extends StatefulWidget {
  final ValueChanged<String>? onSubmitted;

  const CustomSearchbar({super.key, this.onSubmitted});

  @override
  State<CustomSearchbar> createState() => _CustomSearchbarState();
}

class _CustomSearchbarState extends State<CustomSearchbar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),

        prefixIcon: Icon(
          Icons.search,
          color: AppColors.primaryPurple,
          size: 20.sp,
        ),

        border: InputBorder.none,
        filled: true,
        fillColor: AppColors.appBarBackground,

        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: const BorderSide(color: AppColors.searchBorderColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: const BorderSide(color: AppColors.primaryPurple, width: 1.0),
        ),
      ),
    );
  }
}
