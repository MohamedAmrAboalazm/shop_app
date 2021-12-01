import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_register_screen.dart';
import 'package:shop_app/shared/components.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar:AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text("Login",style:
                      Theme.of(context)
                          .textTheme.headline4.copyWith(color:Colors.black),),
                      SizedBox(height: 10,),
                      Text("Login now to browse our hot offers",
                        style: Theme.of(context).textTheme.bodyText1
                            .copyWith(color: Colors.grey),),
                      SizedBox(height: 30,),
                      defaulyFormField(
                          prefixicon: Icons.email,
                          controller: emailcontroller,
                          keyboardtype: TextInputType.emailAddress,
                          labelText: 'Email Address',
                          validator: (String value){
                            if(value.isEmpty)
                            {
                              return "please enter your email address";
                            }
                            return null;
                          }),
                      SizedBox(height: 15,),
                      defaulyFormField(

                          prefixicon: Icons.lock_outline,
                          suffixicon: ShopLoginCubit.get(context).suffix,
                          controller: passwordcontroller,
                          keyboardtype: TextInputType.visiblePassword,
                          labelText: 'Password',
                          obscuretext: ShopLoginCubit.get(context).isPassword,
                          suffixPressed:()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          submitt: (value){
                            if(formKey.currentState.validate())
                            {
                              ShopLoginCubit.get(context)
                                  .userLogin(email: emailcontroller.text, password: passwordcontroller.text);
                            }
                          },
                          validator: (String value){
                            if(value.isEmpty)
                            {
                              return "please enter your password ";
                            }
                            return null;
                          }),
                      SizedBox(height: 30,),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder:(context) => defaultButton(text:"Login" ,onPressed: (){
                          if(formKey.currentState.validate())
                            {
                              ShopLoginCubit.get(context)
                                  .userLogin(email: emailcontroller.text, password: passwordcontroller.text);
                            }

                        }) ,
                        fallback:(context) => Center(child: CircularProgressIndicator()) ,
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Don\'t have an account?'),
                          TextButton(onPressed: (){
                            navigateTo(context, RegisterScreen());
                          }, child:Text("Register Now") )

                        ],),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
