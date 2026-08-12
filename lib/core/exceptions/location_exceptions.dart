class LocationServiceDisabledException implements Exception {
  final String message;

  const LocationServiceDisabledException([
    this.message = 'Location services are disabled.',
  ]);

  @override
  String toString() => message;
}

class LocationPermissionDeniedException implements Exception {
  final String message;

  const LocationPermissionDeniedException([
    this.message = 'Location permission was denied.',
  ]);

  @override
  String toString() => message;
}

class LocationPermissionPermanentlyDeniedException implements Exception {
  final String message;

  const LocationPermissionPermanentlyDeniedException([
    this.message = 'Location permission is permanently denied.',
  ]);

  @override
  String toString() => message;
}
