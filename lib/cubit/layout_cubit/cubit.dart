import 'package:dio/dio.dart';
import 'package:ecommerce_app/cubit/layout_cubit/statas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dio_helper/dio_helper.dart';
import '../../models/categoriesVM.dart';
import '../../models/changefavVM.dart';
import '../../models/favVM.dart';
import '../../models/homeVm.dart';
import '../../models/userVm.dart';
import '../../screens/Categories _screens.dart';
import '../../screens/Products_screen.dart';
import '../../screens/favorite_screen.dart';
import '../../screens/setings_screens.dart';
import '../../shared/constat.dart';


class ShopCubit extends Cubit<ShopStats> {
  ShopCubit() : super(InitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List screens = [
    ProductsScreens(),
    CategoriesScreens(),
    FavoriteScreens(),
    SettingScreens(),
  ];
  List<BottomNavigationBarItem> items=[
    BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
    BottomNavigationBarItem(icon: Icon(Icons.category_outlined),label: 'Categories',),
    BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite',),
    BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Setting',),
  ];

  int currentIndex =0;

  void changeBouttomBar(index){
    currentIndex =index;
    emit(BottomNavBarState());
  }
  HomeVm? homeModel;
  Map<int,bool> fav={};
  void getHomeData(){
    emit(HomeLoadingStats());
   DioHelper.getData(url: 'home',token: token).then((value) {
     homeModel =HomeVm.fromJson(value.data);
     homeModel!.data!.products!.forEach((element) {
       fav.addAll({element.id!:element.inFavorites!});
     });
     print(fav.toString());
     emit(HomeSuccessStat());
   }
   ).catchError((error){
     print(error.toString());
     emit(HomeErrorStat());
   });
  }


  CategoriesVm? categoriesModel;
  void getCategoriesData(){

    DioHelper.getData(url: 'categories',).then((value) {
      categoriesModel =CategoriesVm.fromJson(value.data);
      emit(CategoriesSuccessStat());
    }
    ).catchError((error){
      print(error.toString());
      emit(CategoriesErrorStat());
    });
  }
  ChangeFavVm ?changeFavModel;

  void changFavItem( id){
    fav[id]=!fav[id]!;
    emit(FavSuccessStat(changeFavModel));
    DioHelper.postData(
        url: 'favorites',
        data: {
          'product_id':id
        },
        token: token
    ).then((value){
      changeFavModel =ChangeFavVm.fromJson(value.data);
      if(!changeFavModel!.status!){
        fav[id] =  !fav[id]!;
      }else{
        getFavData();
      }
      print(value.data);
      emit(ChangeFavSuccessStat());
    }).catchError((error){

      emit(ChangeFavErrorStat());
      print(error.toString());});
  }



  FavVm? favModel;
  void getFavData(){

    emit(LoadingGatFavErrorStat());

    DioHelper.getData(url: 'favorites',token: token).then((value) {
      favModel =FavVm.fromJson(value.data);
      print(favModel!.data!.data!.first.product!.name.toString());
      emit(GetFavSuccessStat());
    }
    ).catchError((error){
      print(error.toString());
      emit(GatFavErrorStat());
    });
  }


  UserVm? userModel;
  void getUserData(){
 emit((LoadingUserDataStat()));
    DioHelper.getData(url: 'profile',token: token).then((value) {
      userModel =UserVm.fromJson(value.data);
      emit(UserDataSuccessStat());
    }
    ).catchError((error){
      print(error.toString());
      emit(UserDataErrorStat());
    });
  }



  void updateUserData({
  required String name,
  required String email,
  required String phone,
}){
    emit((LoadingUpdateUserDataStat()));
    DioHelper.putData(url: 'update-profile',token: token, data: {
      'name':name,
      'email':email,
      'phone':phone,
    }).then((value) {
      userModel =UserVm.fromJson(value.data);
      emit(UpdateUserDataSuccessStat(userModel));
    }
    ).catchError((error){
      print(error.toString());
      emit(UpdateUserDataErrorStat());
    });
  }
}