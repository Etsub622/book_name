import 'package:front_end/features/chat/domain/entity/chat_entity.dart';

class ChatInitiateModel extends ChatInitiate {
  const ChatInitiateModel({
    required super.userId,
  });

  factory ChatInitiateModel.fromJson(Map<String, dynamic> json) {
    return ChatInitiateModel(
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }
}

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
    };
  }
}


class ChatRespientResponseModel extends ChatRespientResponse {
  const ChatRespientResponseModel({
    required super.user1,
    required super.user2,
    required super.chatId,
  });

  factory ChatRespientResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatRespientResponseModel(
      user1: UserModel.fromJson(json['user1']),
      user2: UserModel.fromJson(json['user2']),
      chatId: json['chatId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user1':(user1 as UserModel).toJson(),
      'user2':(user2 as UserModel).toJson(),
      'chatId': chatId,
    };
  }
}
