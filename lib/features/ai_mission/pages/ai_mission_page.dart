import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/features/ai_mission/viewmodels/ai_mission_view_model.dart';
import 'package:pedal/features/ai_mission/widgets/ai_mission_card_widget.dart';

class AiMissionPage extends StatefulWidget {
  final VoidCallback onClose;

  const AiMissionPage({super.key, required this.onClose});

  @override
  State<AiMissionPage> createState() => _AiMissionPageState();
}

class _AiMissionPageState extends State<AiMissionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AiMissionViewModel>().loadMissions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AiMissionAppBar(onClose: widget.onClose),
            Expanded(
              child: Consumer<AiMissionViewModel>(
                builder: (context, vm, _) {
                  if (vm.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (vm.errorMessage != null)
                          Padding(
                            padding: EdgeInsets.only(bottom: AppSpacing.md),
                            child: Text(
                              vm.errorMessage!,
                              style: AppTextStyles.txtSm.copyWith(
                                color: AppColors.error,
                              ),
                            ),
                          ),
                        Text(
                          '현재 AI미션:',
                          style: AppTextStyles.txtSm.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          vm.currentMissionTitle,
                          style: AppTextStyles.titLg,
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          vm.currentMissionDescription,
                          style: AppTextStyles.txtSm.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: AppSpacing.lg),
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: vm.missionCards.length,
                            itemBuilder: (context, index) =>
                                AiMissionCardWidget(
                                  mission: vm.missionCards[index],
                                ),
                          ),
                        ),
                        SizedBox(height: AppSpacing.xl),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.lg,
              ),
              child: Consumer<AiMissionViewModel>(
                builder: (context, vm, _) => PrimaryButton(
                  label: 'AI 미션 생성하기',
                  onPressed: vm.isLoading ? null : vm.onGenerateMission,
                  disabled: vm.isLoading,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiMissionAppBar extends StatelessWidget {
  final VoidCallback onClose;

  const _AiMissionAppBar({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Text('AI미션', style: AppTextStyles.titMd),
          const Spacer(),
          GestureDetector(
            onTap: onClose,
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.xs),
              child: const Icon(
                Icons.close,
                color: AppColors.textPrimary,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
