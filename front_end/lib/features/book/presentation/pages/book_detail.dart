import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/book/presentation/bloc/bloc/book_bloc.dart';
import 'package:front_end/features/book/presentation/widget/card_detail.dart';
import 'package:go_router/go_router.dart';

class BookDetail extends StatefulWidget {
  final String id;
  const BookDetail({super.key, required this.id});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(GetSingleBookEvent(widget.id));
  }

  @override
  void dispose() {
    context.read<BookBloc>().add(ResetBookStateEvent());
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SingleBookLoaded) {
              final book = state.book;
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    CardDetailPage(
                      images: book.imageUrl,
                      title: book.title,
                      price: book.price,
                      author: book.author,
                      description: book.description,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Update'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Error fetching book'),
              );
            }
          },
        ),
      ),
    );
  }
}
