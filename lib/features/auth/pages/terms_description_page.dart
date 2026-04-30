import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class TermsSection {
  final String title;
  final String body;

  const TermsSection({required this.title, required this.body});
}

class TermsDescriptionPage extends StatelessWidget {
  final String termsTitle;
  final List<TermsSection> sections;
  final bool isLoading;
  final VoidCallback onBackPressed;

  const TermsDescriptionPage({
    super.key,
    required this.termsTitle,
    required this.sections,
    required this.isLoading,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TermsAppBar(onBackPressed: onBackPressed),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.md,
                        right: AppSpacing.md,
                        top: AppSpacing.lg,
                        bottom: AppSpacing.xl,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(termsTitle, style: AppTextStyles.titXl),
                          const SizedBox(height: AppSpacing.lg),
                          ...sections.map(
                            (section) => _TermsSectionItem(section: section),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TermsAppBar extends StatelessWidget {
  final VoidCallback onBackPressed;

  const _TermsAppBar({required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBackPressed,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.arrow_back,
              size: 20,
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text('이전', style: AppTextStyles.txtMd),
          ],
        ),
      ),
    );
  }
}

class _TermsSectionItem extends StatelessWidget {
  final TermsSection section;

  const _TermsSectionItem({required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section.title, style: AppTextStyles.titSmMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(
            section.body,
            style: AppTextStyles.txtSm.copyWith(
              color: AppColors.textPrimary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
