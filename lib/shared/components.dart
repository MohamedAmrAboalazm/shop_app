// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
// @dart=2.9
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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


Widget defaulyFormField(
    {@required IconData  prefixicon,
      @required TextEditingController controller,
      @required TextInputType keyboardtype,
      IconData suffixicon,
      Function onTap,
      bool obscuretext = false,
      bool isClickable = true,
      @required String  labelText,
      @required  Function  validator,
      Function  onChange,
    }) {
  return TextFormField(
    enabled: isClickable,
    onTap: onTap,
    onChanged: onChange,
    controller: controller,
    keyboardType: keyboardtype,
    validator: validator,
    obscureText: obscuretext,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixicon),
      suffixIcon: suffixicon != null ? Icon(suffixicon) : null,
      labelText: labelText,
      border: OutlineInputBorder(),
    ),
  );
}
void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget
    )
);
void navigateAndFinsh(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=> widget,),
        (route) => false);



