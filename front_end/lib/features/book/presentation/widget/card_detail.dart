import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDetailPage extends StatelessWidget {
  final List<String> images;
  final String title;
  final num price;
  final String author;
  final String description;
  final List<String> categories;

  const CardDetailPage({
    Key? key,
    required this.images,
    required this.title,
    required this.price,
    required this.author,
    required this.description,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      color: const Color(0xFFFDFCF8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: SizedBox(
                height: 250.h,
                width: 180.w,
                child: PageView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: const Color(0xff301934),
                fontWeight: FontWeight.w600,
                fontSize: 23.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'By $author',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '\$$price',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: categories.map((category) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 63, 45, 66),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      color: const Color.fromARGB(255, 252, 238, 238),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 13.h),
            Text('Book overview',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(height: 10.h),
            Text(
              description,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                color: Colors.black87,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 13.h),
          ],
        ),
      ),
    );
  }
}
