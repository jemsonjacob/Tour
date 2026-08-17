import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_sizes.dart';

import 'package:tourexplorer/feature/home/presentation/bloc/home_bloc.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/hero_image.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/home_header.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/home_searchbar.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/popular_destinations.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/recommended_place.dart';

class HomeScreen extends StatefulWidget {
  final void Function(String? query) onOpenExplore;

  const HomeScreen({super.key, required this.onOpenExplore});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(const LoadHomePlacesEvent());
  }

  Future<void> _refresh() async {
    context.read<HomeBloc>().add(const LoadHomePlacesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  // Background image
                  const HomeHero(),
                  // Header
                  const Positioned(
                    top: 20,
                    left: 16,
                    right: 16,
                    child: HomeHeader(),
                  ),
                  // Search bar
                  Positioned(
                    top: 120,
                    left: 16,
                    right: 16,
                    child: HomeSearchBar(
                      onSearch: (query) {
                        widget.onOpenExplore.call(query);
                      },
                    ),
                  ),
                ],
              ),
              const PopularDestinations(),
              const SizedBox(height: AppSizes.xl),
              const RecommendedPlaces(),
            ],
          ),
        ),
      ),
    );
  }
}
