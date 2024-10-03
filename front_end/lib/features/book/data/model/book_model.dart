import 'dart:convert';
import 'package:front_end/features/book/domain/entity/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.description,
    required super.imageUrl,
    required super.price,
    required super.category,
  });

  // Factory constructor for converting JSON into a BookModel
  factory BookModel.fromJson(Map<String, dynamic> json) {
    var images = json['imageUrl'] as List?;
    List<String> imageUrls = [];

    if (images != null) {
      for (var value in images) {
        if (value is String && value.isNotEmpty) {
          imageUrls.add(value);
        }
      }
    }

    return BookModel(
      id: json['_id'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      imageUrl: imageUrls,
      price: json['price'],
      category: List<String>.from(json['category']),
    );
  }

  // Convert the BookModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': super.title,
      'author': super.author,
      'description': super.description,
      'imageUrl': super.imageUrl,
      'price': super.price,
      'category': super.category,
    };
  }

  // Add the toEntity method to convert the model to an entity
  BookEntity toEntity() {
    return BookEntity(
      id: this.id,
      title: this.title,
      author: this.author,
      description: this.description,
      imageUrl: this.imageUrl,
      price: this.price,
      category: this.category,
    );
  }
}
