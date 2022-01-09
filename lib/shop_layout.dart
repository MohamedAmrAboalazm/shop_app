import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/search_screen.dart';
import 'package:shop_app/modules/shop_login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Salla"),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.CurrentIndex],
          bottomNavigationBar:BottomNavigationBar(
            onTap: (value)
            {
              cubit.changeIndex(value);
            },
            currentIndex: cubit.CurrentIndex,
            items:cubit.BottomItem,

          ),

        );
      }
    );
  }
}
