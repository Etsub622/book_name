import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front_end/core/config/app_path.dart';
import 'package:front_end/features/book/domain/entity/book_entity.dart';
import 'package:front_end/features/book/presentation/bloc/bloc/book_bloc.dart';
import 'package:front_end/features/book/presentation/pages/update.dart';
import 'package:front_end/features/book/presentation/widget/card_detail.dart';
import 'package:front_end/features/favorites/presntation/bloc/favorites_bloc.dart';
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
    context.read<FavoritesBloc>().add(LoadFavoritesEvent());
  }

  List<String> _convertToList(dynamic value) {
    if (value is Iterable) {
      return List<String>.from(value.map((item) => item.toString()));
    } else if (value is String) {
      return [value];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            GoRouter.of(context).go(AppPath.bookHome);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<BookBloc, BookState>(
          listener: (context, state) {
            if (state is BookDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              GoRouter.of(context).go(AppPath.navbar);
            } else if (state is BookError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is BookLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SingleBookLoaded) {
              final book = state.book;

              final isFavorite = context.select<FavoritesBloc, bool>(
                  (favoritesBloc) => favoritesBloc.favoriteBooks
                      .any((favorite) => favorite.id == book.id));

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
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdatePage(
                                    title: book.title,
                                    author: book.author,
                                    description: book.description,
                                    price: book.price,
                                    imageUrl: book.imageUrl,
                                    category: book.category,
                                    onUpdate: (updatedBookMap) {
                                      final updatedBook = BookEntity(
                                        id: book.id,
                                        title:
                                            updatedBookMap['title'] as String,
                                        author:
                                            updatedBookMap['author'] as String,
                                        description:
                                            updatedBookMap['description']
                                                as String,
                                        price: updatedBookMap['price'] as num,
                                        imageUrl: _convertToList(
                                            updatedBookMap['imageUrl']),
                                        category: _convertToList(
                                            updatedBookMap['category']),
                                      );
                                      context.read<BookBloc>().add(
                                          UpdateEvent(book.id, updatedBook));
                                    },
                                  ),
                                ),
                              );

                              if (result == true) {
                                context
                                    .read<BookBloc>()
                                    .add(GetSingleBookEvent(book.id));
                              }
                            },
                            icon: Icon(Icons.edit, color: Colors.brown[300])),
                        IconButton(
                            onPressed: () {
                              _showDeleteDialog(context);
                            },
                            icon: Icon(Icons.delete, color: Colors.brown[300])),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.brown[300],
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              context
                                  .read<FavoritesBloc>()
                                  .add(RemoveFavoriteEvent(book));
                            } else {
                              context
                                  .read<FavoritesBloc>()
                                  .add(AddFavoriteEvent(book));
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 110, 84, 75),
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      height: 50,
                      child: const Center(
                          child: Text('Contact the seller',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white))),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Error fetching book details'),
              );
            }
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure you want to delete this book?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<BookBloc>().add(DeleteBookEvent(widget.id));

                context.go(AppPath.navbar);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
