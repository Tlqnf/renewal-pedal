import 'package:flutter/material.dart';
import 'package:pedal/features/auth/viewmodels/auth_viewmodel.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/lists/items/settings_list_item.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
// import 'package:pedal/core/routes/app_routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _onLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('로그아웃 하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('로그아웃'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await context.read<AuthViewModel>().logout();
  }

  Future<void> _onDeleteAccount(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('회원탈퇴'),
        content: const Text('탈퇴하면 모든 데이터가 삭제됩니다.\n정말 탈퇴하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('탈퇴'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final success = await context.read<AuthViewModel>().deleteAccount();

    if (!context.mounted) return;
    if (!success) {
      final errorMessage =
          context.read<AuthViewModel>().errorMessage ?? '오류가 발생했습니다.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: BackAppBar(
        title: '설정',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppSpacing.lg),
            SettingsListItem(
              label: '사용자 프로필 설정',
              onTap: () {
                // context.push(AppRoutes.editProfile);
              },
            ),
            SettingsListItem(label: '로그아웃', onTap: () => _onLogout(context)),
            SettingsListItem(
              label: '회원탈퇴',
              onTap: () => _onDeleteAccount(context),
              isHighlighted: true,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: Text(
                'Pedal 버전\nV0.0.0',
                textAlign: TextAlign.center,
                style: AppTextStyles.txtSm.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
