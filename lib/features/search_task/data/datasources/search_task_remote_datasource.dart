import 'package:mapalus/features/search_task/data/models/search_task_model.dart';

abstract class SearchTaskRemoteDataSource {
  /// Calls the remote https://something.api.com endpoint
  ///
  /// throws a [ServerException] for all error codes
  Future<SearchTaskModel> getSearchTask(String title);
}
