

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/layout_cubit/cubit.dart';
import '../cubit/layout_cubit/statas.dart';
import '../models/categoriesVM.dart';
import '../models/homeVm.dart';

class ProductsScreens extends StatelessWidget {
  const ProductsScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStats>(
    listener: (context,state){
    },
    builder: (context,state){
      return  Conditional.single(
          fallbackBuilder: (BuildContext context) =>Center(child: CircularProgressIndicator()),
          conditionBuilder:(BuildContext context) => ShopCubit.get(context).homeModel!=null  && ShopCubit.get(context).categoriesModel!=null,
          context: context,
          widgetBuilder: (BuildContext context) {
            return productBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context) ;
          }
      );
    },
    );
  }

  Widget productBuilder(HomeVm ?model ,CategoriesVm ?cmodel,context){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          CarouselSlider(items: model!.data!.banners!.map((e) => Image(image: NetworkImage('${e.image}'),fit: BoxFit.cover,width: double.infinity,) ).toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',style: GoogleFonts.lato(fontSize: 25,fontWeight: FontWeight.w700),),
                SizedBox(height: 5,),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=>catItem(cmodel!.data!.data![index]),
                      separatorBuilder:(context,index){
                        return SizedBox(width: 10,);
                      },
                      itemCount: cmodel!.data!.data!.length),
                ),
                SizedBox(height: 40,),
                Text('New Products',style: GoogleFonts.lato(fontSize: 25,fontWeight: FontWeight.w600),),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(

           color: Colors.grey[300],
            child: GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1/1.55,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(model.data!.products!.length, (index) =>buildGridItem(model.data!.products![index],context)),
            ),
          ),
        ]
      ),
    );
  }
  Widget buildGridItem(Product model,context){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image:
            NetworkImage('${model.image}'),
            width: double.infinity,
            height: 200,

            ),
            if(model.discount !=0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text('DISCOUNT',style: GoogleFonts.lato(color: Colors.white,fontSize: 12),),
              )

          ],
        ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.name}',maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.lato(fontSize: 15,fontWeight:FontWeight.w700 ),),
                Row(
                  children: [
                    Text('${model.price!.round()}',
                      style: GoogleFonts.lato(fontSize: 14,
                          fontWeight:FontWeight.w600 ,
                          color: Colors.blue),),
                    SizedBox(width: 5,),
                    // ignore: unrelated_type_equality_checks
                    if(model.discount !=0)
                      Text('${model.oldPrice!.round()}',
                        style: GoogleFonts.lato(fontSize: 14,
                            fontWeight:FontWeight.w600 ,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),

                      ),
                    Spacer(),
                    IconButton(onPressed: (){
                      ShopCubit.get(context).changFavItem(model.id!);
                    },
                      icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: ShopCubit.get(context).fav[model.id]!?Colors.blue:Colors.grey,
                          child: Icon(Icons.favorite_border,size: 20,color: Colors.white,)),)
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget catItem(Datum model){
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(image: NetworkImage('${model.image}'),height: 100,width: 100,fit: BoxFit.cover),
          Container(
            width: double.infinity,

            color: Colors.black.withOpacity(.7),
            child: Text(
              '${model.name}',textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                  fontSize: 20,color: Colors.white),
            ),
          ),
        ],),
    );
  }
}
