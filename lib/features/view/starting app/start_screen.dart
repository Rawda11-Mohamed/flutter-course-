import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvmproject/core/utils/app_assets.dart';
import 'package:mvvmproject/core/utils/app_colors.dart';
import 'package:mvvmproject/core/widgets/default_btn.dart';
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.all(20),child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            SvgPicture.asset(AppAssets.letStart,
              width: double.infinity,
              height: 344.h,
            ),
            SizedBox(height: 44.h,),
            Text("Ready to conquer your tasks? Let's Do It together.",
              style: TextStyle(

                  fontWeight: FontWeight.w500,
                  color: AppColors.grey
              ),),
            SizedBox(height: 20.h,),
            DefaultBtn(
              text: "Let's Start",
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
            ),
          ],
        ),))
    );
  }
}