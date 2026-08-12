import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourexplorer/core/custom/app_theme.dart';
import 'package:tourexplorer/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:tourexplorer/feature/auth/presentation/pages/auth_check.dart';
import 'package:tourexplorer/firebase_options.dart';
import 'package:tourexplorer/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => sl<AuthBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tour Explorer',
        theme: AppTheme.darkThemeMode,
        home: const AuthCheck(),
      ),
    );
  }
}
