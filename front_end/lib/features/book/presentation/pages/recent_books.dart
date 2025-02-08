import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/core/common_widget.dart/circular_indicator.dart';
import 'package:front_end/features/book/presentation/bloc/bloc/book_bloc.dart';
import 'package:front_end/features/book/presentation/pages/book_detail.dart';
import 'package:front_end/features/book/presentation/widget/card_widget.dart';

class RecentBooks extends StatelessWidget {
  const RecentBooks({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BookBloc>().add(const GetAllBooksEvent());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildProductList(),
            ),
          ],
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
        final recentBooks = state.books.reversed.take(5).toList();

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recentBooks.length,
          itemBuilder: (context, idx) {
            final book = recentBooks[idx];
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
