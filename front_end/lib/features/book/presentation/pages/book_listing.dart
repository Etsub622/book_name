import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/common_widget.dart/circular_indicator.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:front_end/features/book/presentation/bloc/bloc/book_bloc.dart';
import 'package:front_end/features/book/presentation/pages/book_detail.dart';
import 'package:front_end/features/book/presentation/widget/card_widget.dart';
import 'package:go_router/go_router.dart';

class BookListing extends StatelessWidget {
  final String? category;
  const BookListing({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    if (category == null) {
      context.read<BookBloc>().add(const GetAllBooksEvent());
    } else {
      context.read<BookBloc>().add(GetBooksByCategory(category!));
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          context.go(AppPath.navbar);
                        },
                        child: const Icon(Icons.arrow_back_ios, size: 23)),
                    SizedBox(width: 10.w),
                    const Text(
                      'Available books',
                      style: TextStyle(
                        color: Color(0XFF3E3E3E),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: buildProductList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildProductList() {
  return BlocBuilder<BookBloc, BookState>(
    builder: (context, state) {
      if (state is BookInitial) {
        return const Center(child: Text('Start searching ...'));
      } else if (state is BookLoading) {
        return const Center(child: CircularIndicator());
      } else if (state is BookLoaded) {
        final Books = state.books.reversed.toList();
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 20.h,
            childAspectRatio: 0.75,
          ),
          shrinkWrap: true,
          itemCount: state.books.length,
          itemBuilder: (context, idx) {
            final book = Books[idx];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BookDetail(
                          id: book.id, category: book.category[0]);
                    },
                  ),
                ).then((category) {
                  if (category != null) {
                    context.read<BookBloc>().add(GetBooksByCategory(category));
                  }
                });
              },
              child: Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: [
                  CardPage(
                    image: book.imageUrl,
                    title: book.title,
                    price: book.price,
                    author: book.author,
                  ),
                ],
              ),
            );
          },
        );
      } else {
        return const Center(child: Text('No books found'));
      }
    },
  );
}
