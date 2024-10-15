import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/book/presentation/bloc/bloc/book_bloc.dart';
import 'package:front_end/features/book/presentation/pages/book_detail.dart';
import 'package:front_end/features/book/presentation/widget/card_widget.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Enter a search keyword',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final searchKeyword = _searchController.text;
                context.read<BookBloc>().add(
                      SearchEvent(searchKeyword),
                    );
                // Navigator.pop(context);
                //           context
                //             .read<ProductBlocBloc>()
                //             .add(LoadAllProductEvent());
              },
              child: Text('Search'),
            ),
            Expanded(
              child: BlocBuilder<BookBloc, BookState>(
                builder: (context, state) {
                  if (state is BookInitial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchLoad) {
                    return buildProductList(state.books);
                  } else if (state is BookError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductList(books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return BookDetail(
                  id: book.id,
                );
              }),
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
  }
}
