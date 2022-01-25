import 'package:shop_app/models/model_login.dart';

abstract class ShopStates{
  Object get updateData => null;
}

class ShopInitialState extends ShopStates{}

class ShopBottomNavStyate extends ShopStates{}

class ShopLoadingState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErorrHomeDataState extends ShopStates{}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErorrCategoriesDataState extends ShopStates{}

class ShopSuccessChangeFavoritesDataState extends ShopStates{}

class ShopChangeFavoritesDataState extends ShopStates{}

class ShopErorrChangeFavoritesDataState extends ShopStates{}

class ShopSuccessFavoriteDataState extends ShopStates{}

class ShopLoadingFavoriteDataState extends ShopStates{}

class ShopErorrFavoritesDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

 class ShopErorrUserDataState extends ShopStates{}

class ShopSuccessUpdateUserDataState extends ShopStates{
 final ShopLoginModel updateData;

 ShopSuccessUpdateUserDataState(this.updateData);
}

class ShopLoadingUpdateUserDataState extends ShopStates{}

class ShopErorrUpdateUserDataState extends ShopStates{}

class ShopSuccessSearchDataState extends ShopStates{}

class ShopLoadingSearchDataState extends ShopStates{}

class ShopErorrSearchDataState extends ShopStates{}