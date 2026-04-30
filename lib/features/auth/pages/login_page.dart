import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pedal/common/components/toasts/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/core/constants/constants.dart';
import 'package:pedal/core/routes/app_routes.dart';
import 'package:pedal/domain/auth/use_cases/login_usecase.dart';
import 'package:pedal/features/auth/pages/terms_description_page.dart';
import 'package:pedal/features/auth/viewmodels/onboarding_viewmodel.dart';
import 'package:pedal/features/auth/widgets/social_login_button.dart';
import 'package:pedal/features/auth/widgets/terms_dialog.dart';
import 'package:pedal/services/google_sign_in/google_sign_in_service.dart';
import 'package:pedal/services/kakao_sign_in/kakao_sign_in_service.dart';
import 'package:pedal/services/naver_sign_in/naver_sign_in_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const double horizontalPadding = 16;
  static const double contentTopSpacing = 53;
  static const double headlineTopSpacing = 24;
  static const double bodyTopSpacing = 26;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingViewModel(
        googleLoginUseCase: context.read<GoogleLoginUseCase>(),
        kakaoLoginUseCase: context.read<KakaoLoginUseCase>(),
        naverLoginUseCase: context.read<NaverLoginUseCase>(),
        googleSignInService: context.read<GoogleSignInService>(),
        kakaoSignInService: context.read<KakaoSignInService>(),
        naverSignInService: context.read<NaverSignInService>(),
      ),
      child: const _LoginPageContent(),
    );
  }
}

class _LoginPageContent extends StatefulWidget {
  const _LoginPageContent();

  @override
  State<_LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<_LoginPageContent> {
  Future<void> _handleSocialLogin(SocialLoginProvider provider) async {
    // 이용약관 동의 먼저
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.28),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 12),
          child: TermsDialog(
            onCancel: () => Navigator.of(dialogContext).pop(),
            onTermsTap: (label) {
              context.push(
                AppRoutes.termsDetail,
                extra: {'title': label, 'sections': <TermsSection>[]},
              );
            },
          ),
        );
      },
    );
    if (confirmed != true || !mounted) return;

    await context.read<OnboardingViewModel>().onSocialLogin(context, provider);

    if (!mounted) return;
    final vm = context.read<OnboardingViewModel>();
    if (vm.errorMessage != null) {
      AppToast.error(context, vm.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<OnboardingViewModel>().isLoading;

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
                20,
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 37),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '로그인',
                                style: AppTextStyles.titSmMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(
                                height: LoginPage.headlineTopSpacing,
                              ),
                              Text(
                                '신개념 자전거 라이딩을\n즐겨보세요',
                                style: AppTextStyles.tit2xl.copyWith(
                                  fontSize: 22,
                                  height: 1.4,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            AppConstants.icon,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ],
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
                  const Spacer(),
                  SocialLoginButton(
                    label: '구글 계정으로 계속하기',
                    iconAssetPath: AppConstants.google,
                    backgroundColor: AppColors.surface,
                    foregroundColor: AppColors.gray800,
                    borderColor: AppColors.border,
                    onTap: isLoading
                        ? () {}
                        : () => _handleSocialLogin(SocialLoginProvider.google),
                  ),
                  const SizedBox(height: 12),
                  SocialLoginButton(
                    label: '카카오 계정으로 계속하기',
                    iconAssetPath: AppConstants.kakao,
                    backgroundColor: AppColors.kakaoBackground,
                    foregroundColor: AppColors.gray900,
                    onTap: isLoading
                        ? () {}
                        : () => _handleSocialLogin(SocialLoginProvider.kakao),
                  ),
                  const SizedBox(height: 12),
                  SocialLoginButton(
                    label: '네이버 계정으로 계속하기',
                    iconAssetPath: AppConstants.naver,
                    backgroundColor: AppColors.naverBackground,
                    foregroundColor: AppColors.gray0,
                    onTap: isLoading
                        ? () {}
                        : () => _handleSocialLogin(SocialLoginProvider.naver),
                  ),
                ],
              ),
            ),
            if (isLoading)
              const ColoredBox(
                color: Colors.transparent,
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
