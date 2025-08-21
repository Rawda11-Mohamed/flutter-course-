import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_text_styles.dart';
import '../utils/app_colors.dart';

class DefaultBtn extends StatelessWidget {
  const DefaultBtn({super.key, required this.onPressed, required this.text});

  final String text;
  final  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r)
              ),
              shadowColor: AppColors.primary,
              elevation: 10
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 19.sp,
                fontWeight: AppFontWeight.light
            ),
          )
      ),
    );
  }
}