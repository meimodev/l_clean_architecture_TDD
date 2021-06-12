import 'package:equatable/equatable.dart';

class SearchTask extends Equatable {
  final String title;
  final int price;

  SearchTask({
    required this.title,
    required this.price,
  });

  @override
  List<Object?> get props => [title, price];
}
