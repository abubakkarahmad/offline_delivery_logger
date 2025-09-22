import 'dart:math';

class Location {
  final double lat;
  final double lng;
  Location(this.lat, this.lng);
}

class LocationService {
  final Random _rand;
  LocationService({int? seed}) : _rand = Random(seed);

  // London bbox: lat: 51.48..51.56, lng: -0.21..-0.05
  Location randomLondon() {
    final lat = 51.48 + _rand.nextDouble() * (51.56 - 51.48);
    final lng = -0.21 + _rand.nextDouble() * (-0.05 + 0.21);
    return Location(
      double.parse(lat.toStringAsFixed(6)),
      double.parse(lng.toStringAsFixed(6)),
    );
  }
}
