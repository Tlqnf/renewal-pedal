import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/features/event/viewmodels/event_request_view_model.dart';
import 'package:pedal/common/components/inputs/image_upload_box.dart';

class EventRequestPage extends StatefulWidget {
  final String eventId;
  final String eventTitle;
  final String? eventThumbnailUrl;
  final VoidCallback onBack;
  final VoidCallback onSubmitSuccess;

  const EventRequestPage({
    super.key,
    required this.eventId,
    required this.eventTitle,
    this.eventThumbnailUrl,
    required this.onBack,
    required this.onSubmitSuccess,
  });

  @override
  State<EventRequestPage> createState() => _EventRequestPageState();
}

class _EventRequestPageState extends State<EventRequestPage> {
  final TextEditingController _memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventRequestViewModel>().setSelectedEvent(
        id: widget.eventId,
        title: widget.eventTitle,
        thumbnailUrl: widget.eventThumbnailUrl,
      );
    });
  }

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: widget.onBack,
        ),
        title: Text('이벤트 인증', style: AppTextStyles.titMdMedium),
        centerTitle: true,
      ),
      body: Consumer<EventRequestViewModel>(
        builder: (context, vm, _) {
          if (vm.isSubmitted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onSubmitSuccess();
            });
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SelectedEventCard(
                        title: widget.eventTitle,
                        thumbnailUrl: widget.eventThumbnailUrl,
                      ),
                      SizedBox(height: AppSpacing.lg),
                      Text('인증 스크린샷', style: AppTextStyles.titSmMedium),
                      SizedBox(height: AppSpacing.sm),
                      ImageUploadBox(
                        imageUrl: vm.uploadedImagePath,
                        onImageSelected: (path) => vm.onImagePicked(path ?? ''),
                      ),
                      SizedBox(height: AppSpacing.lg),
                      Text('메모 (선택)', style: AppTextStyles.titSmMedium),
                      SizedBox(height: AppSpacing.sm),
                      TextField(
                        controller: _memoController,
                        maxLines: 4,
                        onChanged: vm.onMemoChanged,
                        decoration: InputDecoration(
                          hintText: '라이딩 후기나 특이사항을 남겨주세요.',
                          hintStyle: AppTextStyles.txtSm.copyWith(
                            color: AppColors.textDisabled,
                          ),
                          filled: true,
                          fillColor: AppColors.surface,
                          border: OutlineInputBorder(
                            borderRadius: AppRadius.lgAll,
                            borderSide: const BorderSide(
                              color: AppColors.border,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: AppRadius.lgAll,
                            borderSide: const BorderSide(
                              color: AppColors.border,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: AppRadius.lgAll,
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(AppSpacing.md),
                        ),
                      ),
                      if (vm.errorMessage != null) ...[
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          vm.errorMessage!,
                          style: AppTextStyles.txtSm.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ],
                      SizedBox(height: AppSpacing.xl),
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
                  label: '이벤트 인증 요청',
                  onPressed: (vm.isLoading || vm.uploadedImagePath == null)
                      ? null
                      : vm.onSubmit,
                  disabled: vm.isLoading || vm.uploadedImagePath == null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SelectedEventCard extends StatelessWidget {
  final String title;
  final String? thumbnailUrl;

  const _SelectedEventCard({required this.title, this.thumbnailUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary300,
              borderRadius: AppRadius.smAll,
            ),
            child: const Center(
              child: Icon(
                Icons.event_outlined,
                color: AppColors.primary,
                size: 28,
              ),
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '선택된 이벤트',
                  style: AppTextStyles.txtXs.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(title, style: AppTextStyles.titSmMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
