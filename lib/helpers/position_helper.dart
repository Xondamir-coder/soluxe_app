import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled; don't continue.
    return Future.error('Location services are disabled.');
  }

  // Check the current permission status.
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Request permission if not granted.
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied.
      return Future.error('Location permissions are denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // Permissions are granted, so get the current position.
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
