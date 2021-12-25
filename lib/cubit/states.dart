import 'package:shop_app/models/model_login.dart';

abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginSucessState extends ShopLoginState{
 final ShopLoginModel loginModel;

 ShopLoginSucessState(this.loginModel);
}

class ShopChangePasswordVisibilityState extends ShopLoginState{}

class ShopLoginErorrState extends ShopLoginState
{
 final String erorr;
 ShopLoginErorrState(this.erorr);
}

