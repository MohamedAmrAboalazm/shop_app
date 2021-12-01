import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home:
      OnBoardingScreen(),);
  }
}