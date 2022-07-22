import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/cubit/register_cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dio_helper/dio_helper.dart';
import '../../models/userVm.dart';


class RegisterCubit extends Cubit<RegisterStats>{
  RegisterCubit() : super(RegisterInitialStats());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  UserVm? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(RegisterLoadinglStats());
    DioHelper.postData(url: 'register',
        data: {
          'name':name,
          'email':email,
          'phone':phone,
          'password':password,
        }
    ).then((value)
    {
      loginModel=UserVm.fromJson(value.data);
      print('${value.data}');
      emit(RegisterSuccessStats(loginModel!));
    }).catchError((error){
      print('${error.toString()}');
      emit(RegisterErrorlStats(error: error.toString()));
    });
  }
  bool isShowePassword =true;
  IconData icon =Icons.visibility;
  void showePassword(){
    isShowePassword=!isShowePassword;
    icon=isShowePassword?Icons.visibility:Icons.visibility_off;
    emit(RegisterShowePasswordlStats());
  }


}