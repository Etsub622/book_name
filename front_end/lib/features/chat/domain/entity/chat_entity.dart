import 'package:equatable/equatable.dart';

class ChatInitiate extends Equatable {
  final String userId;
  const ChatInitiate({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class User extends Equatable {
  final String id;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, email];
}

class ChatRespientResponse extends Equatable {
  final User user2;
  final User user1;
  final String chatId;
  const ChatRespientResponse({
    required this.user1,
    required this.user2,
    required this.chatId,
  });

  @override
  List<Object?> get props => [user2, chatId];
}
