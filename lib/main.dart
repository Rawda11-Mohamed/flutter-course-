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
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'features/data/models/task_model.dart';

// Bloc
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
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit(AuthRepoImp())),
          BlocProvider(create: (context) => RegisterCubit(AuthRepoImp())),
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => UpdateNameCubit(AuthRepoImp())),
          BlocProvider(create: (context) => ChangePasswordCubit(AuthRepoImp())),
          BlocProvider(create: (context) => LanguageCubit()),
          BlocProvider(create: (context) => AddTaskCubit(AuthRepoImp())),
          BlocProvider(create: (context) => TodayTasksCubit(AuthRepoImp())),
        ],
        child: Provider(
          create: (context) => AuthRepoImp(),
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
                model: ModalRoute.of(context)!.settings.arguments as TaskModel,
              ),
              '/updateName': (context) => const UpdateNameScreen(),
              '/changePassword': (context) => const ChangePasswordScreen(),
              '/language': (context) => const LanguageScreen(),
            },
          ),
        ),
      ),
    );
  }
}