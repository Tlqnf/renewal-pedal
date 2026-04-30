class RidePointIn {
  final double lat;
  final double lng;

  const RidePointIn({required this.lat, required this.lng});

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}
