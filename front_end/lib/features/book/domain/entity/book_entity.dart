import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String id;
  final String title;
  final String author;
  final String description;
  final List<String> imageUrl;
  final num price;
  final List<String> category;

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, author, description, imageUrl, price, category];
}
