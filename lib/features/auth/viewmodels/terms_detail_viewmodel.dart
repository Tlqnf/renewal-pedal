import 'package:flutter/foundation.dart';
import 'package:pedal/mock/data/terms_mock_data.dart';

class TermsDetailViewModel extends ChangeNotifier {
  final String termsId;
  late String title;
  late List<Map<String, String>> sections;

  TermsDetailViewModel(this.termsId) {
    _loadTermsDetail();
  }

  void _loadTermsDetail() {
    final detail = TermsMockData.termsDetails[termsId];
    if (detail != null) {
      title = detail['title'] as String;
      sections = (detail['sections'] as List)
          .map((s) => Map<String, String>.from(s as Map))
          .toList();
    } else {
      title = '약관';
      sections = [];
    }
  }
}
