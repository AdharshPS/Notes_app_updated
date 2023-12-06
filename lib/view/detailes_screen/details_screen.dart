import 'package:flutter/material.dart';
import 'package:hive_with_adapter_class/utils/color_constant/color_constant.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({
    super.key,
    required this.bgColor,
    required this.title,
    required this.des,
  });

  final Color bgColor;
  String title;
  String des;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: ColorConstant.titleColor,
          ),
        ),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 90,
          child: Text(
            des,
            style: TextStyle(
              fontSize: 16,
              color: ColorConstant.titleColor,
            ),
          ),
        ),
      ),
    );
  }
}
