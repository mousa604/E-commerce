import 'package:ecommerce_app/screens/lay_out.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/on_bording_screen.dart';
import 'package:ecommerce_app/shared/constat.dart';
import 'package:ecommerce_app/shared/local/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'cubit/layout_cubit/cubit.dart';
import 'cubit/layout_cubit/statas.dart';
import 'cubit/login_cubit/cubit.dart';
import 'cubit/register_cubit/cubit.dart';
import 'cubit/search_cubit/cubit.dart';
import 'dio_helper/dio_helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
 await CatchHelper.init();
 // ignore: non_constant_identifier_names
 bool?  OnBording =CatchHelper.getData(Key: 'OnBording');
  token =CatchHelper.getData(Key: 'token');
  print(token.toString());
  Widget widget ;
  if (OnBording!=null ){
    if(token!=null){
      widget =Home();
    }
    else widget = LoginScreen();
  }
  else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(startWidget:widget ,));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
   MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [

          BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getUserData()..getFavData()),
          BlocProvider(create: (context)=>LoginCubit()),
          BlocProvider(create: (context)=>RegisterCubit()),
          BlocProvider(create: (context)=>SearchCubit()),
        ],

        child: BlocConsumer<ShopCubit,ShopStats>(
      listener: (context,state){},
      builder: (context,state){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: startWidget,
        );
      },
    ));
  }

}

