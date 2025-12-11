import 'package:flutter/material.dart';
import '../../utils/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityControl extends StatelessWidget {
  final int quantity;
  final Function(int change) onQuantityChanged;

  const QuantityControl({Key? key, required this.quantity, required this.onQuantityChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSquareButton(
          icon: Icons.remove,
          onPressed: () => onQuantityChanged(-1),
          backgroundColor: Colors.grey.shade200,
          iconColor: AppColors.primaryPurple,
        ),

        SizedBox(width: 12.w),

        Text(
          quantity.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        SizedBox(width: 12.w),

        _buildSquareButton(
          icon: Icons.add,
          onPressed: () => onQuantityChanged(1),
          backgroundColor: AppColors.primaryPurple,
          iconColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildSquareButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 32.0,
        height: 32.0,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}