import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pedal/common/components/buttons/cancel_button.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/mock/data/terms_mock_data.dart';
import 'package:pedal/services/fcm/fcm_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsViewModel extends ChangeNotifier {
  final Map<String, bool> _agreedTerms = {};

  List<Map<String, dynamic>> get terms => TermsMockData.terms;

  bool isTermAgreed(String id) => _agreedTerms[id] ?? false;

  bool get canConfirm {
    return terms
        .where((term) => term['required'] as bool)
        .every((term) => _agreedTerms[term['id']] ?? false);
  }

  void toggleTerm(String id) {
    _agreedTerms[id] = !(_agreedTerms[id] ?? false);
    notifyListeners();
  }

  Future<void> confirmTerms(BuildContext context) async {
    if (!canConfirm) return;

    // 1. 커스텀 권한 안내 Dialog
    final proceed = await _showPermissionRationaleDialog(context);
    if (!proceed || !context.mounted) return;

    // 2. 위치 권한 요청 (foreground)
    final locationStatus = await Geolocator.requestPermission();

    // 3. 백그라운드 위치 권한 요청 (whileInUse 허용 후 always 요청)
    if (locationStatus == LocationPermission.whileInUse) {
      await Geolocator.requestPermission();
    }

    // // 4. 알림 권한 요청 (라이딩 백그라운드 알림 필수 - 광고성 동의 여부 무관)
    // await FirebaseMessaging.instance.requestPermission(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );

    // 5. 광고성 동의 시에만 FCM 알림 권한 요청
    if (_agreedTerms['marketing'] == true) {
      await FcmService().requestPermissionAndRegister();
    }

    // 6. 광고성 동의 여부 로컬 저장
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('marketing_agreed', _agreedTerms['marketing'] ?? false);

    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<bool> _showPermissionRationaleDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => Dialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('권한 안내', style: AppTextStyles.titMdBold),
                  const SizedBox(height: AppSpacing.md),
                  const Text(
                    '페달은 라이딩 기록과 현재 위치 표시를 위해\n'
                    '위치 권한과 알림 권한이 필요합니다.',
                    style: AppTextStyles.txtSm,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: CancelButton(
                          label: '취소',
                          onPressed: () => Navigator.pop(ctx, false),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: PrimaryButton(
                          label: '확인',
                          height: 36,
                          onPressed: () => Navigator.pop(ctx, true),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;
  }
}
