import 'dart:convert';
import 'package:front_end/core/error/exceptions.dart';
import 'package:front_end/features/onboarding/data/models/auth_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<String> signUp(SignUPModel newUser);
  Future<String> logIn(LogInModel oldUser);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  late final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});
  final baseUrl = 'http://localhost:3000/auth';

  @override
  Future<String> signUp(SignUPModel newUser) async {
    try {
      var url = Uri.parse('$baseUrl/signup');
      final user = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newUser.toJson()),
      );

      if (user.statusCode == 201 || user.statusCode == 200) {
        return 'user created';
      } else {
        throw ServerException(message: 'Failed to create user');
      }
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<String> logIn(LogInModel oldUser) async {
    var url = Uri.parse('$baseUrl/login');

    final res = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(oldUser.toJson()));
    print(res.body);
    print(res.statusCode);
    print(jsonDecode(res.body)['token']);
    if (res.statusCode == 201) {
      return jsonDecode(res.body)['token'];
    } else {
      throw ServerException(message: 'server failure');
    }
  }
}
