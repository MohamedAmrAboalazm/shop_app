import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/model_login.dart';
import 'package:shop_app/models/search_model.dart';
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
  CategoriesModel categoriesModel;
  ChangeFavoriteModel changeFavoriteModel;
  FavoriteModel favoriteModel;
  ShopLoginModel userModel;
  SearchModel searchModel;
  Map<int,bool> Favourites={};
  void getHomeData()
  {
    emit(ShopLoadingState());
    DioHelper.getData(url: HOME,token:token).then((value)
    {
      homeModel=HomeModel.fromJson(value.data);
      //print(homeModel.data.Products[0].image);
      homeModel.data.Products.forEach((element) {
        Favourites
            .addAll({element.id:element.in_favorites});
      });
      print(Favourites);
      emit(ShopSuccessHomeDataState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(ShopErorrHomeDataState());
    });
  }
  void getCategories()
  {

    DioHelper.getData(url: GET_CATEGORIES,token:token).then((value)
    {
      categoriesModel=CategoriesModel.fromJson(value.data);
      print(categoriesModel.data.currentPage);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(ShopErorrCategoriesDataState());
    });
  }

  void changeFavourite(int productId,{String text})
  {
    Favourites[productId]= !Favourites[productId];
    //emit(ShopChangeFavoritesDataState());
    DioHelper.postData(url: FAVORITES,data:{"product_id":productId},token: token).then((value)
    {

      changeFavoriteModel=ChangeFavoriteModel.fromJson(value.data);
      print(value.data);
      if(!changeFavoriteModel.status)
        {
          Favourites[productId]= !Favourites[productId];
        }else
          {
            getFavorite();
           if(state is ShopSuccessSearchDataState) {
             getFavorite();
             searchProducts(text: text);
           }
          }
          
      emit(ShopSuccessChangeFavoritesDataState());
    }).catchError((erorr){
      print(erorr);
      Favourites[productId]= !Favourites[productId];
      emit(ShopErorrChangeFavoritesDataState());
    });

  }
  void getFavorite()
  {

    DioHelper.getData(url: FAVORITES,token: token)
        .then((value)  {
          favoriteModel=FavoriteModel.fromJson(value.data);
          print(favoriteModel.data.total);
          emit(ShopSuccessFavoriteDataState());
    }).catchError((erorr){
      print(erorr);
      emit(ShopErorrFavoritesDataState());
    });
  }
  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE,token: token)
        .then((value)  {
      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel.data.email);
      emit(ShopSuccessUserDataState());
    }).catchError((erorr){
      print(erorr);
      emit(ShopErorrUserDataState());
    });
  }
  void updateUserData({@required String name,@required String email,@required String phone})
  {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(url: UPDATE_PROFILE,token: token,
        data:
        {
          "name":name,
          "email":email,
          "phone":phone,
        })
        .then((value)  {
      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel.message);
      emit(ShopSuccessUpdateUserDataState(userModel));
    }).catchError((erorr){
      print(erorr);
      emit(ShopErorrUpdateUserDataState());
    });
  }
  void searchProducts({ String text})
  {
    emit(ShopLoadingSearchDataState());
    DioHelper.postData(url: SEARCHPRODUCTS,token: token,
        data:
        {
          "text":text,
        })
        .then((value)  {
      searchModel=SearchModel.fromJson(value.data);
      print(searchModel.data.data[0].id);
      emit(ShopSuccessSearchDataState());
    }).catchError((erorr){
      print(erorr);
      emit(ShopErorrSearchDataState());
    });
  }

}
