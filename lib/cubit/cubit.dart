import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/cateogries_screen.dart';
import 'package:shop_app/modules/favourites_screen.dart';
import 'package:shop_app/modules/products_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int CurrentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> BottomItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: "Categories",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorite",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];
  void changeIndex(int index) {
    CurrentIndex = index;
    emit(ShopBottomNavStyate());
  }
  HomeModel homeModel;
  void getHomeData()
  {
    emit(ShopLoadingState());
    DioHelper.getData(url: HOME,token:token).then((value)
    {
      homeModel=HomeModel.fromJson(value.data);
      print(homeModel.data.Products[0].image);
      emit(ShopSuccessDataState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(ShopErorrDataState());
    });
  }
}
