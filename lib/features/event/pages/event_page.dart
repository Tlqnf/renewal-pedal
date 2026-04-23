import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/features/event/viewmodels/event_view_model.dart';

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
      backgroundColor: AppColors.background,
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
                GestureDetector(
                  onTap: widget.onBack,
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                ),
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
                                color: AppColors.primary100,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              event.imageUrls.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.xs / 2,
                                ),
                                width: vm.currentImageIndex == index ? 16 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: vm.currentImageIndex == index
                                      ? AppColors.primary
                                      : AppColors.gray300,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
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
