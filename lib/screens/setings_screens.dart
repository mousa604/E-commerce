import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/layout_cubit/cubit.dart';
import '../cubit/layout_cubit/statas.dart';
import '../shared/local/shared_preferences.dart';
import 'login_screen.dart';

class SettingScreens extends StatelessWidget {


  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStats>(
      listener: (context,state){},
      builder: (context,state){
        var model =ShopCubit.get(context).userModel;
        nameController.text=model!.data!.name.toString();
        emailController.text=model.data!.email.toString();
        phoneController.text=model.data!.phone.toString();
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(

              children: [
                if(state is LoadingUpdateUserDataStat)
                LinearProgressIndicator(),
                SizedBox(height: 10,),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value){
                    if(value!.isEmpty){
                      return "name must not empty";
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value!.isEmpty){
                      return "email must not empty";
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value){
                    if(value!.isEmpty){
                      return "phone must not empty";
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: MaterialButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        ShopCubit.get(context).updateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text);
                      }
                    },
                    child: Text(
                      'UPDATE',
                      style: GoogleFonts.lato(
                          color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: MaterialButton(
                    onPressed: () {
                      CatchHelper.removeData(Key: 'token').then((value) {
                        if(value){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        }
                      });
                    },
                    child: Text(
                      'LOGOUT',
                      style: GoogleFonts.lato(
                          color: Colors.white, fontSize: 20),
                    ),
                  ),
                )


              ],
            ),
          ),
        );
      },



    );
  }
}
