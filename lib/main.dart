import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tourexplorer/core/custom/app_theme.dart';
import 'package:tourexplorer/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:tourexplorer/feature/saved_places/data/models/saved_place_model.dart';
import 'package:tourexplorer/feature/splash/presentation/page/splash_page.dart';
import 'package:tourexplorer/firebase_options.dart';
import 'package:tourexplorer/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase initialize
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();

  Hive.registerAdapter(SavedPlaceModelAdapter());

  await Hive.openBox<SavedPlaceModel>('saved_places');

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => sl<AuthBloc>()..add(const AuthCheckEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tour Explorer',
        theme: AppTheme.darkThemeMode,
        home: const SplashPage(),
      ),
    );
  }
}
