import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:venues_app/core/design_system/ds_assets.dart';
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
            child: Lottie.asset(
              DSAssets.noInternetConnectionLottie,
              fit: BoxFit.fitWidth,
              repeat: false,
            ),
          ),
          const SizedBox(
            height: DSTokens.s24,
          ),
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
          const SizedBox(
            height: DSTokens.s48,
          ),
          ElevatedButton(
            onPressed: () => onRetryPressed(),
            child: Container(
              width: double.infinity,
              height: DSTokens.s48,
              alignment: Alignment.center,
              child: const Text('Try Again'),
            ),
          ),
        ],
      ),
    );
  }
}
