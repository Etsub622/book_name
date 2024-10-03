import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:front_end/features/onboarding/presentation/widget/button.dart';
import 'package:front_end/features/onboarding/presentation/widget/onboard_widget.dart';
import 'package:go_router/go_router.dart';

class Onboard4 extends StatelessWidget {
  const Onboard4({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            OnboardWidget(
              image: 'asset/images/1.jpg',
              mainText: 'Seamless Purchasing & Reading',
              subText:
                  'Browse, add to cart, and securely checkout. We deliver your books right to your door. Customize your reading experience, track progress, and connect with fellow book lovers.',
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  text: 'Skip',
                  onTap: () {
                    context.go(AppPath.welcome);
                  },
                ),
                CustomButton(
                  text: 'Next',
                  onTap: () {
                    context.go(AppPath.welcome);
                  },
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
