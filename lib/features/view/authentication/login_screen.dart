import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvmproject/core/utils/app_assets.dart';
import 'package:mvvmproject/core/utils/app_paddings.dart';
import 'package:mvvmproject/core/widgets/custom_auth_image.dart';
import 'package:mvvmproject/core/widgets/default_btn.dart';
import 'package:mvvmproject/core/widgets/default_form_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvmproject/features/cubit/home_cubit.dart';
import 'package:mvvmproject/features/cubit/login_cubit.dart';
import 'package:mvvmproject/features/cubit/login_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = LoginCubit.get(context);

    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: HomeCubit.get(context)..loadUserData(state.user.name),
                  child: const HomeScreen(),
                ),
              ),
            );
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              CustomAuthImage(),
              SizedBox(height: 23.h),
              Padding(
                padding: AppPaddings.defaultHomePadding,
                child: Column(
                  children: [
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
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                        },
                        child: const Text("Forgot Password?"),
                      ),
                    ),
                    state is LoginLoading
                        ? const CircularProgressIndicator()
                        : DefaultBtn(
                      text: "Login",
                      onPressed: () {
                        cubit.login();
                      },
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text("Don't have an account? Register"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}