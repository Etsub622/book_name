import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/chat/domain/entity/chat_entity.dart';
import 'package:front_end/features/chat/domain/repository/chat_repo.dart';

class ChatInitiateUsecase extends UseCase<ChatRespientResponse, ChatParams> {
  final ChatInitiateRepo chatRepository;
  ChatInitiateUsecase(this.chatRepository);

  @override
  Future<Either<Failure, ChatRespientResponse>> call(ChatParams param) {
    return chatRepository.initiateChat(param.userId);
  }
}

class ChatParams {
  final String userId;
  ChatParams(this.userId);
}
