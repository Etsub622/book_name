import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/features/book/presentation/pages/book_detail.dart';
import 'package:front_end/features/book/presentation/widget/card_widget.dart';
import 'package:front_end/features/favorites/presntation/bloc/favorites_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesBloc>().add(LoadFavoritesEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Books',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.brown,
              fontSize: 19.sp,
              fontFamily: 'Poppins'),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoriteLoad) {
              final favoriteBooks = state.favoritebooks.reversed.toList();

              if (favoriteBooks.isEmpty) {
                return const Center(child: Text('No favorite books yet.'));
              }

              return ListView.builder(
                itemCount: favoriteBooks.length,
                itemBuilder: (context, idx) {
                  final book = favoriteBooks[idx];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookDetail(
                              id: book.id, category: book.category[0]),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, top: 15.0, right: 12.0),
                      child: CardPage(
                        image: book.imageUrl,
                        title: book.title,
                        price: book.price,
                        author: book.author,
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Error loading favorites'));
            }
          },
        ),
      ),
    );
  }
}
