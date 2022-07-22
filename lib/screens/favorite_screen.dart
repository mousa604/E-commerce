import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/layout_cubit/cubit.dart';
import '../cubit/layout_cubit/statas.dart';
import '../models/favVM.dart';

class FavoriteScreens extends StatelessWidget {
  const FavoriteScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStats>(
      listener: (context,state){},
      builder: (context,state){
        return Conditional.single(
          widgetBuilder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context,index)=>buildFavItem(ShopCubit.get(context).favModel!.data!.data![index],context),
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Container(
                width: double.infinity,
                color: Colors.grey[400],
                height: 1,
              ),
            ),
            itemCount: ShopCubit.get(context).favModel!.data!.data!.length,



          ),
          fallbackBuilder: ( context) =>Center(child: CircularProgressIndicator()),
          context: context,
          conditionBuilder:(context)=> state is! LoadingGatFavErrorStat,
        );
      },


    ) ;
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
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(image:
                  NetworkImage('${model.product!.image}'),
                    width: 120,
                    height: 120,

                  ),
                  if(model.product!.discount !=0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red,
                      child: Text('DISCOUNT',style: GoogleFonts.lato(color: Colors.white,fontSize: 12),),
                    )

                ],
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${model.product!.name}',maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.lato(fontSize: 15,fontWeight:FontWeight.w700 ),),
                  Spacer(),
                  Row(
                    children: [
                      Text('${model.product!.price}',
                        style: GoogleFonts.lato(fontSize: 14,
                            fontWeight:FontWeight.w600 ,
                            color: Colors.blue),),
                      SizedBox(width: 5,),
                      // ignore: unrelated_type_equality_checks
                      if(model.product!.discount!=0)
                        Text('${model.product!.oldPrice}',
                          style: GoogleFonts.lato(fontSize: 14,
                              fontWeight:FontWeight.w600 ,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                          ),

                        ),
                      Spacer(),
                      IconButton(onPressed: (){
                        ShopCubit.get(context).changFavItem(model.product!.id);
                      },
                        icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:ShopCubit.get(context).fav[model.product!.id]!?Colors.blue:Colors.grey,
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
