import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/exceptions.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/network/network.dart';
import 'package:front_end/features/chat/data/datasource/remote_datasource/chat_remote_datasource.dart';
import 'package:front_end/features/chat/domain/entity/chat_entity.dart';
import 'package:front_end/features/chat/domain/repository/chat_repo.dart';

class ChatInitiateRepoImpl extends ChatInitiateRepo {
  final ChatRemoteDataSource chatRemoteDataSource;
  final NetworkInfo networkInfo;

  ChatInitiateRepoImpl(this.chatRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ChatRespientResponse>> initiateChat(
      String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await chatRemoteDataSource.initiateChat(userId);
        print('repo impl,,,,,,,,,,,,,,');
        print(response);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure(message: 'Server Failure'));
      }
    } else {
      return Left(ServerFailure(message: 'No Internet Connection'));
    }
  }
}
