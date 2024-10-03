import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardWidget extends StatelessWidget {
  final String mainText;
  final String subText;
  final String image;

  const OnboardWidget({
    super.key,
    required this.image,
    required this.mainText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: Column(
          children: [
            Image.asset(image),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                mainText,
                style: TextStyle(fontSize: 19.sp, color: (Color(0xff800080))),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child:
                  Text(subText, style: TextStyle(color: (Color(0xff800080)))),
            ),
          ],
        ),
      ),
    );
  }
}
