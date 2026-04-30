import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/features/event/viewmodels/event_view_model.dart';
import 'package:pedal/features/event/widgets/page_dot_indicator.dart';

class EventPage extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onDetailTap;

  const EventPage({super.key, required this.onBack, required this.onDetailTap});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventViewModel>().loadEvents();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: BackAppBar(title: '', onBackPressed: widget.onBack),
      body: SafeArea(
        child: Consumer<EventViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            final event = vm.currentEvent;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (event != null) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(event.title, style: AppTextStyles.titXl),
                                SizedBox(height: AppSpacing.sm),
                                Text(
                                  event.subtitle,
                                  style: AppTextStyles.txtSm.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppSpacing.md),
                          SizedBox(
                            height: 200,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: event.imageUrls.length,
                              onPageChanged: vm.onPageChanged,
                              itemBuilder: (context, index) => Container(
                                color: AppColors.primary300,
                                child: const Center(
                                  child: Icon(
                                    Icons.image_outlined,
                                    color: AppColors.primary,
                                    size: 48,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: AppSpacing.sm),
                          PageDotIndicator(
                            count: event.imageUrls.length,
                            currentIndex: vm.currentImageIndex,
                          ),
                        ],
                        if (vm.errorMessage != null)
                          Padding(
                            padding: EdgeInsets.all(AppSpacing.md),
                            child: Text(
                              vm.errorMessage!,
                              style: AppTextStyles.txtSm.copyWith(
                                color: AppColors.error,
                              ),
                            ),
                          ),
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
                    label: '이벤트 상세보기',
                    onPressed: widget.onDetailTap,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
