import 'package:dartz/dartz.dart';
import 'package:mapalus/core/error/exceptions.dart';
import 'package:mapalus/core/error/failures.dart';
import 'package:mapalus/core/network/network_info.dart';
import 'package:mapalus/features/search_task/data/datasources/search_task_local_datasource.dart';
import 'package:mapalus/features/search_task/data/datasources/search_task_remote_datasource.dart';
import 'package:mapalus/features/search_task/domain/entities/search_task.dart';
import 'package:mapalus/features/search_task/domain/repositories/search_task_repository.dart';

class SearchTaskRepositoryImpl implements SearchTaskRepository {
  final SearchTaskRemoteDataSource remoteDataSource;
  final SearchTaskLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SearchTaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, SearchTask>> getSearchTask(String title) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getSearchTask(title);
        localDataSource.cacheSearchTask(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localData = await localDataSource.getLastSearchTask();
        return Right(localData);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
