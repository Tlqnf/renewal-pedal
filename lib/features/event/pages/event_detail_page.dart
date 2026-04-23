import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/features/event/viewmodels/event_detail_view_model.dart';
import 'package:pedal/features/event/widgets/event_step_item.dart';

class EventDetailPage extends StatefulWidget {
  final String eventId;
  final VoidCallback onBack;

  const EventDetailPage({
    super.key,
    required this.eventId,
    required this.onBack,
  });

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventDetailViewModel>().loadEvent(widget.eventId);
    });
  }

  String _formatDate(DateTime d) =>
      '${d.year}.${d.month.toString().padLeft(2, '0')}.${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: widget.onBack,
        ),
        title: Text('이벤트 상세', style: AppTextStyles.titMd),
        centerTitle: true,
      ),
      body: Consumer<EventDetailViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          final event = vm.event;
          if (event == null) {
            return Center(
              child: Text(
                vm.errorMessage ?? '이벤트를 불러올 수 없습니다.',
                style: AppTextStyles.txtMd,
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        color: AppColors.primary100,
                        child: const Center(
                          child: Icon(
                            Icons.image_outlined,
                            color: AppColors.primary,
                            size: 64,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event.title, style: AppTextStyles.titLg),
                            SizedBox(height: AppSpacing.md),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person_outline,
                                  size: 16,
                                  color: AppColors.textSecondary,
                                ),
                                SizedBox(width: AppSpacing.xs),
                                Text(
                                  event.participationRestriction,
                                  style: AppTextStyles.txtSm.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppSpacing.sm),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 16,
                                  color: AppColors.textSecondary,
                                ),
                                SizedBox(width: AppSpacing.xs),
                                Text(
                                  '${_formatDate(event.startDate)} ~ ${_formatDate(event.endDate)}',
                                  style: AppTextStyles.txtSm.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppSpacing.md),
                            Divider(color: AppColors.divider),
                            SizedBox(height: AppSpacing.md),
                            Text(event.description, style: AppTextStyles.txtMd),
                            SizedBox(height: AppSpacing.lg),
                            Text('참여 방법', style: AppTextStyles.titMd),
                            SizedBox(height: AppSpacing.md),
                            ...event.steps.map(
                              (step) => EventStepItem(step: step),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.lg,
                ),
                child: PrimaryButton(
                  label: '이벤트 참여',
                  onPressed: vm.isLoading
                      ? null
                      : () => vm.onParticipate(widget.eventId),
                  disabled: vm.isLoading,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
