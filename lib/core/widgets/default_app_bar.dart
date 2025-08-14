import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvmproject/core/utils/app_assets.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
      [
        CircleAvatar(
          backgroundImage: AssetImage(AppAssets.flag),
          radius: 30.r,
        ),
        SizedBox(
          width: 18.0.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text('Hello'),
              Text('Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed Ahmed ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

            ],
          ),
        )

      ],
    );
  }
}