import 'package:flutter/material.dart';

class StartStopButton extends StatelessWidget {
  const StartStopButton({Key? key, required this.isRunning, this.onPressed})
      : super(key: key);
  final bool isRunning;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isRunning ? Colors.red : Colors.green,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12.0),
        bottomRight: Radius.circular(12.0),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            isRunning ? 'Stop' : 'Start',
          ),
        ),
      ),
    );
  }
}
