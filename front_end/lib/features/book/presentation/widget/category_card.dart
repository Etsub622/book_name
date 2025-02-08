import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:go_router/go_router.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final String extra;
  final String image;

  const CategoryCard({
    super.key,
    required this.title,
    required this.extra,
    required this.image,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.h,
      width: 150.w,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xff301934),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () =>
            context.go(AppPath.getBooksByCategory, extra: widget.extra),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.image,
              height: 100.h,
              width: 150,
            ),
            SizedBox(height: 13.h),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
