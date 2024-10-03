part of 'chat_bloc.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final ChatRespientResponse chatRespientResponse;

  ChatLoaded(this.chatRespientResponse);
}

final class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
