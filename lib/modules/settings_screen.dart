import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/model_login.dart';
import 'package:shop_app/shared/components.dart';

class SettingsScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
         listener: (context, state) {},
        builder: (context, state)
        {
          var model=ShopCubit.get(context).userModel;
          nameController.text =model.data.name;
          emailController.text=model.data.email;
          phoneController.text=model.data.phone;
          return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel!=null,
            builder: (context) =>Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                      prefixicon: Icons.person,
                      controller: nameController,
                      keyboardtype: TextInputType.name,
                      labelText: "Name",
                      validator: (String value){
                        if(value.isEmpty)
                        {
                          return "name must not be empty";
                        }
                        return null;
                      }),
                  SizedBox(height: 20,),
                  defaultFormField(
                      prefixicon: Icons.email,
                      controller: emailController,
                      keyboardtype: TextInputType.emailAddress,
                      labelText: "Email Address",
                      validator: (String value){
                        if(value.isEmpty)
                        {
                          return "email must not be empty";
                        }
                        return null;
                      }),
                  SizedBox(height: 20,),
                  defaultFormField(
                      prefixicon: Icons.phone,
                      controller: phoneController,
                      keyboardtype: TextInputType.phone,
                      labelText:"Phone",
                      validator: (String value){
                        if(value.isEmpty)
                        {
                          return "phone must not be empty";
                        }
                        return null;
                      }),
                  SizedBox(height: 20,),
                  defaultButton(onPressed: (){
                    signOut(context);
                  },text: "Logout")

                ],
              ),
            ),
           fallback:(context) =>  Center(child: CircularProgressIndicator()),);

        },
    );
  }




}