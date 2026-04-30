import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/components/navigation/app_bottom_nav_bar.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/features/calendar/viewmodels/calendar_view_model.dart';
import 'package:pedal/features/calendar/widgets/calendar_grid.dart';
import 'package:pedal/features/calendar/widgets/calendar_month_header.dart';
import 'package:pedal/features/calendar/widgets/calendar_monthly_stat_card.dart';
import 'package:pedal/features/calendar/widgets/calendar_week_section.dart';

class CalendarPage extends StatefulWidget {
  final VoidCallback onBack;
  final int currentNavIndex;
  final ValueChanged<int> onNavTap;

  const CalendarPage({
    super.key,
    required this.onBack,
    required this.currentNavIndex,
    required this.onNavTap,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalendarViewModel>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: BackAppBar(title: '캘린더', onBackPressed: widget.onBack),
      body: Consumer<CalendarViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                CalendarMonthHeader(
                  focusedMonth: vm.focusedMonth,
                  onPrevious: vm.onPreviousMonth,
                  onNext: vm.onNextMonth,
                ),
                CalendarGrid(
                  focusedMonth: vm.focusedMonth,
                  selectedDate: vm.selectedDate,
                  onDateSelected: vm.onDateSelected,
                ),
                SizedBox(height: AppSpacing.md),
                if (vm.monthlyStats != null)
                  CalendarMonthlyStatCard(stats: vm.monthlyStats!),
                SizedBox(height: AppSpacing.md),
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
                ...vm.weekSections.map(
                  (section) => CalendarWeekSection(
                    section: section,
                    isExpanded: vm.expandedWeekKeys.contains(section.key),
                    onToggle: () => vm.onWeekSectionToggle(section.key),
                  ),
                ),
                SizedBox(height: AppSpacing.x2l),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: widget.currentNavIndex,
        onTap: widget.onNavTap,
      ),
    );
  }
}
