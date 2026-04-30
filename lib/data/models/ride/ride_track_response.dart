class RideTrackResponse {
  final String polyline;

  const RideTrackResponse({required this.polyline});

  factory RideTrackResponse.fromJson(Map<String, dynamic> json) =>
      RideTrackResponse(polyline: (json['polyline'] ?? '') as String);

  /// Google Encoded Polyline → [[lat, lng], ...] 디코딩
  List<List<double>> decodePolyline() {
    final result = <List<double>>[];
    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < polyline.length) {
      int b;
      int shift = 0;
      int result2 = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result2 |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (result2 & 1) != 0 ? ~(result2 >> 1) : (result2 >> 1);

      shift = 0;
      result2 = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result2 |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result2 & 1) != 0 ? ~(result2 >> 1) : (result2 >> 1);

      result.add([lat / 1e5, lng / 1e5]);
    }

    return result;
  }
}
