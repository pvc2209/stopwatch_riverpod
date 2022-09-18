import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:anim_clock/src/model/lap.dart';

class LapCard extends StatelessWidget {
  const LapCard({
    Key? key,
    required this.lap,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  final Lap lap;
  final VoidCallback? onDelete;
  final Function(String)? onTap;

  String _getLapTime(Duration elapsed) {
    final hundreds = (elapsed.inMilliseconds / 10) % 100;
    final seconds = elapsed.inSeconds % 60;
    final minutes = elapsed.inMinutes % 60;
    final hundredsStr = hundreds.toStringAsFixed(0).padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');
    final minutesStr = minutes.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr.$hundredsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: () {
              onTap?.call(lap.name);
            },
            borderRadius: BorderRadius.circular(8),
            child: ListTile(
              leading: const Icon(Bootstrap.clock_history),
              title: Text(
                '${lap.name}: ${_getLapTime(Duration(milliseconds: lap.elapsed))}',
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              trailing: IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  Bootstrap.trash,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
