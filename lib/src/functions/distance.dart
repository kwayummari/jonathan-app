import 'package:daladala_smart/src/service/map-serivces.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
class distanceFunction {
  Position? position;
   getHome(live_location) async {
    final mapService _mapService = await mapService();
    position = await _mapService.determinePosition();
    String coordinates = live_location;
    List<String> parts = coordinates.split('-');
    double latitude = double.parse(parts[0]);
    double longitude = double.parse(parts[1]);
    var actualDistance = await distance(latitude, longitude, position!.latitude, position!.longitude);
    return actualDistance;
  }

  double distance(double lat1, double lon1, double lat2, double lon2) {
    const double radius = 6371; // radius of the earth in kilometers

    double dLat = radians(lat2 - lat1);
    double dLon = radians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(radians(lat1)) *
            cos(radians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = radius * c;

    return distance; // in kilometers
  }

  double radians(double degrees) {
    return degrees * pi / 180;
  }
}