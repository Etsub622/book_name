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
        height: 53.h,
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              )),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 94, 73, 62),
          ),
        ),
      ),
    );
  }
}
