import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mapalus/features/search_task/data/models/search_task_model.dart';
import 'package:mapalus/features/search_task/domain/entities/search_task.dart';

import '../../../../../test/fixtures/reader.dart';

void main() {
  late final tSearchTaskModel = SearchTaskModel(title: 'test', price: 1);

  test('should be a subclass of SearchText entity', () async {
    expect(tSearchTaskModel, isA<SearchTask>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('task.json'));

      final result = SearchTaskModel.fromJson(jsonMap);

      expect(result, tSearchTaskModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map', () async {
      final result = tSearchTaskModel.toJson();
      final expectedMap = {
        'title': 'test',
        'price': 1,
      };
      expect(result, expectedMap);
    });
  });
}
