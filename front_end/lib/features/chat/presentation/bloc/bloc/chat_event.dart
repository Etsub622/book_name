part of 'chat_bloc.dart';

sealed class ChatEvent {}

class InitiateChatEvent extends ChatEvent {
  final String userId;
  InitiateChatEvent(this.userId);
}
