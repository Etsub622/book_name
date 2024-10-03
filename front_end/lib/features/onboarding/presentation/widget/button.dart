import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double wdth;
  final void Function() onTap;
  const CustomButton(
      {super.key, required this.text, required this.onTap, this.wdth = 120});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: wdth.w,
        height: 55.h,
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(text),
        ),
      ),
    );
  }
}
