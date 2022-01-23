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
                      buildFavouriteItem(ShopCubit.get(context).favoriteModel.data.data[index].product,context);},
                  separatorBuilder: (context, index) =>Divider(
                    color: Colors.grey,
                    thickness: .5,
                  ) ,
                  itemCount: ShopCubit.get(context).favoriteModel.data.total
              ) ,
              fallback: (context) => Center(child: CircularProgressIndicator()),

            ), );
  }
  Widget buildFavouriteItem(Product model,context)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                        model.image),
                    width: 120,
                    height: 120,
                  ),
                   if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    // ignore: prefer_const_constructors
                    child: Text(
                      'DISCOUNT',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                      Text(
                        model.oldPrice.toString(),
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavourite(model.id);
                          },
                          icon: CircleAvatar(
                              radius: 15,
                              backgroundColor:ShopCubit.get(context).Favourites[model.id]?defaultColor:Colors.grey,
                              // ignore: prefer_const_constructors
                              child: Icon(
                                Icons.favorite_border,
                                size: 14,
                                color: Colors.white,
                              ))),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}