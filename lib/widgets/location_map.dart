import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class LocationMap extends StatelessWidget {
  final double latitude;
  final double longitude;

  const LocationMap({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(latitude, longitude),
      ),
      mapController: MapController(),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.soluxe',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(latitude, longitude),
              width: 40,
              height: 40,
              child: SvgPicture.asset('assets/icons/circle-pin.svg'),
            ),
          ],
        ),
      ],
    );
  }
}
