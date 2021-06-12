import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/search_task.dart';

import '../repositories/search_task_repository.dart';

class GetSearchTask implements UseCase<SearchTask, Params> {
  final SearchTaskRepository repository;

  GetSearchTask(this.repository);

  @override
  Future<Either<Failure, SearchTask>> call(Params params) async {
    return await repository.getSearchTask(params.title);
  }
}

class Params extends Equatable {
  Params({required this.title});
  final String title;

  @override
  List<Object?> get props => [title];
}
