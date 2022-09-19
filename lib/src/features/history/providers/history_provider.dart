import 'package:anim_clock/src/features/history/providers/history_state.dart';
import 'package:anim_clock/src/model/lap.dart';
import 'package:anim_clock/src/storage/sprefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyProvider = StateNotifierProvider<HistoryNotifier, HistoryState>(
  (ref) => HistoryNotifier(),
);

class HistoryNotifier extends StateNotifier<HistoryState> {
  HistoryNotifier() : super(HistoryState.initial());

  Future<void> loadLaps() async {
    final laps = await SPref.getData();
    state = state.copyWith(laps: laps);
  }

  Future<void> removeLap(Lap lap) async {
    await SPref.removeData(lap);
    final List<Lap> newLaps = await SPref.getData();
    state = state.copyWith(
      laps: newLaps,
    );
  }

  Future<void> editLap(Lap lap) async {
    await SPref.updateData(lap);
    final List<Lap> newLaps = await SPref.getData();
    state = state.copyWith(
      laps: newLaps,
    );
  }
}
