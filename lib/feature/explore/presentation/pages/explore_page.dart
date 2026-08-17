import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_sizes.dart';
import 'package:tourexplorer/core/custom/app_text_style.dart';
import 'package:tourexplorer/feature/explore/presentation/bloc/explore_bloc.dart';
import 'package:tourexplorer/feature/explore/presentation/bloc/explore_event.dart';
import 'package:tourexplorer/feature/explore/presentation/bloc/explore_state.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/category_chip.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/home_searchbar.dart';
import 'package:tourexplorer/feature/home/presentation/widgets/destination_card.dart';
import 'package:tourexplorer/feature/place_details/presentation/pages/place_details_page.dart';

class ExploreScreen extends StatefulWidget {
  final String? initialQuery;

  const ExploreScreen({super.key, this.initialQuery});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> categories = const [
    'Attraction',
    'Beach',
    'Museum',
    'Temple',
    'Park',
    'Fort',
  ];

  String selectedCategory = 'Attraction';

  @override
  void initState() {
    super.initState();

    final query = widget.initialQuery?.trim();

    context.read<ExploreBloc>().add(
      SearchPlacesEvent(
        query: query == null || query.isEmpty ? 'Attraction' : query,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      _searchController.clear();
    });

    context.read<ExploreBloc>().add(SearchPlacesEvent(query: category));
  }

  void _onSearch(String query) {
    final value = query.trim();

    if (value.isEmpty) {
      context.read<ExploreBloc>().add(
        SearchPlacesEvent(query: selectedCategory),
      );
      return;
    }

    context.read<ExploreBloc>().add(SearchPlacesEvent(query: value));
  }

  Future<void> _refresh() async {
    context.read<ExploreBloc>().add(
      SearchPlacesEvent(
        query: _searchController.text.trim().isEmpty
            ? selectedCategory
            : _searchController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            padding: const EdgeInsets.all(AppSizes.md),
            children: [
              /// Header
              Text('Explore', style: AppTextStyles.heading1),

              const SizedBox(height: 4),

              const Text(
                'Discover amazing places around you',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: AppSizes.lg),
              HomeSearchBar(controller: _searchController, onSearch: _onSearch),

              const SizedBox(height: AppSizes.lg),

              CategoryChips(
                categories: categories,
                selectedCategory: selectedCategory,
                onSelected: _onCategorySelected,
              ),

              const SizedBox(height: AppSizes.xl),

              BlocBuilder<ExploreBloc, ExploreState>(
                builder: (context, state) {
                  if (state is ExploreLoading) {
                    return SizedBox(
                      height: 220,
                      child: Center(
                        child: Lottie.asset("assets/animations/Travel.json"),
                      ),
                    );
                  }

                  if (state is ExploreError) {
                    return SizedBox(
                      height: 300,
                      child: Center(child: Text(state.message)),
                    );
                  }

                  if (state is ExploreLoaded) {
                    if (state.places.isEmpty) {
                      return const SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            'No places found',
                            style: TextStyle(color: AppColors.backgroundColor),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.places.length,
                      separatorBuilder: (_, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final place = state.places[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlaceDetailsScreen(placeDetails: place),
                              ),
                            );
                          },
                          child: DestinationCard(place: place),
                        );
                      },
                    );
                  }

                  return const SizedBox(height: 300);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
