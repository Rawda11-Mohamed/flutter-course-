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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'features/data/repo/auth_repo_imp.dart';
import 'features/cubit/login_cubit.dart';
import 'features/cubit/register_cubit.dart';
import 'features/cubit/home_cubit.dart';
import 'features/cubit/update_name_cubit.dart';
import 'features/cubit/change_password_cubit.dart';
import 'features/cubit/language_cubit.dart';
import 'features/cubit/add_task_cubit.dart';
import 'features/cubit/today_tasks_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) => Provider(
        create: (context) => AuthRepoImp(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoginCubit(Provider.of<AuthRepoImp>(context, listen: false))),
            BlocProvider(create: (context) => RegisterCubit(Provider.of<AuthRepoImp>(context, listen: false))),
            BlocProvider(create: (context) => HomeCubit(Provider.of<AuthRepoImp>(context, listen: false))),
            BlocProvider(create: (context) => UpdateNameCubit(Provider.of<AuthRepoImp>(context, listen: false))),
            BlocProvider(create: (context) => ChangePasswordCubit(Provider.of<AuthRepoImp>(context, listen: false))),
            BlocProvider(create: (context) => LanguageCubit()),
            BlocProvider(create: (context) => AddTaskCubit(Provider.of<AuthRepoImp>(context, listen: false))),
            BlocProvider(create: (context) => TodayTasksCubit(Provider.of<AuthRepoImp>(context, listen: false))),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashView(),
              '/start': (context) => const StartScreen(),
              '/login': (context) => LoginScreen(),
              '/register': (context) => RegisterScreen(),
              '/home': (context) => const HomeScreen(),
              '/todayTasks': (context) => const TodayTasksScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/addTask': (context) => AddTaskScreen(),
              '/editTask': (context) => EditTaskScreen(
                taskData: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?,
              ),
              '/updateName': (context) => const UpdateNameScreen(),
              '/changePassword': (context) => const ChangePasswordScreen(),
              '/language': (context) => const LanguageScreen(),
            },
            home: widget,
          ),
        ),
      ),
    );
  }
}