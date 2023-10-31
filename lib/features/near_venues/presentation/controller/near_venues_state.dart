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

class NearVenuesErrorState extends NearVenuesState {
  final String errorTitle;
  final String errorMessage;

  NearVenuesErrorState.network({
    this.errorTitle = 'No Internet Connection',
    this.errorMessage = 'Check your connection and try again',
  });

  NearVenuesErrorState.unknown({
    this.errorTitle = 'Something went wrong',
    this.errorMessage = 'Please try again later',
  });
}
