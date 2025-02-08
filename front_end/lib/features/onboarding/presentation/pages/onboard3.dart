import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:front_end/features/onboarding/presentation/widget/button.dart';
import 'package:front_end/features/onboarding/presentation/widget/onboard_widget.dart';
import 'package:go_router/go_router.dart';

class Onboard3 extends StatelessWidget {
  const Onboard3({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        OnboardWidget(
          image: 'asset/images/3.jpg',
          mainText: 'Discounted Vintage Books',
          subText:
              'Dive into our selection of rare and out-of-print books at discounted prices. Uncover literary treasures from the past.',
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
                context.go(AppPath.onboard4);
              },
            ),
          ],
        )
      ]),
    );
  }
}
