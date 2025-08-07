import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/lets_start_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/update_name_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/language_screen.dart';
import 'screens/today_tasks_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/edit_task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TodayTasksScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/Splash': (context) => const SplashScreen(),
        '/lets-start': (context) => const LetsStartScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),

        '/update-name': (context) => const UpdateNameScreen(),
        '/change-password': (context) => const ChangePasswordScreen(),
        '/language': (context) => const LanguageScreen(),
        '/today-tasks': (context) => const TodayTasksScreen(),
        '/add-task': (context) => const AddTaskScreen(),
        '/edit-task': (context) => const EditTaskScreen(),
      },
    );
  }
}
