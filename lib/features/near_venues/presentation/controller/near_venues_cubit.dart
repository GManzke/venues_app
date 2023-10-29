import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venues_app/features/near_venues/domain/fetch_near_venues_use_case.dart';
import 'package:venues_app/features/near_venues/domain/remove_venue_from_favorites_use_case.dart';
import 'package:venues_app/features/near_venues/domain/save_venue_as_favorite_use_case.dart';
import 'package:venues_app/features/near_venues/presentation/controller/near_venues_state.dart';

class NearVenuesCubit extends Cubit<NearVenuesState> {
  final FetchNearVenuesUseCase fetchNearVenuesUseCase;
  final SaveVenueAsFavoriteUseCase saveFavoriteVenueUseCase;
  final RemoveVenueFromFavoritesUseCase removeFavoriteVenueUseCase;

  NearVenuesCubit({
    required this.fetchNearVenuesUseCase,
    required this.saveFavoriteVenueUseCase,
    required this.removeFavoriteVenueUseCase,
  }) : super(NearVenuesLoadingState());

  Future<void> fetchData() async {
    emit(NearVenuesLoadingState());
    try {
      final venuesList = await fetchNearVenuesUseCase();

      emit(NearVenuesLoadedState(venuesList: venuesList));
    } catch (e) {
      emit(NearVenuesErrorState());
    }
  }

  void saveVenueAsFavorite(int index, String venueID) async {
    final currentState = state as NearVenuesLoadedState;

    saveFavoriteVenueUseCase(venueID);

    var updatedVenuesList = List.of(currentState.venuesList);
    updatedVenuesList[index] =
        updatedVenuesList[index].copyWith(isFavorite: true);

    emit(NearVenuesLoadedState(venuesList: updatedVenuesList));
  }

  void removeVenueFromFavorites(int index, String venueID) async {
    final currentState = state as NearVenuesLoadedState;

    removeFavoriteVenueUseCase(venueID);

    var updatedVenuesList = List.of(currentState.venuesList);
    updatedVenuesList[index] =
        updatedVenuesList[index].copyWith(isFavorite: false);

    emit(NearVenuesLoadedState(venuesList: updatedVenuesList));
  }
}
