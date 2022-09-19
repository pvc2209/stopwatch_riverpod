import 'package:anim_clock/src/features/history/providers/history_provider.dart';
import 'package:anim_clock/src/features/history/providers/history_state.dart';
import 'package:anim_clock/src/features/main/providers/main_state.dart';
import 'package:anim_clock/src/model/lap.dart';
import 'package:anim_clock/src/storage/sprefs.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainProvider = StateNotifierProvider<MainNotifier, MainState>(
  (ref) {
    final MainNotifier notifier = MainNotifier();

    ref.listen<HistoryState>(historyProvider, (previous, next) {
      final List<Lap> oldLaps = previous?.laps ?? [];
      final List<Lap> newLaps = next.laps;

      for (final lap in oldLaps) {
        if (!newLaps.contains(lap)) {
          notifier.update(lap);
          break;
        }
      }
    });

    return notifier;
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

  // Remove lap from the list without delete it from storage
  // because lap has been deleted in history
  void update(Lap lap) {
    final List<Lap> newLaps = state.laps.where((e) => e.id != lap.id).toList();

    state = state.copyWith(
      laps: newLaps,
    );
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

  Future<void> removeLap(Lap lap) async {
    final List<Lap> newLaps = state.laps.where((e) => e.id != lap.id).toList();

    state = state.copyWith(
      laps: newLaps,
    );

    await SPref.removeData(lap);
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
