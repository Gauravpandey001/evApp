import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());
  String? otpCode;
  final String verificationId = Get.arguments[0];
  final String lastFourDigits = Get.arguments[1];
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void verifyOtp(String verificationId, String userOtp) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await auth.signInWithCredential(creds)).user;
      if (user != null) {
        Get.to(HomePage());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        e.message.toString(),
        "Failed",
        colorText: Colors.white,
      );
    }
  }

  void _login() {
    if (otpCode != null) {
      verifyOtp(verificationId, otpCode!);
    } else {
      Get.snackbar(
        "Enter 6-Digit code",
        "Failed",
        colorText: Colors.white,
      );
    }
  }

  Widget buildText(String text, {double fontSize = 18, Color color = Colors.black}) =>
      Center(
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, color: color),
        ),
      );

  Widget buildInputBox(int index) => Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color(0xff2C474A),
      ),
    ),
    child: Center(
      child: TextFormField(
        controller: controllers[index],
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        keyboardType: TextInputType.number,
        // Set the keyboard type to numerical
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) {
            // Handle backspace/delete manually
            if (index > 0) {
              controllers[index - 1].text = '';
              FocusScope.of(context).previousFocus();
            }
          }

          setState(() {
            otpCode = controllers.map((controller) => controller.text).join();
          });
        },
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            for (int i = controllers.length - 1; i >= 0; i--) {
              if (controllers[i].text.isNotEmpty) {
                controllers[i].clear();
                break;
              } else if (i > 0) {
                controllers[i - 1].clear();
                FocusScope.of(context).requestFocus(FocusNode());
                break;
              }
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              buildText('We just sent you an SMS', fontSize: 24),
              buildText(
                  'To login, enter the security code sent to ******$lastFourDigits',
                  fontSize: 14,
                  color: Colors.grey),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                      (index) => buildInputBox(index),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(188, 48),
                  primary: Colors.blueAccent,
                  elevation: 6,
                  textStyle: const TextStyle(fontSize: 14, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}