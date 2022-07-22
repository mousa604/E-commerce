import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/local/shared_preferences.dart';
import 'login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Model> models =[
    Model(
      image: 'assets/2.jpg',
      title: 'Screen Title 1',
      body: 'Screen Body 1',
    ),
    Model(
      image: 'assets/1.jpg',
      title: 'Screen Title 2',
      body: 'Screen Body 2',
    ),
    Model(
      image: 'assets/3.jpg',
      title: 'Screen Title 3',
      body: 'Screen Body 3',
    ),
  ];
  var border =PageController();
  bool lastpage =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(onPressed: (){
            CatchHelper.saveData(Key: 'OnBording', value: true).then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            });

          }, child: Text('SKIP',style: GoogleFonts.lato(fontSize: 15),))
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index==models.length-1){
                    setState(() {
                      lastpage=true;
                    });
                  }else
                    lastpage=false;
                },
                controller: border,
                physics: BouncingScrollPhysics(),
                 itemCount: 3,
                itemBuilder: (context,index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Image(image: AssetImage('${models[index].image}'))),
                      SizedBox(height: 40,),
                      Text('${models[index].title}',style: GoogleFonts.lato(fontSize: 34)),
                      SizedBox(height: 15,),
                      Text('${models[index].body}',style: GoogleFonts.lato(fontSize: 20)),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                    controller: border,
                    count: models.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.blue,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                      ),
                ),

                FloatingActionButton(onPressed: (){
                  if(lastpage){
                    CatchHelper.saveData(Key: 'OnBording', value: true).then((value) { Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );});


                  }else
                  {
                    border.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                  }
                },child: Icon(Icons.arrow_forward_ios))
              ],
            )
          ],
        ),
      ),

    );
  }
}



class Model{
  final String? title;
  final String? body;
  final String? image;
  Model({this.title,this.body,this.image});
}

