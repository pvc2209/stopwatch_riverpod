import 'package:flutter/material.dart';

class ElapsedTimeText extends StatelessWidget {
  const ElapsedTimeText({
    Key? key,
    required this.elapsed,
  }) : super(key: key);
  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    final hundreds = (elapsed.inMilliseconds / 10) % 100;
    final seconds = elapsed.inSeconds % 60;
    final minutes = elapsed.inMinutes % 60;
    final hundredsStr = hundreds.toStringAsFixed(0).padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');
    final minutesStr = minutes.toString().padLeft(2, '0');
    const digitWidth = 28.0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TimeDigit(minutesStr.substring(0, 1), width: digitWidth),
          TimeDigit(minutesStr.substring(1, 2), width: digitWidth),
          const TimeDigit(':', width: 12),
          TimeDigit(secondsStr.substring(0, 1), width: digitWidth),
          TimeDigit(secondsStr.substring(1, 2), width: digitWidth),
          const TimeDigit('.', width: 12),
          TimeDigit(hundredsStr.substring(0, 1), width: digitWidth),
          TimeDigit(hundredsStr.substring(1, 2), width: digitWidth),
        ],
      ),
    );
  }
}

class TimeDigit extends StatelessWidget {
  const TimeDigit(this.text, {Key? key, required this.width}) : super(key: key);
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: const TextStyle(fontSize: 48.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}
