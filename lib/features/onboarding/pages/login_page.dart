import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pedal/common/components/buttons/cancel_button.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/core/constants/constants.dart';
import 'package:pedal/core/routes/app_routes.dart';
import 'package:pedal/features/onboarding/pages/terms_description_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const double horizontalPadding = 16;
  static const double contentTopSpacing = 85;
  static const double headlineTopSpacing = 24;
  static const double bodyTopSpacing = 26;
  static const double descriptionSpacing = 28;
  static const double buttonSectionSpacing = 12;
  static const double buttonHeight = 48;
  static const double buttonBorderRadius = 8;
  static const double logoSize = 100;
  static const double iconRightSpacing = 16;
  static const double textTrailingSpace = 124;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _showTermsDialog() async {
    await showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.28),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 12),
          child: _TermsDialog(
            onCancel: () => Navigator.of(dialogContext).pop(),
            onConfirm: () {
              Navigator.of(dialogContext).pop();
              context.push(AppRoutes.profileSetting);
            },
            onTermsTap: (label) {
              context.push(
                AppRoutes.termsDetail,
                extra: {
                  'title': label,
                  'sections': <TermsSection>[],
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                LoginPage.horizontalPadding,
                LoginPage.contentTopSpacing,
                LoginPage.horizontalPadding,
                0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 37,),
                          Text(
                            '로그인',
                            style: AppTextStyles.titSm.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: LoginPage.headlineTopSpacing),
                          Text(
                            '신개념 자전거 라이딩을\n즐겨보세요',
                            style: AppTextStyles.tit2xl.copyWith(
                              fontSize: 22,
                              height: 1.4,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: LoginPage.bodyTopSpacing),
                          Text(
                            '페달이 당신만의 맞춤형 서비스를 \n제공하려면 로그인과 약관동의가 필요해요!',
                            style: AppTextStyles.txtLg.copyWith(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        AppConstants.icon,
                        width: LoginPage.logoSize,
                        height: LoginPage.logoSize,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  const Spacer(),
                  _SocialLoginButton(
                    label: '구글 계정으로 계속하기',
                    iconAssetPath: AppConstants.google,
                    backgroundColor: AppColors.surface,
                    foregroundColor: AppColors.gray700,
                    borderColor: AppColors.border,
                    onTap: _showTermsDialog,
                  ),
                  const SizedBox(height: LoginPage.buttonSectionSpacing),
                  _SocialLoginButton(
                    label: '카카오 계정으로 계속하기',
                    iconAssetPath: AppConstants.kakao,
                    backgroundColor: AppColors.kakaoBackground,
                    foregroundColor: AppColors.gray900,
                    onTap: _showTermsDialog,
                  ),
                  const SizedBox(height: LoginPage.buttonSectionSpacing),
                  _SocialLoginButton(
                    label: '네이버 계정으로 계속하기',
                    iconAssetPath: AppConstants.naver,
                    backgroundColor: AppColors.naverBackground,
                    foregroundColor: AppColors.gray0,
                    onTap: _showTermsDialog,
                  ),
                  const SizedBox(height: LoginPage.descriptionSpacing),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TermsDialog extends StatefulWidget {
  const _TermsDialog({
    required this.onCancel,
    required this.onConfirm,
    required this.onTermsTap,
  });

  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final ValueChanged<String> onTermsTap;

  static const double dialogRadius = 16;
  static const double sectionPadding = 16;

  @override
  State<_TermsDialog> createState() => _TermsDialogState();
}

// TODO: 광고성 푸시 알림 수정 필요
class _TermsDialogState extends State<_TermsDialog> {
  late final List<bool> _checkedStates = <bool>[true, false, false, false];

  static const List<String> _labels = [
    '서비스 이용약관 (필수)',
    '개인정보 수집 및 이용 (필수)',
    '위치기반 이용약관 (필수)',
    '광고성 푸시 알림 (선택)',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_TermsDialog.dialogRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(_TermsDialog.sectionPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '페달 서비스 이용약관',
              style: AppTextStyles.titLg.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 1,
              color: AppColors.gray100,
            ),
            const SizedBox(height: 10),
            for (var index = 0; index < _labels.length; index++) ...[
              _AgreementTile(
                label: _labels[index],
                checked: _checkedStates[index],
                onTap: () {
                  setState(() {
                    _checkedStates[index] = !_checkedStates[index];
                  });
                },
                onArrowTap: () => widget.onTermsTap(_labels[index]),
              ),
              if (index != _labels.length - 1) const SizedBox(height: 6),
            ],
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: CancelButton(
                    label: '취소',
                    onPressed: widget.onCancel,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    label: '확인',
                    onPressed: widget.onConfirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AgreementTile extends StatelessWidget {
  const _AgreementTile({
    required this.label,
    required this.checked,
    required this.onTap,
    required this.onArrowTap,
  });

  final String label;
  final bool checked;
  final VoidCallback onTap;
  final VoidCallback onArrowTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: _AgreementCheckIcon(checked: checked),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                label,
                style: AppTextStyles.txtMd.copyWith(
                  color: AppColors.gray600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onArrowTap,
            child: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.gray300,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}

class _AgreementCheckIcon extends StatelessWidget {
  const _AgreementCheckIcon({required this.checked});

  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: checked ? AppColors.primary400 : AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: checked ? AppColors.primary400 : AppColors.gray200,
          width: 1.5,
        ),
      ),
      child: checked
          ? const Icon(
              Icons.check_rounded,
              color: AppColors.surface,
              size: 18,
            )
          : null,
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  const _SocialLoginButton({
    required this.label,
    required this.iconAssetPath,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
    this.borderColor,
  });

  final String label;
  final String iconAssetPath;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: LoginPage.buttonHeight,
      child: InkWell(
        borderRadius: BorderRadius.circular(LoginPage.buttonBorderRadius),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(LoginPage.buttonBorderRadius),
            border: borderColor == null ? null : Border.all(color: borderColor!),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconAssetPath,
                  fit: BoxFit.contain,
                ),
                Text(
                  label,
                  style: AppTextStyles.txtMd.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}