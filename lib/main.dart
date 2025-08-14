import 'package:flutter/material.dart';
import 'features/view/starting app/splash_screen.dart';
import 'features/view/starting app/start_screen.dart';
import 'features/view/authentication/login_screen.dart';
import 'features/view/authentication/register_screen.dart';
import 'features/view/authentication/home_screen.dart';
import 'features/view/tasks/today_tasks_screen.dart';
import 'features/view/authentication/profile_screen.dart';
import 'features/view/tasks/add_task.dart';
import 'features/view/tasks/edit_task_screen.dart';
import 'features/view/authentication/update_screen.dart';
import 'features/view/authentication/change_password_screen.dart';
import 'features/view/authentication/language_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget)=> MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/start': (context) => const StartScreen(),
        '/login': (context) =>  LoginScreen(),
        '/register': (context) =>  RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/todayTasks': (context) => const TodayTasksScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/addTask': (context) => const AddTaskScreen(),
        '/editTask': (context) => const EditTaskScreen(),
        '/updateName': (context) => const UpdateNameScreen(),
        '/changePassword': (context) => const ChangePasswordScreen(),
        '/language': (context) => const LanguageScreen(),
      },
    ));
  }
}