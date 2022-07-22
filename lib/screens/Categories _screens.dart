import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/layout_cubit/cubit.dart';
import '../cubit/layout_cubit/statas.dart';
import '../models/categoriesVM.dart';


class CategoriesScreens extends StatelessWidget {
  const CategoriesScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStats>(
     listener: (context,state){},
     builder: (context,state){
       return ListView.separated(
         physics: BouncingScrollPhysics(),
         itemBuilder:(context,index)=>catItem(ShopCubit.get(context).categoriesModel!.data!.data![index]),
           separatorBuilder: (context,index)=>Padding(
             padding: const EdgeInsets.only(left: 40),
             child: Container(
               width: double.infinity,
               color: Colors.grey[400],
               height: 1,
             ),
           ),
           itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length,



       );
     },


    ) ;
  }

  Widget catItem(Datum model){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(children: [
        Image(image: NetworkImage('${model.image}'),height: 120,width: 120,fit: BoxFit.cover,),
        SizedBox(width: 15,),
        Text('${model.name}',style: GoogleFonts.lato(fontSize: 20,),maxLines: 1,overflow: TextOverflow.ellipsis,),
        Spacer(),
        IconButton(onPressed: (){}, icon:Icon( Icons.arrow_forward_ios))
      ],),
    );
  }
}
