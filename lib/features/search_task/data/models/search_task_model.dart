import 'package:mapalus/features/search_task/domain/entities/search_task.dart';

class SearchTaskModel extends SearchTask {
  SearchTaskModel({
    required String title,
    required int price,
  }) : super(title: title, price: price);

  factory SearchTaskModel.fromJson(Map<String, dynamic> json) {
    return SearchTaskModel(
      title: json['title'],
      price: (json['price'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
    };
  }
}
