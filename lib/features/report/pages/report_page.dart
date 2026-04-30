import 'package:flutter/material.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/common/components/inputs/radio_select_item.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class ReportPage extends StatefulWidget {
  final String targetType;
  final String targetId;

  const ReportPage({
    super.key,
    required this.targetType,
    required this.targetId,
  });

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int? _selectedIndex;

  static const List<String> _reasons = [
    '스팸',
    '음란물 또는 성적인 콘텐츠',
    '개인정보 노출',
    '폭언·욕설',
    '허위 정보',
    '기타',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: BackAppBar(title: '신고'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                itemCount: _reasons.length,
                separatorBuilder: (_, _) =>
                    Divider(height: 1, color: AppColors.border),
                itemBuilder: (context, index) {
                  return RadioSelectItem(
                    label: _reasons[index],
                    isSelected: _selectedIndex == index,
                    onTap: () => setState(() => _selectedIndex = index),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, AppSpacing.md, 16, 32),
              child: PrimaryButton(
                label: '신고하기',
                disabled: _selectedIndex == null,
                onPressed: () {
                  // TODO: 신고 제출 API 연동
                  debugPrint(
                    '신고: ${widget.targetType} / ${widget.targetId} / ${_reasons[_selectedIndex!]}',
                  );
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
