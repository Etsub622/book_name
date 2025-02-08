import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:front_end/features/onboarding/presentation/widget/button.dart';
import 'package:front_end/features/onboarding/presentation/widget/onboard_widget.dart';
import 'package:go_router/go_router.dart';

class Onboard1 extends StatelessWidget {
  const Onboard1({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        OnboardWidget(
          image: 'asset/images/4.jpg',
          mainText: 'Explore our World of Books',
          subText:
              'Welcome to our app, where books come to life. Discover your next great read from our vast collection.',
        ),
        SizedBox(height: 50.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton(
              text: 'Skip',
              onTap: () {
                context.go(AppPath.login);
              },
            ),
            CustomButton(
              text: 'Next',
              onTap: () {
                context.go(AppPath.onboard2);
              },
            ),
          ],
        )
      ]),
    );
  }
}
