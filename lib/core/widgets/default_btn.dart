import 'package:flutter/material.dart';
import 'package:mvvmproject/core/utils/app_colors.dart';


class DefaultBtn extends StatelessWidget {
  const DefaultBtn({super.key, required this.onPressed, required this.text});

  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shadowColor: AppColors.primary,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              )
          ),
          child: Text(
            text,
            style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w300,
                fontSize: 19
            ),
          )
      ),
    );
  }
}