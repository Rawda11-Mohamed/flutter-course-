import 'package:flutter/material.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/default_form_field.dart';
import '../../../core/widgets/default_btn.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                AppAssets.flag,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  DefaultFormField(controller: TextEditingController(),hintText: 'Old Password', prefixIcon:Icon(Icons.person), obscureText: true),
                  const SizedBox(height: 20),
                  DefaultFormField(controller: TextEditingController(),hintText: 'New Password', prefixIcon:Icon(Icons.person),obscureText: true),
                  const SizedBox(height: 20),
                  DefaultFormField(controller: TextEditingController(),hintText: 'Confirm Password', prefixIcon:Icon(Icons.person), obscureText: true),
                  const SizedBox(height: 40),
                  DefaultBtn(
                    text: "Save",
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}