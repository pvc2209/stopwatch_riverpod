import 'package:andesgroup_common/utils/characters.dart';
import 'package:andesgroup_common/utils/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iap_interface/iap_interface.dart';

import '../../model/data.dart';
import '../../storage/storage.dart';
import 'home_state.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(
    this.ref, {
    HomeState? state,
  }) : super(state ?? const HomeState()) {
    loadData();
  }
  final Ref ref;

  Future<void> loadData() async {
    state = state.copyWith(data: const AsyncLoading());
    state = state.copyWith(data: await AsyncValue.guard(() => StorageHelper.getData()));
  }

  Future<bool> checkPurchase() async {
    if (ref.read(iapProvider).diamonds < 10) {
      final purchase = await ref.read(iapProvider.notifier).checkPurchase();
      if (!purchase) {
        return false;
      }
    }
    return true;
  }

  void load() {
    state = state.copyWith(loading: true);
  }

  void unload() {
    state = state.copyWith(loading: false);
  }

  void done() {
    state = state.copyWith(done: true);
  }

  void toggleExtended() {
    state = state.copyWith(extended: !state.extended);
  }

  void selectedIndexChanged(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  Future<void> clear() async {
    await StorageHelper.removeAllData();
    loadData();
  }

  Future<void> remove(Data i) async {
    await StorageHelper.removeData(i);
    loadData();
  }

  void setLength(int length) {
    state = state.copyWith(length: length);
  }

  void generate() {
    String src = '';
    if (state.useNho) {
      src += Chars.lower;
    }
    if (state.useTo) {
      src += Chars.upper;
    }
    if (state.useNumber) {
      src += Chars.number;
    }
    if (state.useSymbol) {
      src += Chars.symbol;
    }
    if (src.isEmpty) {
      return;
    }

    String result = '';
    while (result.length != state.length) {
      result += getRandomElement(src.split(''));
    }
    state = state.copyWith(result: result);
  }

  void updateNho(bool value) {
    state = state.copyWith(useNho: value);
  }

  void updateTo(bool value) {
    state = state.copyWith(useTo: value);
  }

  void updateNumber(bool value) {
    state = state.copyWith(useNumber: value);
  }

  Future<bool> updateSymbol(bool value) async {
    state = state.copyWith(useSymbol: value);
    return true;
  }
}
