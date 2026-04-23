import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/components/navigation/app_bottom_nav_bar.dart';
import 'package:pedal/features/calendar/viewmodels/calendar_view_model.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: widget.onBack,
        ),
        title: Text('캘린더', style: AppTextStyles.titMd),
        centerTitle: true,
      ),
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
                _CalendarGrid(
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
                SizedBox(height: AppSpacing.xxl),
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

class _CalendarGrid extends StatelessWidget {
  final DateTime focusedMonth;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const _CalendarGrid({
    required this.focusedMonth,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(focusedMonth.year, focusedMonth.month, 1);
    final lastDay = DateTime(focusedMonth.year, focusedMonth.month + 1, 0);
    final startWeekday = firstDay.weekday % 7; // 0=Sun
    final today = DateTime.now();

    const weekdays = ['일', '월', '화', '수', '목', '금', '토'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          Row(
            children: weekdays
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: AppTextStyles.txtXs.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: AppSpacing.xs),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
            ),
            itemCount: startWeekday + lastDay.day,
            itemBuilder: (context, index) {
              if (index < startWeekday) return const SizedBox.shrink();
              final day = index - startWeekday + 1;
              final date = DateTime(focusedMonth.year, focusedMonth.month, day);
              final isToday =
                  date.year == today.year &&
                  date.month == today.month &&
                  date.day == today.day;
              final isSelected =
                  selectedDate != null &&
                  date.year == selectedDate!.year &&
                  date.month == selectedDate!.month &&
                  date.day == selectedDate!.day;

              return GestureDetector(
                onTap: () => onDateSelected(date),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : isToday
                        ? AppColors.primary100
                        : null,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$day',
                      style: AppTextStyles.txtXs.copyWith(
                        color: isSelected
                            ? AppColors.surface
                            : isToday
                            ? AppColors.primary
                            : AppColors.textPrimary,
                        fontWeight: isToday || isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
