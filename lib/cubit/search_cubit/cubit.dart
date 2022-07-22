import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/cubit/search_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dio_helper/dio_helper.dart';
import '../../models/searchVM.dart';
import '../../shared/constat.dart';


class SearchCubit extends Cubit<SearchStats>{
  SearchCubit() : super(SearchInitialStats());

  static SearchCubit get(context)=>BlocProvider.of(context);

SearchVm? smodel;
void search(text){
  emit(SearchLoadingStats());
  DioHelper.postData(
      token: token,
      url: 'products/search',
      data: {
    'text':text
      }).then((value) {
        smodel=SearchVm.fromJson(value.data);
      print(smodel!.data!.data!.first.id);
        emit(SearchSuccessStats());
  }).catchError((error){
    emit(SearchErrorStats());
  });
}



}