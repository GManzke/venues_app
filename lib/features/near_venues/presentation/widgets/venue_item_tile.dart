import 'package:flutter/material.dart';
import 'package:venues_app/core/design_system/ds_tokens.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';
import 'package:venues_app/features/near_venues/presentation/widgets/venue_rectangle_avatar.dart';

class VenueItemTile extends StatelessWidget {
  final VenueLargeItemEntity venue;
  final VoidCallback onFavoritePressed;

  const VenueItemTile({
    super.key,
    required this.venue,
    required this.onFavoritePressed,
  });

  static const double _paddingUntilContent =
      DSTokens.s24 + VenueRectangleAvatar.imageSize + DSTokens.s16;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: DSTokens.s24,
          ),
          leading: VenueRectangleAvatar(
            imageUrl: venue.image.url,
          ),
          title: Text(
            venue.info.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: venue.info.shortDescription != null
              ? Text(
                  venue.info.shortDescription!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                )
              : null,
          trailing: IconButton(
            icon: Icon(
              venue.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () {
              onFavoritePressed();
            },
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
