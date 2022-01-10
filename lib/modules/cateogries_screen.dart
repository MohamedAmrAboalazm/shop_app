import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state){},
      builder:(context, state) => ListView.separated(
          itemBuilder: (context, index) =>buildCardItem(ShopCubit.get(context).categoriesModel.data.data[index]) ,
          separatorBuilder: (context, index) =>Divider(
            color: Colors.grey,
            thickness: .5,
          ),
          itemCount: ShopCubit.get(context).categoriesModel.data.data.length),

    );
  }

  Widget buildCardItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(children: [
      Image(image: NetworkImage(model.image),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      SizedBox(width: 20,),
      Text(model.name,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
      Spacer(),
      Icon(Icons.arrow_forward_ios),

    ],),
  );
}