import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_todo_app/feature/authenticaton/login/presentation/view/login_screen.dart';
import 'package:up_todo_app/feature/authenticaton/register/presentation/view/register_screen.dart';
import 'package:up_todo_app/feature/intro/presentation/intro_screen.dart';
import 'package:up_todo_app/feature/intro/presentation/start_screen.dart';
import 'core/routes/page_route_name.dart';
import 'core/casheing/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      initialRoute: PageRouteName.intro, // الصفحة الافتراضية
      routes: {
        PageRouteName.intro: (context) => IntroScreen(),
        PageRouteName.startScreen: (context) => StartScreen(),
        PageRouteName.loginScreen: (context) => LoginScreen(),
        PageRouteName.registerScreen: (context) => RegisterScreen(),

      },
    );
  }
}
