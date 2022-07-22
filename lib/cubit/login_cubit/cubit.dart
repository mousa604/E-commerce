import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/cubit/login_cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dio_helper/dio_helper.dart';
import '../../models/userVm.dart';


class LoginCubit extends Cubit<LoginStats>{
  LoginCubit() : super(LoginInitialStats());

  static LoginCubit get(context)=>BlocProvider.of(context);

UserVm? loginModel;

void userLogin({
 required String email,
  required String password,
}){
  emit(LoginLoadinglStats());
  DioHelper.postData(url: 'login',
      data: {
    'email':email,
    'password':password,
      }
      ).then((value)
  {
    loginModel=UserVm.fromJson(value.data);
    print('${value.data}');
  emit(LoginSuccessStats(loginModel!));
  }).catchError((error){
    print('${error.toString()}');
    emit(LoginErrorlStats(error: error.toString()));
  });
}
 bool isShowePassword =true;
IconData icon =Icons.visibility;
void showePassword(){
  isShowePassword=!isShowePassword;
  icon=isShowePassword?Icons.visibility:Icons.visibility_off;
  emit(LoginShowePasswordlStats());
}


}