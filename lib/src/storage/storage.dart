import 'dart:convert';

import 'package:andesgroup_common/common.dart';
import '../model/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sampleData = <Data>[];
final sampleIds = sampleData.map((e) => e.id).toList();

class StorageHelper {
  static const key = 'data';

  static Future<SharedPreferences> get instance async =>
      SharedPreferences.getInstance();

  static Future<List<Data>> getData() async {
    final ref = await instance;
    final value = ref.getString(key) ?? '[]';
    final list =
        parseListNotNull(json: jsonDecode(value), fromJson: Data.fromJson);
    list.addAll(sampleData.where((a) => list.every((b) => a.id != b.id)));
    return list;
  }

  static Future<void> setData(List<Data> tasks) async {
    final ref = await instance;
    await ref.setString(key, jsonEncode(tasks));
  }

  static Future<void> insertData(Data task) async {
    final tasks = await getData();
    await setData(tasks..add(task));
  }

  static Future<void> removeData(Data task) async {
    final tasks = await getData();
    await setData(tasks..removeWhere((element) => element.id == task.id));
  }

  static Future<void> updateData(Data task) async {
    final tasks = await getData();
    await setData(tasks.map((e) {
      if (e.id == task.id) {
        return task;
      } else {
        return e;
      }
    }).toList());
  }

  static Future<void> removeAllData() async {
    final ref = await instance;
    await ref.setString(key, '[]');
  }
}
