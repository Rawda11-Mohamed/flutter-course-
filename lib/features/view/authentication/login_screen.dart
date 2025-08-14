import 'package:flutter/material.dart';
import 'package:mvvmproject/core/utils/app_assets.dart';
import 'package:mvvmproject/core/widgets/default_btn.dart';
import 'package:mvvmproject/core/widgets/default_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            const SizedBox(height: 20),
            DefaultBtn(
              text: "Login",
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text("Don’t Have An Account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
