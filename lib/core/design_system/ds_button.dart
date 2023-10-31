import 'package:flutter/material.dart';
import 'package:venues_app/core/design_system/ds_tokens.dart';

class DSButton extends StatelessWidget {
  final String label;
  final String semanticsHint;
  final VoidCallback onPressed;

  const DSButton({
    super.key,
    required this.label,
    required this.semanticsHint,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      hint: semanticsHint,
      excludeSemantics: true,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          height: DSTokens.s48,
          alignment: Alignment.center,
          child: Text(label),
        ),
      ),
    );
  }
}
