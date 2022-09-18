import 'package:anim_clock/src/model/lap.dart';

class HistoryState {
  final List<Lap> laps;

  HistoryState({
    required this.laps,
  });

  factory HistoryState.initial() {
    return HistoryState(
      laps: [],
    );
  }

  HistoryState copyWith({
    List<Lap>? laps,
  }) {
    return HistoryState(
      laps: laps ?? this.laps,
    );
  }
}
