// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shop_app/models/shop_login_screen.dart';
import 'package:shop_app/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  String image;
  String title;
  String body;

  BoardingModel({@required this.image,@required  this.title,@required this.body});
}
class OnBoardingScreen extends StatelessWidget {
  @override
  var boardController=PageController();
  bool isLast=false;
  List<BoardingModel> bording=[
    BoardingModel(image: "assets/images/onboard_1.jpg", title: "On Board 1 Title", body: "On Board 1 Screen"),
    BoardingModel(image: "assets/images/onboard_1.jpg", title: "On Board 2 Title", body: "On Board 2 Screen"),
    BoardingModel(image: "assets/images/onboard_1.jpg", title: "On Board 3 Title", body: "On Board 3 Screen"),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute<void>(builder: (BuildContext context) => ShopLoginScreen()), (route) => false);
          }, child: Text("SKIP"))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children:
        [
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              onPageChanged: (index)
              {
                if(index==bording.length-1)
                {
                  isLast=true;
                }
                else isLast=false;
              },
              controller: boardController,
              itemBuilder: (context, index) => buildBoardingItem(bording[index]),
              itemCount: bording.length,
            ),
          ),
          SizedBox(height: 40,),
          Row(
            children:
            [
              SmoothPageIndicator(
                  controller: boardController,
                  // ignore: prefer_const_constructors
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrange,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 3,
                    spacing: 5,
                  )
                  , count: bording.length),
              Spacer(),
              FloatingActionButton(
                onPressed: (){
                  if(isLast)
                    {
                      navigateAndFinsh(context, ShopLoginScreen());
                    }
                  else {
                    boardController.nextPage(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.fastLinearToSlowEaseIn
                    );
                  }
                },
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          )

        ],),
      )
    );
  }

  Widget buildBoardingItem(BoardingModel bording)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children:
  [
  Expanded(
  child: Image(
  image:AssetImage(bording.image)
  ),
  ),
   SizedBox(height: 30,),
    Text(bording.title,style:TextStyle(fontSize: 24,),),
  SizedBox(
  height: 15,),
  Text(bording.body,style:TextStyle(fontSize: 14),),

  ],);
}
