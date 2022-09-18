import 'package:anim_clock/src/model/lap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPref {
  static const lapKey = 'laps';

  static Future<SharedPreferences> get instance async =>
      SharedPreferences.getInstance();

  static Future<List<Lap>> getData() async {
    final ref = await instance;
    final List<String> jsonList = ref.getStringList(lapKey) ?? [];

    return jsonList.map((json) => Lap.fromJson(json)).toList();
  }

  static Future<void> setData(List<Lap> laps) async {
    final ref = await instance;
    await ref.setStringList(lapKey, laps.map((lap) => lap.toJson()).toList());
  }

  static Future<void> insertData(Lap lap) async {
    final laps = await getData();
    await setData(laps..add(lap));
  }

  static Future<void> removeData(Lap lap) async {
    final laps = await getData();
    await setData(laps..removeWhere((element) => element.id == lap.id));
  }

  static Future<void> updateData(Lap lap) async {
    final laps = await getData();
    await setData(laps.map((e) {
      if (e.id == lap.id) {
        return lap;
      } else {
        return e;
      }
    }).toList());
  }

  static Future<void> removeAllData() async {
    final ref = await instance;
    await ref.setStringList(lapKey, []);
  }
}
