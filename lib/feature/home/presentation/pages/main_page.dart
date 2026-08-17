import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/feature/explore/presentation/bloc/explore_bloc.dart';
import 'package:tourexplorer/feature/explore/presentation/bloc/explore_event.dart';
import 'package:tourexplorer/feature/explore/presentation/pages/explore_page.dart';
import 'package:tourexplorer/feature/home/presentation/bloc/home_bloc.dart';
import 'package:tourexplorer/feature/home/presentation/pages/home_page.dart';
import 'package:tourexplorer/feature/profile/presentation/pages/profile_page.dart';
import 'package:tourexplorer/feature/saved_places/presentation/bloc/saved_places/saved_bloc.dart';
import 'package:tourexplorer/feature/saved_places/presentation/bloc/saved_places/saved_event.dart';
import 'package:tourexplorer/feature/saved_places/presentation/pages/saved_page.dart';
import 'package:tourexplorer/injection_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (_) => sl<HomeBloc>()),
        BlocProvider<ExploreBloc>(create: (_) => sl<ExploreBloc>()),
        BlocProvider(
          create: (_) =>
              sl<SavedPlaceBloc>()..add(const LoadSavedPlacesEvent()),
        ),
      ],

      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor,

            body: IndexedStack(
              index: _currentIndex,
              children: [
                HomeScreen(
                  onOpenExplore: (query) {
                    // Switch to Explore
                    setState(() {
                      _currentIndex = 1;
                    });

                    // Search if Home provided a query
                    if (query != null && query.trim().isNotEmpty) {
                      context.read<ExploreBloc>().add(
                        SearchPlacesEvent(query: query.trim()),
                      );
                    }
                  },
                ),

                const ExploreScreen(),
                const SavedScreen(),
                const ProfileScreen(),
              ],
            ),

            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.whiteColor,
              currentIndex: _currentIndex,

              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
                //if on saved page load the event
                if (value == 2) {
                  context.read<SavedPlaceBloc>().add(
                    const LoadSavedPlacesEvent(),
                  );
                }
              },

              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.backgroundColor,
              unselectedItemColor: Colors.grey,
              elevation: 4,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Saved'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
