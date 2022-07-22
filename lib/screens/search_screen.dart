import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/layout_cubit/cubit.dart';
import '../cubit/search_cubit/cubit.dart';
import '../cubit/search_cubit/states.dart';
import '../models/searchVM.dart';


class SearchScreen extends StatelessWidget {
var formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit,SearchStats>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                TextFormField(
                  onFieldSubmitted: (text){
                    SearchCubit.get(context).search(text);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return 'enter text to search';
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(height: 10,),
                if(state is SearchLoadingStats)
                  LinearProgressIndicator(),
                SizedBox(height: 10,),
                if(state is SearchSuccessStats)
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder:(context,index)=>buildFavItem(SearchCubit.get(context).smodel!.data!.data![index],context),
                      separatorBuilder: (context,index)=>Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Container(
                          width: double.infinity,
                          color: Colors.grey[400],
                          height: 1,
                        ),
                      ),
                      itemCount: SearchCubit.get(context).smodel!.data!.data!.length,



                    ),
                  ),

              ],),
            ),
          ),

        );
      },
    );
  }

Widget buildFavItem(Datum model,context){
  return   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 120,
            child: Image(image:
            NetworkImage('${model.image}'),
              width: 120,
              height: 120,

            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.name}',maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.lato(fontSize: 15,fontWeight:FontWeight.w700 ),),
                Spacer(),
                Row(
                  children: [
                    Text('${model.price}',
                      style: GoogleFonts.lato(fontSize: 14,
                          fontWeight:FontWeight.w600 ,
                          color: Colors.blue),),
                    SizedBox(width: 5,),
                    // ignore: unrelated_type_equality_checks

                    Spacer(),
                    IconButton(onPressed: (){
                      ShopCubit.get(context).changFavItem(model.id!);
                    },
                      icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:ShopCubit.get(context).fav[model.id]!?Colors.blue:Colors.grey,
                          child: Icon(Icons.favorite_border,size: 20,color: Colors.white,)),)

                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}

}
