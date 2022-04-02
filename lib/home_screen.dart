import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height:300,
            width:double.infinity,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(padding:const EdgeInsets.symmetric(horizontal:28),child:ClipRRect(
                borderRadius:BorderRadius.circular(20),
                child: Image.asset("assets/images/welcome.png")
            ),),
          ),
          Container(
            height:60,
            width:double.infinity,
            margin:const EdgeInsets.all(20),
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(20),
            ),
            child:ElevatedButton(
              style:ElevatedButton.styleFrom(
                onPrimary:Colors.white ,
                primary:Colors.deepOrange,
                onSurface:Colors.black87,
                elevation:0,
                shape: RoundedRectangleBorder(
                  borderRadius:BorderRadiusDirectional.circular(10),
                ),
              ),
              onPressed:(){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).push(MaterialPageRoute(builder:(context)=> const LoginScreen()));
              },
              child:const Text("Logout ",style:TextStyle(fontSize:20,fontWeight:FontWeight.w700),),
            ),
          )

        ],
      ),
    );
  }
}
