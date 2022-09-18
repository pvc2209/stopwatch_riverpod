import 'package:anim_clock/src/features/history/providers/history_provider.dart';
import 'package:anim_clock/src/features/main/providers/main_state.dart';
import 'package:anim_clock/src/model/lap.dart';
import 'package:anim_clock/src/storage/sprefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainProvider = StateNotifierProvider<MainNotifier, MainState>(
  (ref) {
    // https://stackoverflow.com/questions/66409658/flutter-riverpod-need-to-get-old-state-from-statenotifierprovider-before-updati
    // When delete an item in history, the state of mainProvider
    // I want to delete the this item in mainProvider too
    // If I use ref.watch(historyProvider) to get history list, but two list are different
    // How can I get the id of the item I want to delete?
    // And if I can have the id, this function still return brand new MainNotifier object

    ref.watch(historyProvider);

    return MainNotifier();
  },
);

class MainNotifier extends StateNotifier<MainState> {
  MainNotifier() : super(MainState.initial());

  void toggleRunning() {
    state = state.copyWith(isRunning: !state.isRunning);
  }

  void reset() {
    state = state.copyWith(isRunning: false, currentLap: 1, laps: []);
  }

  Future<void> addLap(String name, Duration elapsed) async {
    if (state.isRunning) {
      final newLap = Lap.create(
        name: '$name ${state.currentLap}',
        elapsed: elapsed.inMilliseconds,
      );
      state = state.copyWith(
        currentLap: state.currentLap + 1,
        laps: [
          ...state.laps,
          newLap,
        ],
      );

      await SPref.insertData(newLap);
    }
  }

  Future<void> removeLap(int index) async {
    if (index < 0 || index >= state.laps.length) {
      return;
    }

    final List<Lap> newLaps = [...state.laps];
    final removedLap = newLaps.removeAt(index);

    state = state.copyWith(
      laps: newLaps,
    );

    await SPref.removeData(removedLap);
  }

  Future<void> editLap(Lap lap) async {
    final List<Lap> newLaps = state.laps.map((e) {
      if (e.id == lap.id) {
        return lap;
      }

      return e;
    }).toList();

    state = state.copyWith(
      laps: newLaps,
    );

    await SPref.updateData(lap);
  }
}
