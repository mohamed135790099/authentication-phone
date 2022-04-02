
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/opt_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String dialCodeDigits = "+20";
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white54,
        title: const Text(
          "Opt",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                child: Image.asset("assets/images/istockphoto-1221578901-612x612.jpg")
            ),),
          ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                "Phone (OTP) Authentication",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: 400,
              child: CountryCodePicker(
                onChanged: (country) {
                  setState(() {
                    dialCodeDigits = country.dialCode!;
                  });
                },
                initialSelection: "EG",
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                favorite: const ["+1", "US", "+92", "EG", "+20"],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    prefix: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(dialCodeDigits,style:const TextStyle(color:Colors.black),),
                    ),
                    fillColor: Colors.grey.withOpacity(0.4),
                    filled: true,

                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // Padding
                  ), // InputDecoration
                  maxLength: 12,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                )),
            Container(
              height:50,
              width:double.infinity,
              margin:const EdgeInsets.all(20),
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(20),
              ),
              child:ElevatedButton(
                style:ElevatedButton.styleFrom(
                  onPrimary:Colors.white ,
                  primary:Colors.black87,
                    onSurface:Colors.black87,
                    elevation:0,
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadiusDirectional.circular(10),
                    ),
                ),
                onPressed:(){
                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=> OPTController(phone:_controller.text,codeDigits: dialCodeDigits,),));
                },
                child:const Text("Next",style:TextStyle(fontSize:20,fontWeight:FontWeight.w700),),
              ),
            )

          ],
        ),
      ),
    ));
  }
}
