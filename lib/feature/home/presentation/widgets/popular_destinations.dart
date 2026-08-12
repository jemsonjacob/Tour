import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_sizes.dart';
import 'package:tourexplorer/core/custom/app_text_style.dart';
import 'package:tourexplorer/feature/home/presentation/bloc/home_bloc.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/destination_card.dart';
import 'package:tourexplorer/feature/place_details/presentation/bloc/place_details_bloc.dart';
import 'package:tourexplorer/feature/place_details/presentation/pages/place_details_page.dart';
import 'package:tourexplorer/injection_container.dart';

class PopularDestinations extends StatelessWidget {
  const PopularDestinations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Popular Places', style: AppTextStyles.heading1),
        const SizedBox(height: AppSizes.md),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLocationRequired) {
              _showLocationDialog(
                context,
                permanentlyDenied: state.permissionPermanentlyDenied,
              );
            }

            if (state is HomeLoading) {
              return const SizedBox(
                height: 220,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is HomeError) {
              return SizedBox(
                height: 220,
                child: Center(
                  child: Text(
                    state.message,
                    style: TextStyle(color: AppColors.backgroundColor),
                  ),
                ),
              );
            }

            if (state is HomeLoaded) {
              if (state.popularPlaces.isEmpty) {
                return const SizedBox(
                  height: 220,
                  child: Center(
                    child: Text(
                      'No places found',
                      style: TextStyle(color: AppColors.backgroundColor),
                    ),
                  ),
                );
              }

              return SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.popularPlaces.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // print(state.places[index].runtimeType);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => sl<PlaceDetailsBloc>()
                                ..add(
                                  GetPlaceDetailsEvent(
                                    placeId: state.popularPlaces[index].id,
                                  ),
                                ),
                              child: PlaceDetailsScreen(
                                placeDetails: state.popularPlaces[index],
                              ),
                            ),
                          ),
                        );
                      },
                      child: DestinationCard(place: state.popularPlaces[index]),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }

  Future<void> _showLocationDialog(
    BuildContext context, {
    required bool permanentlyDenied,
  }) async {
    final shouldOpenSettings = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.location_on, color: Colors.redAccent),
              SizedBox(width: 8),
              Text('Location Required'),
            ],
          ),
          content: Text(
            permanentlyDenied
                ? 'Location permission has been permanently denied. '
                      'Please enable it from app settings to find nearby places.'
                : 'Tour Explorer needs your location to find '
                      'nearby destinations.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                permanentlyDenied ? 'Open Settings' : 'Enable Location',
              ),
            ),
          ],
        );
      },
    );

    if (shouldOpenSettings != true) {
      return;
    }

    if (permanentlyDenied) {
      await Geolocator.openAppSettings();
    } else {
      await Geolocator.openLocationSettings();
    }

    // ignore: use_build_context_synchronously
    context.read<HomeBloc>().add(const LoadHomePlacesEvent());
  }
}
