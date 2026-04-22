import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class RecordSummaryItem {
  final String label;
  final String value;

  const RecordSummaryItem({required this.label, required this.value});
}

class RecordSummaryList extends StatelessWidget {
  final List<RecordSummaryItem> items;

  const RecordSummaryList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border),
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == items.length - 1;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.lg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.label,
                      style: AppTextStyles.txtMd.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(item.value, style: AppTextStyles.titMd),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  color: AppColors.border,
                  indent: AppSpacing.xl,
                  endIndent: AppSpacing.xl,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
