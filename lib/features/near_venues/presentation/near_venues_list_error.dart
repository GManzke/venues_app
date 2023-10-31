import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:venues_app/core/design_system/ds_assets.dart';
import 'package:venues_app/core/design_system/ds_button.dart';
import 'package:venues_app/core/design_system/ds_tokens.dart';

class NearVenuesError extends StatelessWidget {
  final String errorTitle;
  final String errorMessage;
  final VoidCallback onRetryPressed;

  const NearVenuesError({
    super.key,
    required this.errorTitle,
    required this.errorMessage,
    required this.onRetryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DSTokens.s24,
        vertical: DSTokens.s48,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ExcludeSemantics(
              child: Lottie.asset(
                DSAssets.noInternetConnectionLottie,
                fit: BoxFit.fitWidth,
                repeat: false,
              ),
            ),
          ),
          const SizedBox(
            height: DSTokens.s24,
          ),
          MergeSemantics(
            child: Column(
              children: [
                Text(
                  errorTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: DSTokens.s8,
                ),
                Text(
                  errorMessage,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: DSTokens.s48,
          ),
          DSButton(
            label: 'Try Again',
            semanticsHint: 'Double tap to try load the venues again',
            onPressed: onRetryPressed,
          ),
        ],
      ),
    );
  }
}
