import 'package:flutter/material.dart';
import 'package:verification/components/constant/colors.dart';

class Mybutton extends StatelessWidget {
  final void Function() onpressed;
  final String text;
  final double hieght;
  final double width;
  const Mybutton(
      {super.key,
      required this.onpressed,
      required this.text,
      required this.hieght,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hieght,
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              )),
          onPressed: onpressed,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.buttonTextColor),
          )),
    );
  }
}
