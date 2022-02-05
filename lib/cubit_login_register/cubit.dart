import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit_login_register/states.dart';
import 'package:shop_app/models/model_login.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';


class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel loginModel;
  ShopLoginModel RegisterModel;

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
  void userRegister({@required String name,@required String email,@required String password,@required String phone})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url:REGISTER
        , data:
        {
          "name":name,
          "email":email,
          "password":password,
          "phone":phone
        }).then((value){
      RegisterModel=ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSucessState(RegisterModel));
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