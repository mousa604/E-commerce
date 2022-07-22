import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_screen.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List model =[
    '1','2','3'
  ];
  var border =PageController();
  bool last =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(

              controller: border,
                 onPageChanged: (index){
                if(index==model.length-1){
                  setState(() {
                    last =true;
                  });
                }else
                  setState(() {
                    last=false;
                  });
                 },
                itemBuilder: (context,index){
                  return Container(
                    child: Center(child: Text('${model[index]}')),
                  );
                },
                itemCount: 3,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothPageIndicator(controller: border, count: 3,effect: ExpandingDotsEffect(dotWidth: 10,expansionFactor: 4,dotHeight: 10,activeDotColor: Colors.deepOrange,dotColor: Colors.grey),),
              FloatingActionButton(
                onPressed: (){
                  if(last){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                  else{
                    border.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                  }
                },

                child: Icon(Icons.arrow_forward_ios),),
            ],
          )
        ],
      ),
    );
  }
}
