import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/components.dart';

class SearchScreen extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
      builder: (context, state) =>
         Scaffold(
           appBar: AppBar(),
           body: Form(
             key: formkey,
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
                 children: [
                   defaultFormField(
                       prefixicon: Icons.search,
                       controller: searchController,
                       keyboardtype: TextInputType.text,
                       labelText: "Search",
                       validator: (String value){
                         if(value.isEmpty)
                         {
                           return "enter text to search";
                         }
                         return null;
                       },
                     submitt:(String text){
                         ShopCubit.get(context).searchProducts(text: text);
                     }
                       ),
                   SizedBox(height: 10,),
                   if(state is ShopLoadingSearchDataState)
                     LinearProgressIndicator(),
                   SizedBox(height: 10,),
                   if(state is ShopSuccessSearchDataState)
                   Expanded(
                     child: ListView.separated(
                       itemBuilder: (context, index) {
                         return
                           buildListProduct(ShopCubit.get(context).searchModel.data.data[index],context,isOldPrice: false,text: searchController.text);
                          },
                       separatorBuilder: (context, index) =>Divider(
                         color: Colors.grey,
                         thickness: .5,
                       ) ,
                       itemCount: ShopCubit.get(context).searchModel.data.data.length,
                     ),
                   )


                 ],
               ),
             ),
           ),
         ),
          );
  }
}