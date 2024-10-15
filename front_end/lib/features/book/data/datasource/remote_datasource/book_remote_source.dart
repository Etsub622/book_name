import 'dart:convert';

import 'package:front_end/core/error/exceptions.dart';
import 'package:front_end/features/book/data/model/book_model.dart';
import 'package:front_end/features/book/domain/entity/book_entity.dart';
import 'package:front_end/features/book/domain/usecase/get_single_book_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class BookRemoteDataSource {
  Future<String> addBooks(BookModel bookModel);
  Future<List<BookModel>> getBooks();
  Future<BookModel> getSingleBook(String id);
  Future<String> deleteBook(String id);
  Future<List<BookModel>> getBookByCategory(String category);
  Future<List<BookModel>> search(String title);
  Future<String> update(String id, BookModel bookEntity);
}

class BookRemoteImpl implements BookRemoteDataSource {
  final http.Client client;
  BookRemoteImpl(this.client);
  final baseUrl = 'http://localhost:3000/book';

  @override
  Future<String> addBooks(BookModel bookModel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('tokenKey');

      if (token == null || token.isEmpty) {
        throw CacheException(message: 'Token not found');
      }
      var url = Uri.parse('$baseUrl/create');
      final book = await client.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(bookModel.toJson()));
      print(book.body);

      if (book.statusCode == 201) {
        return 'created successfully';
      } else {
        throw ServerException(
            message: 'Failed to create book: ${book.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BookModel>> getBooks() async {
    final Uri url = Uri.parse(baseUrl);
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> bookJson = json.decode(response.body);
      if (bookJson.isEmpty) {
        throw ServerException(message: 'No books found');
      } else {
        return bookJson.map((jsonItem) {
          return BookModel.fromJson(jsonItem as Map<String, dynamic>);
        }).toList();
      }
    } else {
      throw ServerException(message: 'Failed to load books');
    }
  }

  @override
  Future<BookModel> getSingleBook(String id) async {
    final Uri url = Uri.parse('$baseUrl/$id');
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final bookJson = json.decode(response.body);
      return BookModel.fromJson(bookJson);
    } else {
      throw ServerException(message: 'Failed to load book');
    }
  }

  @override
  Future<String> deleteBook(String id) async {
    final Uri url = Uri.parse('$baseUrl/$id');
    final res = await client.delete(url);
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      return 'Book deleted successfully';
    } else {
      throw ServerException(message: 'Failed to delete book');
    }
  }

  @override
  Future<List<BookModel>> getBookByCategory(String category) async {
    final url = Uri.parse('$baseUrl/category/$category');
    final res =
        await client.get(url, headers: {'Content-Type': 'application/json'});
    if (res.statusCode == 200) {
      final List<dynamic> bookJson = json.decode(res.body);
      if (bookJson.isEmpty) {
        throw ServerException(message: 'No books found');
      } else {
        return bookJson.map((jsonItem) {
          return BookModel.fromJson(jsonItem as Map<String, dynamic>);
        }).toList();
      }
    } else {
      throw ServerException(message: 'Failed to load books');
    }
  }

  @override
  Future<List<BookModel>> search(String title) async {
    final url = Uri.parse('$baseUrl?keyword=$title');
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      final List<BookModel> books =
          responseData.map((book) => BookModel.fromJson(book)).toList();

      if (books.isEmpty) {
        throw ServerException(message: 'No books found');
      }
      return books;
    } else {
      throw ServerException(message: 'serverfailure');
    }
  }

  @override
  Future<String> update(String id, BookModel bookEntity) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await client.put(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bookEntity.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return 'Book updated successfully';
    } else {
      throw ServerException(message: 'Failed to update book');
    }
  }
}
