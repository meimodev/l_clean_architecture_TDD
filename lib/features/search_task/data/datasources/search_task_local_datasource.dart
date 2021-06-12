import 'package:mapalus/core/error/exceptions.dart';
import 'package:mapalus/features/search_task/data/models/search_task_model.dart';

abstract class SearchTaskLocalDataSource {
  /// Gets the cached [SearchTaskModel] that last cached when had internet
  ///
  ///
  /// throws a [CacheException] if no cached data present
  Future<SearchTaskModel> getLastSearchTask();

  Future<void> cacheSearchTask(SearchTaskModel searchTaskModelToCache);
}
