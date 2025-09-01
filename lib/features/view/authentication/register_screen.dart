import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvmproject/core/utils/app_assets.dart';
import 'package:mvvmproject/core/utils/app_paddings.dart';
import 'package:mvvmproject/core/widgets/custom_auth_image.dart';
import 'package:mvvmproject/core/widgets/default_btn.dart';
import 'package:mvvmproject/core/widgets/default_form_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mvvmproject/features/cubit/register_cubit.dart';
import 'package:mvvmproject/features/cubit/register_state.dart';
import 'package:mvvmproject/features/cubit/home_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = RegisterCubit.get(context);

    return Scaffold(
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            children: [
              CustomAuthImage(),
              SizedBox(height: 23.h),
              Column(
                children: [
                  DefaultFormField(
                    controller: cubit.usernameController,
                    hintText: "Username",
                    prefixIcon: SvgPicture.asset(
                      AppAssets.profileIcon,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                  const SizedBox(height: 15),
                  DefaultFormField(
                    controller: cubit.emailController,
                    hintText: "Email",
                    prefixIcon: SvgPicture.asset(
                      AppAssets.profileIcon,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                  const SizedBox(height: 15),
                  DefaultFormField(
                    controller: cubit.passwordController,
                    hintText: "Password",
                    prefixIcon: SvgPicture.asset(
                      AppAssets.keyIcon,
                      width: 24.w,
                      height: 24.h,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: cubit.changePasswordVisibility,
                      child: SvgPicture.asset(
                        cubit.passwordSecure
                            ? AppAssets.lockIcon
                            : AppAssets.unlockIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                    obscureText: cubit.passwordSecure,
                  ),
                  const SizedBox(height: 15),
                  DefaultFormField(
                    controller: cubit.confirmPasswordController,
                    hintText: "Confirm Password",
                    prefixIcon: SvgPicture.asset(
                      AppAssets.keyIcon,
                      width: 24.w,
                      height: 24.h,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: cubit.changeConfirmPasswordVisibility,
                      child: SvgPicture.asset(
                        cubit.confirmPasswordSecure
                            ? AppAssets.lockIcon
                            : AppAssets.unlockIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                    obscureText: cubit.confirmPasswordSecure,
                  ),
                  const SizedBox(height: 20),
                  state is RegisterLoading
                      ? const CircularProgressIndicator()
                      : DefaultBtn(
                    text: "Register",
                    onPressed: () {
                      cubit.register();
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text("Already Have An Account? Login"),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}