import 'package:flutter/material.dart';
import 'package:hive_with_adapter_class/utils/color_constant/color_constant.dart';
import 'package:hive_with_adapter_class/view/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then(
      (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          )),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bottomSheet,
      body: Center(
        child: Text(
          "NOTES",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: ColorConstant.titleColor,
          ),
        ),
      ),
    );
  }
}
