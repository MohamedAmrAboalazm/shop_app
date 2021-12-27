import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salla"),
      ),
      body: TextButton(
        onPressed: (){
          CacheHelper.removeData(key: "token").then((value)
          {
            navigateAndFinsh(context, ShopLoginScreen());
          });

        },
        child: Text("SIGN OUT"),
      ),
    );
  }
}
