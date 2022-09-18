import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({Key? key, this.onPressed}) : super(key: key);
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.purple,
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
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            'RESET',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
