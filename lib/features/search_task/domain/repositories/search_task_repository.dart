import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/search_task.dart';

abstract class SearchTaskRepository {
  Future<Either<Failure, SearchTask>> getSearchTask(String title);
}
