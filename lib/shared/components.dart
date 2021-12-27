// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/model_login.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget buildArticleItem(article,context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(
                '${article["urlToImage"]}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  style:Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      )
    ],
  ),
);

Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
  condition: list.length>0 ,
  builder: (context)=>
      ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>buildArticleItem(list[index],context),
          separatorBuilder:(context, index) => Container(
            width:double.infinity,
            height: 1,
            color: Colors.grey[300],),
          itemCount:list.length),
  fallback:(context)=>isSearch ? Container(): Center(child: CircularProgressIndicator())
  ,);


Widget defaultFormField(
    {@required IconData  prefixicon,
      @required TextEditingController controller,
      @required TextInputType keyboardtype,
      IconData suffixicon,
      Function onTap,
      bool obscuretext = false,
      bool isClickable = true,
      @required String  labelText,
      @required  Function  validator,
      Function  submitt,
      Function  onChange,
      Function  suffixPressed,

    }) {
  return TextFormField(
    onFieldSubmitted: submitt,
    enabled: isClickable,
    onTap: onTap,
    onChanged: onChange,
    controller: controller,
    keyboardType: keyboardtype,
    validator: validator,
    obscureText: obscuretext,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixicon),
      suffixIcon: suffixicon != null ?IconButton(onPressed:suffixPressed,icon: Icon(suffixicon)) : null,
      labelText: labelText,
      border: OutlineInputBorder(),
    ),
  );
}
Widget defaultButton({String text,Function onPressed,})=>Container(
  width: double.infinity,
  decoration: BoxDecoration(
    color: defaultColor,
    borderRadius: BorderRadius.circular(5),
  ),
  child: MaterialButton(
      onPressed: onPressed,
    child: Text(text.toUpperCase(),style:TextStyle(color: Colors.white),),
  ),
);
void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget
    )
);
void navigateAndFinsh(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=> widget,),
        (route) => false);
void showToast({@required String message,ToastStates state}){
  Fluttertoast.showToast(
      msg:message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor:chosseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );

}
   enum ToastStates {SUCCES,ERORR,WARNING}
   Color chosseToastColor(ToastStates state)
   {
     Color color;
     switch(state)
     {
       case ToastStates.SUCCES:
         color=Colors.green;
          break;
       case ToastStates.ERORR:
         color=Colors.red;
         break;
       case ToastStates.WARNING:
         color=Colors.amber;
         break;
     }
     return color;


   }




