import 'dart:convert';
import 'package:front_end/core/error/exceptions.dart';
import 'package:front_end/features/book/data/model/book_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GetBooksLocalDataSource {
  Future<List<BookModel>> getLastBooks();
  Future<void> cacheBooks(List<BookModel> bookModel);
}

class GetBooksLocalDataSourceImpl implements GetBooksLocalDataSource {
  final SharedPreferences sharedPreferences;
  GetBooksLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<void> cacheBooks(List<BookModel> bookModel) async {
    final List<Map<String, dynamic>> jsonList =
        bookModel.map((book) => book.toJson()).toList();
    final jsonString = json.encode(jsonList);

    await sharedPreferences.setString('cached_books', jsonString);
  }

  @override
  Future<List<BookModel>> getLastBooks() async {
    final jsonString = sharedPreferences.getString('cached_books');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);

      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } else {
      throw CacheException(message: 'no books found in cached');
    }
  }
}

