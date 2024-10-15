import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          context.go(AppPath.navbar);
                        },
                        child: Icon(Icons.arrow_back_ios)),
                    Text(
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
              const SizedBox(height: 25),
              buildProductList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(AppPath.addBooks);
        },
        child: const Icon(Icons.add),
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
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.books.length,
          itemBuilder: (context, idx) {
            final book = Books[idx];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BookDetail(id: book.id);
                    },
                  ),
                );
              },
              child: CardPage(
                image: book.imageUrl,
                title: book.title,
                price: book.price,
                author: book.author,
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
