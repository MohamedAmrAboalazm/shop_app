import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit_login/states.dart';
import 'package:shop_app/models/model_login.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';


class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel loginModel;

  void userLogin({@required String email,@required String password})
  {
    emit(ShopLoginLoadingState());
   DioHelper.postData(url:LOGIN
       , data:
       {
         "email":email,
         "password":password
       }).then((value){
     loginModel=ShopLoginModel.fromJson(value.data);
       emit(ShopLoginSucessState(loginModel));
   }

   ).catchError((e){
     print(e.toString());
     emit(ShopLoginErorrState(e.toString()));
   });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());

  }
}