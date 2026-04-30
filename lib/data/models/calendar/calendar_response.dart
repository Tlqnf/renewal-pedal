class CalendarResponse {
  final int year;
  final int month;
  final List<int> activeDays;
  final CalendarMonthlySummary monthlySummary;
  final List<CalendarWeekItem> weeks;

  const CalendarResponse({
    required this.year,
    required this.month,
    required this.activeDays,
    required this.monthlySummary,
    required this.weeks,
  });

  factory CalendarResponse.fromJson(Map<String, dynamic> json) {
    return CalendarResponse(
      year: json['year'] as int,
      month: json['month'] as int,
      activeDays: (json['active_days'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      monthlySummary: CalendarMonthlySummary.fromJson(
        json['monthly_summary'] as Map<String, dynamic>,
      ),
      weeks: (json['weeks'] as List<dynamic>)
          .map((e) => CalendarWeekItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CalendarMonthlySummary {
  final double distanceKm;
  final double avgPaceKmh;
  final int durationSec;
  final int caloriesKcal;

  const CalendarMonthlySummary({
    required this.distanceKm,
    required this.avgPaceKmh,
    required this.durationSec,
    required this.caloriesKcal,
  });

  factory CalendarMonthlySummary.fromJson(Map<String, dynamic> json) {
    return CalendarMonthlySummary(
      distanceKm: (json['distance_km'] as num).toDouble(),
      avgPaceKmh: (json['avg_pace_kmh'] as num).toDouble(),
      durationSec: json['duration_sec'] as int,
      caloriesKcal: json['calories_kcal'] as int,
    );
  }
}

class CalendarWeekItem {
  final String label;
  final String startDate;
  final String endDate;
  final List<CalendarRideItem> rides;

  const CalendarWeekItem({
    required this.label,
    required this.startDate,
    required this.endDate,
    required this.rides,
  });

  factory CalendarWeekItem.fromJson(Map<String, dynamic> json) {
    return CalendarWeekItem(
      label: json['label'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      rides: (json['rides'] as List<dynamic>)
          .map((e) => CalendarRideItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CalendarRideItem {
  final int day;
  final String date;
  final double distanceKm;
  final int durationSec;
  final double avgPaceKmh;
  final int caloriesKcal;

  const CalendarRideItem({
    required this.day,
    required this.date,
    required this.distanceKm,
    required this.durationSec,
    required this.avgPaceKmh,
    required this.caloriesKcal,
  });

  factory CalendarRideItem.fromJson(Map<String, dynamic> json) {
    return CalendarRideItem(
      day: json['day'] as int,
      date: json['date'] as String,
      distanceKm: (json['distance_km'] as num).toDouble(),
      durationSec: json['duration_sec'] as int,
      avgPaceKmh: (json['avg_pace_kmh'] as num).toDouble(),
      caloriesKcal: json['calories_kcal'] as int,
    );
  }
}
