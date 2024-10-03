import 'dart:convert';
import 'package:front_end/core/error/exceptions.dart';
import 'package:front_end/features/chat/data/model/chat_model.dart';
import 'package:front_end/features/chat/domain/entity/chat_entity.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChatRemoteDataSource {
  Future<ChatRespientResponse> initiateChat(String userId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final http.Client client;
  ChatRemoteDataSourceImpl(this.client);

  final String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v3/chats';

  @override
  Future<ChatRespientResponse> initiateChat(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('tokenKey');
      
      if (token == null || token.isEmpty) {
        throw CacheException(message: 'Token not found');
      }

      final url = Uri.parse(baseUrl);

      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'userId': userId}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        
        final user1 = UserModel.fromJson(jsonResponse['data']['user1']);
        final user2 = UserModel.fromJson(jsonResponse['data']['user2']);
        final chatId = jsonResponse['data']['_id'];
        
        return ChatRespientResponseModel(
          chatId: chatId,
          user1: user1,
          user2: user2,
        );
      } else {
        throw ServerException(
            message: 'Failed to create chat: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
