import 'package:dartz/dartz.dart';
import 'package:mapalus/features/search_task/domain/entities/search_task.dart';
import 'package:mapalus/features/search_task/domain/repositories/search_task_repository.dart';
import 'package:mapalus/features/search_task/domain/usecases/get_search_task.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'get_search_task_test.mocks.dart';

// class MockSearchTaskRepository extends Mock implements SearchTaskRepository {}

@GenerateMocks([SearchTaskRepository])
void main() {
  late GetSearchTask useCase;
  late MockSearchTaskRepository mockSearchTaskRepository;

  setUp(() {
    mockSearchTaskRepository = MockSearchTaskRepository();
    useCase = GetSearchTask(mockSearchTaskRepository);
  });

  final tTitle = '';
  final tSearchTask =
      SearchTask(title: 'clean project in hospital', price: 20000);

  test('should get task for the title from the repo', () async {
    when(mockSearchTaskRepository.getSearchTask(tTitle))
        .thenAnswer((_) async => Right(tSearchTask));

    final result = await useCase(Params(title: tTitle));

    expect(result, Right(tSearchTask));
    verify(mockSearchTaskRepository.getSearchTask(tTitle));
    verifyNoMoreInteractions(mockSearchTaskRepository);
  });
}
