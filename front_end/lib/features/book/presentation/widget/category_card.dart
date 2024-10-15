import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:go_router/go_router.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final String extra;
  const CategoryCard({super.key, required this.title, required this.extra});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 175, 134, 120),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
          onTap: () =>
              context.go(AppPath.getBooksByCategory, extra: widget.extra),
          child: Center(
              child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ))),
    );
  }
}
