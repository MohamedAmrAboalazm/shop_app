abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginSucessState extends ShopLoginState{}

class ShopChangePasswordVisibilityState extends ShopLoginState{}

class ShopLoginErorrState extends ShopLoginState
{
 final String erorr;
 ShopLoginErorrState(this.erorr);
}

