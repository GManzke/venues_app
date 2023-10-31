import 'package:flutter/material.dart';

class DSIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String semanticsLabel;
  final String semanticsHint;

  const DSIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticsLabel,
    required this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      button: true,
      excludeSemantics: true,
      child: IconButton(
        icon: Icon(
          icon,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
