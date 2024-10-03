import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/features/chat/domain/entity/chat_entity.dart';

abstract class ChatInitiateRepo{
  Future<Either<Failure,ChatRespientResponse>> initiateChat( String userId);
}