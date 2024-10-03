import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:front_end/features/onboarding/presentation/widget/button.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset('asset/images/6.jpg', height: 300.h)),
            SizedBox(
              height: 40.h,
            ),
            Text(
              'Welcome to J Book Store',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: (Color(0xff800080))),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomButton(
                  wdth: double.infinity,
                  text: 'Sign Up',
                  onTap: () {
                    context.go(AppPath.signup);
                  }),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomButton(
                  wdth: double.infinity,
                  text: 'Sign In',
                  onTap: () {
                    context.go(AppPath.login);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
