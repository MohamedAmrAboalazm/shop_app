import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit_login/cubit.dart';
import 'package:shop_app/cubit_login/states.dart';
import 'package:shop_app/modules/shop_login_screen.dart';
import 'package:shop_app/shared/components.dart';


class RegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var namecontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
          listener: (context, state) {
            if(state is ShopRegisterSucessState)
            {
              if(state.register.status)
              {
                print(state.register.message);

                  navigateAndFinsh(context, ShopLoginScreen());

              }
              else
              {
                print(state.register.message);
                showToast(message: state.register.message,state:ToastStates.ERORR);
              }




            }

          },
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
                        Text("REGISTER",style:
                        Theme.of(context)
                            .textTheme.headline4.copyWith(color:Colors.black),),
                        SizedBox(height: 10,),
                        Text("Register now to browse our hot offers",
                          style: Theme.of(context).textTheme.bodyText1
                              .copyWith(color: Colors.grey),),
                        SizedBox(height: 30,),
                        defaultFormField(
                            prefixicon: Icons.person,
                            controller: namecontroller,
                            keyboardtype: TextInputType.name,
                            labelText: 'User Name',
                            submitt: (value){
                              if(formKey.currentState.validate())
                              {
                                ShopLoginCubit.get(context)
                                    .userRegister(name: namecontroller.text,phone: phonecontroller.text,email: emailcontroller.text, password: passwordcontroller.text);
                              }
                            },
                            validator: (String value){
                              if(value.isEmpty)
                              {
                                return "please enter your name";
                              }
                              return null;
                            }),
                        SizedBox(height: 15,),
                        defaultFormField(
                            prefixicon: Icons.email,
                            controller: emailcontroller,
                            keyboardtype: TextInputType.emailAddress,
                            labelText: 'Email Address',
                            submitt: (value){
                              if(formKey.currentState.validate())
                              {
                                ShopLoginCubit.get(context)
                                    .userRegister(name: namecontroller.text,phone: phonecontroller.text,email: emailcontroller.text, password: passwordcontroller.text);
                              }
                            },
                            validator: (String value){
                              if(value.isEmpty)
                              {
                                return "please enter your email address";
                              }
                              return null;
                            }),
                        SizedBox(height: 15,),
                        defaultFormField(

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
                                    .userRegister(name: namecontroller.text,phone: phonecontroller.text,email: emailcontroller.text, password: passwordcontroller.text);
                              }
                            },
                            validator: (String value){
                              if(value.isEmpty)
                              {
                                return "please enter your password ";
                              }
                              return null;
                            }),
                        SizedBox(height: 15,),
                        defaultFormField(

                            prefixicon: Icons.phone,
                            controller: phonecontroller,
                            keyboardtype: TextInputType.number,
                            labelText: 'phone',
                            submitt: (value){
                              if(formKey.currentState.validate())
                              {
                                ShopLoginCubit.get(context)
                                    .userRegister(name: namecontroller.text,phone: phonecontroller.text,email: emailcontroller.text, password: passwordcontroller.text);
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
                          condition: state is! ShopRegisterLoadingState,
                          builder:(context) => defaultButton(text:"Rigester" ,onPressed: (){
                            if(formKey.currentState.validate())
                            {
                              ShopLoginCubit.get(context)
                                  .userRegister(name: namecontroller.text,phone: phonecontroller.text,email: emailcontroller.text, password: passwordcontroller.text);

                            }

                          }) ,
                          fallback:(context) => Center(child: CircularProgressIndicator()) ,
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Do have an account?'),
                            TextButton(onPressed: (){
                              navigateTo(context, ShopLoginScreen());
                            }, child:Text("Login Now") )

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
