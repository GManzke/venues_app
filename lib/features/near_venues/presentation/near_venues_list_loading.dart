import 'package:flutter/material.dart';
import 'package:venues_app/core/design_system/ds_loading.dart';
import 'package:venues_app/core/design_system/ds_tokens.dart';

class NearVenuesListLoading extends StatelessWidget {
  const NearVenuesListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return DSLoading(
      child: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return const _VenueItemLoading();
        },
      ),
    );
  }
}

class _VenueItemLoading extends StatelessWidget {
  const _VenueItemLoading();

  static const double _imageSize = 56.0;
  static const double _paddingUntilContent =
      DSTokens.s24 + _imageSize + DSTokens.s16;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: DSTokens.s24,
          ),
          title: Container(
            height: DSTokens.s16,
            color: Colors.grey.shade300,
          ),
          subtitle: Container(
            height: DSTokens.s12,
            color: Colors.grey.shade300,
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(
              DSTokens.s8,
            ),
            child: Container(
              width: _imageSize,
              height: _imageSize,
              color: Colors.grey.shade300,
            ),
          ),
        ),
        const Divider(
          indent: _paddingUntilContent,
          endIndent: DSTokens.s24,
        ),
      ],
    );
  }
}
