import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:uber_app/home_screen.dart';

class OPTController extends StatefulWidget {
  final String phone;
  final String codeDigits;

  const OPTController({Key? key, required this.phone, required this.codeDigits})
      : super(key: key);

  @override
  State<OPTController> createState() => _OPTControllerState();
}

class _OPTControllerState extends State<OPTController> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController pinoTPCodeController = TextEditingController();
  final FocusNode pinoTPCodeFocus = FocusNode();
  String? verificationCode;
  final BoxDecoration pinoTPCodeDecoration = BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.grey,
      ) // Border.all
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhoneNumber();
  } //

  void verifyPhoneNumber() {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.codeDigits + widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else {
            FocusScope.of(context).unfocus();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Invalid Opt"),
              duration: Duration(seconds: 3),
            ));
          }
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text(authException.message.toString()),
          duration: const Duration(seconds: 15),
        ));
      },
      codeSent: (String vID, int? reasonToken) {
        setState(() {
          setState(() {
            verificationCode = vID;
          });
        });
      },
      codeAutoRetrievalTimeout: (String vID) {
        setState(() {
          verificationCode = vID;
        });
      },
      timeout: const Duration(seconds: 60),
    );
  } // BoxDecoration

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('OTP Verification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 300,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/otp.jpg',
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Verification",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Enter the code sent to the number",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    verifyPhoneNumber();
                  },
                  child: Text(
                    "${widget.codeDigits} ${widget.phone}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ), // Text
                ), // GestureDetector
              ), // Center
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Pinput(
                length: 6,
                showCursor: true,
                controller: pinoTPCodeController,
                focusNode: pinoTPCodeFocus,
                onSubmitted: (pin) async {
                  try {
                    FirebaseAuth.instance
                        .signInWithCredential(
                      PhoneAuthProvider.credential(
                          verificationId: verificationCode!, smsCode: pin),
                    ).then((value) {
                      if (value.user != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Invalid Opt"),
                      duration: Duration(seconds: 10),
                    ));
                  }
                },
                pinAnimationType: PinAnimationType.rotation,
              ),
            ), // Container
          ],
        ),
      ),
    ));
  }
}
