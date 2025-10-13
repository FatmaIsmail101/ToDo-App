import 'package:flutter/material.dart';
import 'package:up_todo_app/feature/authenticaton/login/presentation/view/login_screen.dart';
import 'package:up_todo_app/feature/intro/presentation/intro_screen.dart';
import 'package:up_todo_app/feature/intro/presentation/start_screen.dart';
import 'page_route_name.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
  case PageRouteName.intro:
  return MaterialPageRoute(builder: (_) => IntroScreen());

  case PageRouteName.startScreen:
  return MaterialPageRoute(builder: (_) => StartScreen());
    case PageRouteName.loginScreen:
      return MaterialPageRoute(builder: (_) => LoginScreen());


  default:
  // route غير معروف
  return MaterialPageRoute(builder: (_) => IntroScreen());
  }
}