import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venues_app/core/design_system/ds_tokens.dart';
import 'package:venues_app/core/wrappers/injection/injection_service.dart';
import 'package:venues_app/features/near_venues/presentation/controller/near_venues_cubit.dart';
import 'package:venues_app/features/near_venues/presentation/near_venues_list_error.dart';
import 'package:venues_app/features/near_venues/presentation/near_venues_list_loaded.dart';
import 'package:venues_app/features/near_venues/presentation/near_venues_list_loading.dart';

class NearVenuesListPage extends StatelessWidget {
  const NearVenuesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NearVenuesCubit>(
      create: (_) => InjectionService.get<NearVenuesCubit>()..fetchData(),
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: const Text('Venues Near You'),
                  centerTitle: true,
                  titleTextStyle: Theme.of(context).textTheme.headlineSmall,
                  floating: false,
                  snap: false,
                ),
              ];
            },
            body: BlocBuilder<NearVenuesCubit, NearVenuesState>(
                builder: (context, state) {
              if (state is NearVenuesLoadedState) {
                return NearVenuesListLoaded(
                  venuesList: state.venuesList,
                  onFavoritePressed: (index) => context
                      .read<NearVenuesCubit>()
                      .toggleVenueFavorite(index),
                );
              }

              if (state is NearVenuesErrorState) {
                return NearVenuesError(
                  errorTitle: state.errorTitle,
                  errorMessage: state.errorMessage,
                  onRetryPressed: () =>
                      context.read<NearVenuesCubit>().fetchData(),
                );
              }

              return const NearVenuesListLoading();
            }),
          ),
        ),
      ),
    );
  }
}
