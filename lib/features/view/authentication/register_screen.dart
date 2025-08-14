import 'package:flutter/material.dart';
import 'package:mvvmproject/core/utils/app_assets.dart';
import 'package:mvvmproject/core/widgets/default_btn.dart';
import 'package:mvvmproject/core/widgets/default_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Container(
              height: 298.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage(AppAssets.flag),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 23.h),
            DefaultFormField(
              controller: usernameController,
              hintText: "Username",
              prefixIcon: const Icon(Icons.person),
            ),
            const SizedBox(height: 15),
            DefaultFormField(
              controller: passwordController,
              hintText: "Password",
              prefixIcon: const Icon(Icons.lock),
              obscureText: true,
            ),
            const SizedBox(height: 15),
            DefaultFormField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              prefixIcon: const Icon(Icons.lock_outline),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            DefaultBtn(
              text: "Register",
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text("Already Have An Account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
