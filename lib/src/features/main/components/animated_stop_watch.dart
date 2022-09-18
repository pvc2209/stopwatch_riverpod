import 'package:andesgroup_common/common.dart';
import 'package:anim_clock/src/features/main/components/eslapted_time_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimatedStopwatch extends StatefulWidget {
  const AnimatedStopwatch({Key? key}) : super(key: key);

  @override
  State<AnimatedStopwatch> createState() => AnimatedStopwatchState();
}

class AnimatedStopwatchState extends State<AnimatedStopwatch>
    with SingleTickerProviderStateMixin {
  Duration _previouslyElapsed = Duration.zero;
  Duration _currentlyElapsed = Duration.zero;

  Duration get elapsed => _previouslyElapsed + _currentlyElapsed;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        _currentlyElapsed = elapsed;
      });
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void toggleRunning(bool isRunning) {
    setState(() {
      if (isRunning) {
        _ticker.start();
      } else {
        _ticker.stop();
        _previouslyElapsed += _currentlyElapsed;
        _currentlyElapsed = Duration.zero;
      }
    });
  }

  void reset() {
    _ticker.stop();
    setState(() {
      _previouslyElapsed = Duration.zero;
      _currentlyElapsed = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElapsedTimeText(
      elapsed: elapsed,
    );
  }
}
