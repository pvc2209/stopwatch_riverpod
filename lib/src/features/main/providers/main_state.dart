import 'package:anim_clock/src/model/lap.dart';

class MainState {
  final bool isRunning;
  final int currentLap;
  final List<Lap> laps;

  MainState({
    required this.isRunning,
    required this.laps,
    required this.currentLap,
  });

  factory MainState.initial() {
    return MainState(
      isRunning: false,
      laps: [],
      currentLap: 1,
    );
  }

  MainState copyWith({
    bool? isRunning,
    int? currentLap,
    List<Lap>? laps,
  }) {
    return MainState(
      isRunning: isRunning ?? this.isRunning,
      currentLap: currentLap ?? this.currentLap,
      laps: laps ?? this.laps,
    );
  }

  @override
  String toString() =>
      'MainState(isRunning: $isRunning, currentLap: $currentLap, laps: $laps)';
}
