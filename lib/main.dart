import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_todo_app/core/size_config/size_config.dart';
import 'package:up_todo_app/feature/authenticaton/login/presentation/view/login_screen.dart';
import 'package:up_todo_app/feature/authenticaton/register/presentation/view/register_screen.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/categories/add_category.dart';
import 'package:up_todo_app/feature/home_screen/calender/calender_screen.dart';
import 'package:up_todo_app/feature/home_screen/foucs/presentation/view/foucs_screen.dart';
import 'package:up_todo_app/feature/home_screen/home_screen.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/view/edit_secreen.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/view/index_screen.dart';
import 'package:up_todo_app/feature/home_screen/person/presentation/view/person_screen.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/fonts/presentation/font_screen.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/localization/provider/provider.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/presentation/setting.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/theme/theme_data.dart';
import 'package:up_todo_app/feature/intro/presentation/intro_screen.dart';
import 'package:up_todo_app/feature/intro/presentation/start_screen.dart';

import 'core/casheing/cache_helper.dart';
import 'core/routes/page_route_name.dart';
import 'feature/home_screen/add_screen/add_screen.dart';
import 'feature/home_screen/person/setteings/localization/presentation/local_screen.dart';
import 'feature/home_screen/person/setteings/theme/presentation/color_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,DeviceOrientation.portraitDown
  // ]);
  runApp(DevicePreview(
      enabled: true,
      builder: (context) {
        return ProviderScope(child: Builder(builder: (context) => MyApp()));
      }));
}

class MyApp extends ConsumerWidget {
  bool flag = CacheHelper.getBool("Intro") ?? false;

  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    final lightTheme = ref.watch(appThemeProvider);
    final darkTheme = ref.watch(appDarkThemeProvider);
    final local = ref.watch(localization);
    return MaterialApp(
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      //showPerformanceOverlay: true,
      locale: Locale(local),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: ThemeMode.dark,
      darkTheme: darkTheme,
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      initialRoute: PageRouteName
          .intro,
      // الصفحة الافتراضية
      //flag == true ? PageRouteName.homeScreen :
      routes: {
        PageRouteName.intro: (context) => IntroScreen(),
        PageRouteName.startScreen: (context) => StartScreen(),
        PageRouteName.loginScreen: (context) => LoginScreen(),
        PageRouteName.registerScreen: (context) => RegisterScreen(),
        PageRouteName.homeScreen: (context) => HomeScreen(),
        PageRouteName.indexScreen: (context) => const IndexScreen(),
        PageRouteName.calenderScreen: (context) => CalenderScreen(),
        PageRouteName.addScreen: (context) => AddScreen(),
        PageRouteName.foucsScreen: (context) => FoucsScreen(),
        PageRouteName.personScreen: (context) => PersonScreen(),
        PageRouteName.editScreen: (context) => EditSecreen(),
        PageRouteName.addCategoryScreen: (context) => AddCategoryScreen(),
        PageRouteName.appSettings: (context) => SettingsScreen(),
        PageRouteName.colorScreen: (context) => ColorScreen(),
        PageRouteName.fontScreen: (context) => FontScreen(),
        PageRouteName.localizationScreen: (context) => LocalizationScreen()


      },
    );
  }
}
