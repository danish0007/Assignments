import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SDSplashScreen extends StatelessWidget {
  static String id = 'splash_screen';
  const SDSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SizedBox(
          height: 40.h,
          width: 80.w,
          child: Image.network(
            'https://stockdaddy.in/images/logo-white.png',
          ),
        ),
      ),
    );
  }
}
