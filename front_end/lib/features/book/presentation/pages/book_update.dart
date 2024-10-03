import 'package:flutter/material.dart';

class BookUpdate extends StatefulWidget {
  final String id;
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final String category;
  final double price;

  const BookUpdate({super.key, required this.id, required this.title, required this.author, required this.description, required this.imageUrl, required this.category, required this.price});

  @override
  State<BookUpdate> createState() => _BookUpdateState();
}

class _BookUpdateState extends State<BookUpdate> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
