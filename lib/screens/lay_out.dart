import 'package:ecommerce_app/screens/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../cubit/layout_cubit/cubit.dart';
import '../cubit/layout_cubit/statas.dart';
import 'login_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategoriesData()..getFavData()..getUserData(),
      child: BlocConsumer<ShopCubit,ShopStats>(
        listener: (context ,stats){},
        builder: (context,stats){
          var cubit =ShopCubit.get(context);
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                }, icon: Icon(Icons.search,color: Colors.grey,)),


              ],
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text('salla',style: TextStyle(color: Colors.black),),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              onTap: (index){
                   cubit.changeBouttomBar(index);
              },
              currentIndex: cubit.currentIndex,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,

            ),

          );
        },
      ),
    );
  }
}
