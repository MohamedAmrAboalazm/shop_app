// ignore_for_file: prefer_const_constructors
// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'colors.dart';


ThemeData darkTheme=ThemeData(
  fontFamily: 'PTS',
    textTheme: TextTheme(
        bodyText1:TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        )
    ),
    scaffoldBackgroundColor: HexColor('333739'),
    primarySwatch: defaultColor,
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor:HexColor('333739') ,
      elevation: 25,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme:  AppBarTheme(
        titleSpacing: 20,
        iconTheme: IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:  HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
        backgroundColor:  HexColor('333739'),
        elevation: 0
    )

);
ThemeData lightTheme=ThemeData(
  fontFamily: 'PTS',
    textTheme: TextTheme(
        bodyText1:TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        )
    ),
    primarySwatch: defaultColor,
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor:Colors.white ,
      elevation: 25,
      type: BottomNavigationBarType.fixed,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:  AppBarTheme(
        titleSpacing: 20,
        iconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        elevation: 0
    )
);
