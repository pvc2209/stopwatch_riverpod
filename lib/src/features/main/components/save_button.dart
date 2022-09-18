import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.isRunning,
    required this.size,
    this.onPressed,
  }) : super(key: key);

  final bool isRunning;
  final double size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isRunning ? Colors.blue : Colors.grey,
      borderRadius: BorderRadius.circular(size / 2),
      child: InkWell(
        onTap: isRunning ? onPressed : null,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: const Text(
            'SAVE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.0,
            ),
          ),
        ),
      ),
    );
  }
}
