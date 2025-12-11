import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/themes/app_colors.dart';
import 'custom_searchbar.dart';
import '../../utils/themes/app_styles.dart';
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppbar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = 16.w;

    return PreferredSize(
      preferredSize: Size.fromHeight(125),
      child: Container(
        height: 125,
        padding: EdgeInsets.only(
          top: 35,
          left: horizontalPadding,
          right: horizontalPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.appBarBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomSearchbar(
                onSubmitted: (v) => print(v),
              ),
            ),

            SizedBox(width: 8.w),

            Flexible(
              flex: 1,
              child: Text(
                title,
                style: AppStyles.appBarTitle,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Spacer(),

            if (actions != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              ),

          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(125);
}
