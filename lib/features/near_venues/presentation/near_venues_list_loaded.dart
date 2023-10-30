import 'package:flutter/material.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';
import 'package:venues_app/features/near_venues/presentation/widgets/venue_item_tile.dart';

class NearVenuesListLoaded extends StatelessWidget {
  final List<VenueLargeItemEntity> venuesList;
  final Function(int index) onFavoritePressed;

  static const _newVenuesSlideDuration = Duration(milliseconds: 400);

  const NearVenuesListLoaded({
    super.key,
    required this.venuesList,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: venuesList.length,
      itemBuilder: (context, index) {
        return AnimatedSwitcher(
          duration: _newVenuesSlideDuration,
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          child: VenueItemTile(
            key: ValueKey(venuesList[index].info.id),
            venue: venuesList[index],
            onFavoritePressed: () => onFavoritePressed(
              index,
            ),
            isLastItem: index == venuesList.length - 1,
          ),
        );
      },
    );
  }
}
