import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/features/book/presentation/pages/recent_books.dart';
import 'package:front_end/features/book/presentation/widget/category_card.dart';

class BookHome extends StatefulWidget {
  const BookHome({super.key});

  @override
  State<BookHome> createState() => _BookHomeState();
}

class _BookHomeState extends State<BookHome> {
  // int curIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 13, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text('Welcome To J book Store',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                          fontSize: 16.sp))),
              SizedBox(
                height: 5.h,
              ),
              Text(
                  'Lorem inmskf here ther you can do anything anywho and else everythingjfkdjakfjkajkfj jsjfkjfadfo'),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      CategoryCard(
                        title: 'Comedy',
                        extra: 'comedy',
                      ),
                      SizedBox(width: 20.w),
                      CategoryCard(
                        title: 'Fantasy',
                        extra: 'fantasy',
                      ),
                      SizedBox(width: 20.w),
                      CategoryCard(
                        title: 'Crime',
                        extra: 'crime',
                      ),
                      SizedBox(width: 20.w),
                      CategoryCard(
                        title: 'Romance',
                        extra: 'romance',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      CategoryCard(
                        title: 'Comedy',
                        extra: 'comedy',
                      ),
                      SizedBox(width: 20.w),
                      CategoryCard(
                        title: 'Fantasy',
                        extra: 'fantasy',
                      ),
                      SizedBox(width: 20.w),
                      CategoryCard(
                        title: 'Crime',
                        extra: 'crime',
                      ),
                      SizedBox(width: 20.w),
                      CategoryCard(
                        title: 'Romance',
                        extra: 'romance',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Recently Added books',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(child: RecentBooks()),
            ],
          ),
        ),
      ),
    );
  }
}
