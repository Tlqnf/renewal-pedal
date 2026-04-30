import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/models/calendar/calendar_response.dart';

class CalendarRemoteSource {
  final DioClient _client;

  CalendarRemoteSource(this._client);

  Future<CalendarResponse> getCalendar({
    required int year,
    required int month,
  }) async {
    final response = await _client.get(
      '/users/me/calendar',
      queryParameters: {'year': year, 'month': month},
    );
    return CalendarResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
