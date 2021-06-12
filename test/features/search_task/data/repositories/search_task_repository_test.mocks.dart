// Mocks generated by Mockito 5.0.10 from annotations
// in mapalus/test/features/search_task/data/repositories/search_task_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mapalus/core/network/network_info.dart' as _i6;
import 'package:mapalus/features/search_task/data/datasources/search_task_local_datasource.dart'
    as _i5;
import 'package:mapalus/features/search_task/data/datasources/search_task_remote_datasource.dart'
    as _i3;
import 'package:mapalus/features/search_task/data/models/search_task_model.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeSearchTaskModel extends _i1.Fake implements _i2.SearchTaskModel {}

/// A class which mocks [SearchTaskRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchTaskRemoteDataSource extends _i1.Mock
    implements _i3.SearchTaskRemoteDataSource {
  MockSearchTaskRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.SearchTaskModel> getSearchTask(String? title) =>
      (super.noSuchMethod(Invocation.method(#getSearchTask, [title]),
              returnValue:
                  Future<_i2.SearchTaskModel>.value(_FakeSearchTaskModel()))
          as _i4.Future<_i2.SearchTaskModel>);
}

/// A class which mocks [SearchTaskLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchTaskLocalDataSource extends _i1.Mock
    implements _i5.SearchTaskLocalDataSource {
  MockSearchTaskLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.SearchTaskModel> getLastSearchTask() =>
      (super.noSuchMethod(Invocation.method(#getLastSearchTask, []),
              returnValue:
                  Future<_i2.SearchTaskModel>.value(_FakeSearchTaskModel()))
          as _i4.Future<_i2.SearchTaskModel>);
  @override
  _i4.Future<void> cacheSearchTask(
          _i2.SearchTaskModel? searchTaskModelToCache) =>
      (super.noSuchMethod(
          Invocation.method(#cacheSearchTask, [searchTaskModelToCache]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
}