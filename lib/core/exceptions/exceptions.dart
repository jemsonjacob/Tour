import 'package:firebase_auth/firebase_auth.dart';

class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}

class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);
}

//firebase exceptions
String handleAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return 'User not found. Please register first.';

    case 'wrong-password':
      return 'Incorrect password. Please try again.';

    case 'email-already-in-use':
      return 'Email already registered.';

    case 'weak-password':
      return 'Password must be at least 6 characters.';

    case 'invalid-email':
      return 'Invalid email format.';

    case 'too-many-requests':
      return 'Too many attempts. Try later.';

    case 'invalid-phone-number':
      return 'Invalid phone number format.';

    case 'invalid-verification-code':
      return 'Invalid OTP code.';

    case 'session-expired':
      return 'Session expired. Request OTP again.';

    default:
      return e.message ?? 'Authentication error occurred.';
  }
}
