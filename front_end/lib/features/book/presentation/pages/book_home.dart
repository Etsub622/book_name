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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text('Welcome To your book Store',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff301934),
                            fontFamily: 'Poppins',
                            fontSize: 20.sp))),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Discover, manage, and enjoy your reading journey. Create personalized reading lists, explore various genres, and keep track of your favorite books—all in one place!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 49, 29, 53),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  'Categories',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                      color: Colors.brown,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Wrap(
                    spacing: 20.w,
                    runSpacing: 20.h,
                    children: const [
                      CategoryCard(
                        title: 'Comedy',
                        extra: 'comedy',
                        image: 'asset/images/comedy.png',
                      ),
                      CategoryCard(
                        title: 'Fantasy',
                        extra: 'fantasy',
                        image: 'asset/images/fantasy.jpg',
                      ),
                      CategoryCard(
                        title: 'Crime',
                        extra: 'crime',
                        image: 'asset/images/crime.jpg',
                      ),
                      CategoryCard(
                        title: 'Romance',
                        extra: 'romance',
                        image: 'asset/images/romance.jpg',
                      ),
                      CategoryCard(
                        title: 'Travel',
                        extra: 'travel',
                        image: 'asset/images/travel.jpg',
                      ),
                      CategoryCard(
                        title: 'Self Help',
                        extra: 'self help',
                        image: 'asset/images/self help.jpg',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Recently Added books',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      color: Colors.brown),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 300.h,
                  child: const RecentBooks(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
