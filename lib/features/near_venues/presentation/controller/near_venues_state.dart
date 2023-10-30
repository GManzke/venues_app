part of 'near_venues_cubit.dart';

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
