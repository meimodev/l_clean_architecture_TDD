import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapalus/core/error/exceptions.dart';
import 'package:mapalus/core/error/failures.dart';
import 'package:mapalus/core/network/network_info.dart';
import 'package:mapalus/features/search_task/data/datasources/search_task_local_datasource.dart';
import 'package:mapalus/features/search_task/data/datasources/search_task_remote_datasource.dart';
import 'package:mapalus/features/search_task/data/models/search_task_model.dart';
import 'package:mapalus/features/search_task/data/repositories/search_task_repository_impl.dart';
import 'package:mapalus/features/search_task/domain/entities/search_task.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_task_repository_test.mocks.dart';

// class MockRemoteDataSource extends Mock implements SearchTaskRemoteDataSource {}
//
// class MockLocalDataSource extends Mock implements SearchTaskLocalDataSource {}
//
// class MockNetworkInfo extends Mock implements NetworkInfo {}
//
@GenerateMocks([
  SearchTaskRemoteDataSource,
  SearchTaskLocalDataSource,
  NetworkInfo,
])
void main() {
  late SearchTaskRepositoryImpl repository;

  late MockSearchTaskRemoteDataSource mockRemoteDataSource;
  late MockSearchTaskLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockSearchTaskRemoteDataSource();
    mockLocalDataSource = MockSearchTaskLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SearchTaskRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  final tTitle = 'test';
  final tSearchTaskModel = SearchTaskModel(title: tTitle, price: 1);
  final SearchTask tSearchTask = tSearchTaskModel;

  group('get Search task', () {
    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getSearchTask(tTitle);

      verify(() => mockNetworkInfo.isConnected);
    });
  });

  runTestsOnline(() {
    test('should return remote data when the call to remote data is success',
        () async {
      when(mockRemoteDataSource.getSearchTask(tTitle))
          .thenAnswer((_) async => tSearchTaskModel);

      final result = await repository.getSearchTask(tTitle);

      verify(mockRemoteDataSource.getSearchTask(tTitle));
      expect(result, equals(Right(tSearchTask)));
    });

    test(
        'should cache the data locally when the call to remote data is success',
        () async {
      when(mockRemoteDataSource.getSearchTask(tTitle))
          .thenAnswer((_) async => tSearchTaskModel);

      await repository.getSearchTask(tTitle);

      verify(mockRemoteDataSource.getSearchTask(tTitle));

      verify(mockLocalDataSource.cacheSearchTask(tSearchTaskModel));
    });

    test('should return server failure when the call to remote data is fail',
        () async {
      when(mockRemoteDataSource.getSearchTask(tTitle))
          .thenThrow(ServerException());

      final result = await repository.getSearchTask(tTitle);

      verify(mockRemoteDataSource.getSearchTask(tTitle));
      expect(result, equals(Left(ServerFailure())));
    });
  });

  runTestsOffline(() {
    test(
        'should return last locally cached data when the cached data is present',
        () async {
      when(mockLocalDataSource.getLastSearchTask())
          .thenAnswer((_) async => tSearchTaskModel);

      final result = await repository.getSearchTask(tTitle);

      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastSearchTask());
      expect(result, equals(Right(tSearchTask)));
    });

    test('should return CacheFailure when there is no cached', () async {
      when(mockLocalDataSource.getLastSearchTask()).thenThrow(CacheException());

      final result = await repository.getSearchTask(tTitle);

      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastSearchTask());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
