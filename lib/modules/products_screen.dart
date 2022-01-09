import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
         builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel!=null,
              builder:(context) =>builderWidget(ShopCubit.get(context).homeModel) ,
               fallback: (context) => Center(child: CircularProgressIndicator()),);
         },

    );
  }

  Widget builderWidget (HomeModel model)=>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
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
            SizedBox(height: 10,),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                 shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1/1.52,
                  crossAxisCount: 2,
                  children:List.generate(model.data.Products.length, (index) =>buildGridProduct(model.data.Products[index]) )
              ),
            ),
          ],
        ),
      );
  Widget buildGridProduct(ProductsModel productsModel)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [

            Image(
              image: NetworkImage(productsModel.image),
              width: double.infinity,
              height: 200,
            ),
            if(productsModel.discount!=0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.red,
             child: Text('DISCOUNT',
               style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),
             ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  productsModel.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                height: 36,
              ),
              Row(children: [
                Text(
                  productsModel.price.round().toString(),
                  style:TextStyle(
                    fontSize: 12,
                    color: defaultColor,

                  ),
                ),
                SizedBox(width: 5,),
                if(productsModel.discount!=0)
                Text(
                  productsModel.old_price.round().toString(),
                  // ignore: prefer_const_constructors
                  style:TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough

                  ),
                ),
                Spacer(),
                IconButton(onPressed: (){
                }, icon:Icon(Icons.favorite_border)),
              ],),
            ],
          ),
        )


      ],
    ),
  );
}
