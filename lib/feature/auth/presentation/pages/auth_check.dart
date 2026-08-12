import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourexplorer/feature/auth/presentation/pages/login_page.dart';
import 'package:tourexplorer/feature/home/presentation/pages/main_page.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Firebase is checks authentication
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // User is logged in
        if (snapshot.hasData) {
          return const MainScreen();
        }

        // User is not logged in
        return const LoginPage();
      },
    );
  }
}
