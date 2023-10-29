import 'package:equatable/equatable.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';

abstract class NearVenuesState extends Equatable {
  @override
  List<Object> get props => [];
}

class NearVenuesLoadingState extends NearVenuesState {}

class NearVenuesLoadedState extends NearVenuesState {
  final List<VenueLargeItemEntity> venuesList;

  NearVenuesLoadedState({
    required this.venuesList,
  });

  @override
  List<Object> get props => [venuesList];
}

class NearVenuesErrorState extends NearVenuesState {}
