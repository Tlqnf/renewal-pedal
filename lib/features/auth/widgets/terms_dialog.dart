import 'package:flutter/material.dart';
import 'package:pedal/common/components/buttons/cancel_button.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/common/components/inputs/app_checkbox.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/features/auth/viewmodels/terms_viewmodel.dart';
import 'package:provider/provider.dart';

class TermsDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final ValueChanged<String> onTermsTap;

  const TermsDialog({
    super.key,
    required this.onCancel,
    required this.onTermsTap,
  });

  static const double _dialogRadius = 16;
  static const double _sectionPadding = 16;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TermsViewModel(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(_dialogRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(_sectionPadding),
          child: Consumer<TermsViewModel>(
            builder: (context, vm, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '페달 서비스 이용약관',
                    style: AppTextStyles.titLgMedium.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(height: 1, color: AppColors.gray200),
                  const SizedBox(height: 10),
                  for (var index = 0; index < vm.terms.length; index++) ...[
                    AppCheckbox(
                      label: vm.terms[index]['label'] as String,
                      isChecked: vm.isTermAgreed(
                        vm.terms[index]['id'] as String,
                      ),
                      onChanged: (_) =>
                          vm.toggleTerm(vm.terms[index]['id'] as String),
                      onDetailTap: (vm.terms[index]['hasDetail'] as bool)
                          ? () => onTermsTap(vm.terms[index]['label'] as String)
                          : null,
                    ),
                    if (index != vm.terms.length - 1) const SizedBox(height: 6),
                  ],
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: CancelButton(label: '취소', onPressed: onCancel),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PrimaryButton(
                          label: '확인',
                          onPressed: vm.canConfirm
                              ? () => vm.confirmTerms(context)
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
