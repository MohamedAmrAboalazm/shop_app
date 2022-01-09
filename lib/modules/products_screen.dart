import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
         builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel!=null,
              builder:(context) =>ProductsBuilder(ShopCubit.get(context).homeModel) ,
               fallback: (context) => Center(child: CircularProgressIndicator()),);
         },

    );
  }

  Widget ProductsBuilder(HomeModel model)=>
      Column(
        children: [
          CarouselSlider(
              items: model.data.banners.map((e) => Image(
                image: NetworkImage(e.image),
                width: double.infinity,
                fit: BoxFit.cover,)
              ).toList(),
              options:CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay:true,
                viewportFraction: 1,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal
              )
          ),
        ],
      );
}
