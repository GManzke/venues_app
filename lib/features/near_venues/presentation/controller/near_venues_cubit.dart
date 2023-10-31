import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';
import 'package:venues_app/core/wrappers/log_service/log_service.dart';
import 'package:venues_app/features/near_venues/domain/errors/near_venues_errors.dart';
import 'package:venues_app/features/near_venues/domain/fetch_near_venues_use_case.dart';
import 'package:venues_app/features/near_venues/domain/remove_venue_from_favorites_use_case.dart';
import 'package:venues_app/features/near_venues/domain/save_venue_as_favorite_use_case.dart';

part 'near_venues_state.dart';

class NearVenuesCubit extends Cubit<NearVenuesState> {
  final FetchNearVenuesUseCase fetchNearVenuesUseCase;
  final SaveVenueAsFavoriteUseCase saveFavoriteVenueUseCase;
  final RemoveVenueFromFavoritesUseCase removeFavoriteVenueUseCase;

  Timer? _refreshTimer;

  static const _refreshInterval = Duration(seconds: 10);

  NearVenuesCubit({
    required this.fetchNearVenuesUseCase,
    required this.saveFavoriteVenueUseCase,
    required this.removeFavoriteVenueUseCase,
  }) : super(NearVenuesLoadingState());

  Future<void> fetchData() async {
    emit(NearVenuesLoadingState());
    try {
      final venuesList = await fetchNearVenuesUseCase();

      _startRefreshTimer();

      emit(NearVenuesLoadedState(venuesList: venuesList));
    } on NearVenuesNetworkException {
      emit(NearVenuesErrorState.network());
    } catch (e) {
      LogService.error('[Near Venues Cubit]:', e);
      emit(NearVenuesErrorState.unknown());
    }
  }

  void _startRefreshTimer() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      _refreshInterval,
      (_) => refreshData(),
    );
  }

  Future<void> refreshData() async {
    try {
      final updatedList = await fetchNearVenuesUseCase();

      emit(NearVenuesLoadedState(venuesList: updatedList));
    } catch (e) {
      LogService.error('[Near Venues Cubit]:', e);
      return;
    }
  }

  void toggleVenueFavorite(int index) async {
    final currentState = state as NearVenuesLoadedState;
    final venue = currentState.venuesList[index];

    if (venue.isFavorite) {
      removeFavoriteVenueUseCase(venue.id);
    } else {
      saveFavoriteVenueUseCase(venue.id);
    }

    var updatedVenuesList = List.of(currentState.venuesList);
    updatedVenuesList[index] = venue.copyWith(isFavorite: !venue.isFavorite);

    emit(NearVenuesLoadedState(venuesList: updatedVenuesList));
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    return super.close();
  }
}
