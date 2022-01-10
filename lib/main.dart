import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/shop_login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/styles/constants.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:shop_app/shop_layout.dart';
import 'cubit/cubit.dart';
import 'modules/on_boarding_screen.dart';
import 'network/remote/dio_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
   await CacheHelper.init();
  bool onBoarding=CacheHelper.getData(key: "onBoarding");
  token= CacheHelper.getData(key: "token");
  print(token);
  print(onBoarding);
  if(onBoarding==null)
    {
      onBoarding=false;
    }

  runApp( MyApp(onBoarding: onBoarding,token:token));
}
class MyApp extends StatelessWidget {
  final bool onBoarding;
  final String token;
  MyApp({this.onBoarding,this.token});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategories(),
      child:MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: onBoarding?(token!=null?ShopLayout():ShopLoginScreen()):OnBoardingScreen(),),
    );
  }

}