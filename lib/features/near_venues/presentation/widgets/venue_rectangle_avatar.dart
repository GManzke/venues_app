import 'package:flutter/material.dart';
import 'package:venues_app/core/design_system/ds_loading.dart';
import 'package:venues_app/core/design_system/ds_tokens.dart';

class VenueRectangleAvatar extends StatelessWidget {
  final String imageUrl;

  const VenueRectangleAvatar({
    super.key,
    required this.imageUrl,
  });

  static const double imageSize = 56.0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        DSTokens.s8,
      ),
      child: Image.network(
        imageUrl,
        width: imageSize,
        height: imageSize,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded || frame != null) {
            return child;
          }

          return DSLoading(
            child: Container(
              width: imageSize,
              height: imageSize,
              color: Colors.grey.shade300,
            ),
          );
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
