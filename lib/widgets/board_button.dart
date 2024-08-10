import 'package:flutter/material.dart';

class BoardButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;

  const BoardButton({
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}
