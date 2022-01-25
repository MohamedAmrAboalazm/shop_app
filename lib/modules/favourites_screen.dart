import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context, state) {
       if(state is ShopSuccessChangeFavoritesDataState)
       {

         showToast(message: ShopCubit.get(context).changeFavoriteModel.message,state: ToastStates.SUCCES);

       }
     } ,
        builder: (context, state) =>
            ConditionalBuilder(
              condition:state is!ShopLoadingFavoriteDataState,
              builder:(context) => ListView.separated(
                  itemBuilder: (context, index) {
                    return
                      buildListProduct(ShopCubit.get(context).favoriteModel.data.data[index].product,context);},
                  separatorBuilder: (context, index) =>Divider(
                    color: Colors.grey,
                    thickness: .5,
                  ) ,
                  itemCount: ShopCubit.get(context).favoriteModel.data.total
              ) ,
              fallback: (context) => Center(child: CircularProgressIndicator()),

            ), );
  }

}