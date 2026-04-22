import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/components/navigation/app_bottom_nav_bar.dart';
import 'package:pedal/features/ranking/viewmodels/ranking_view_model.dart';
import 'package:pedal/features/ranking/widgets/ranking_filter_tab_bar.dart';
import 'package:pedal/features/ranking/widgets/ranking_podium_section.dart';
import 'package:pedal/features/ranking/widgets/ranking_list_item.dart';

class RankingPage extends StatefulWidget {
  final VoidCallback onBack;
  final int currentNavIndex;
  final ValueChanged<int> onNavTap;
  final ValueChanged<String>? onUserTap;

  const RankingPage({
    super.key,
    required this.onBack,
    required this.currentNavIndex,
    required this.onNavTap,
    this.onUserTap,
  });

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RankingViewModel>().loadRanking();
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
        title: Text('랭킹', style: AppTextStyles.titMd),
        centerTitle: true,
      ),
      body: Consumer<RankingViewModel>(
        builder: (context, vm, _) {
          return Column(
            children: [
              RankingFilterTabBar(
                tabs: RankingViewModel.tabs,
                selectedIndex: vm.selectedTabIndex,
                onTabChanged: vm.onTabChanged,
              ),
              Expanded(
                child: vm.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: AppColors.primary),
                      )
                    : ListView(
                        children: [
                          if (vm.rankingList.length >= 3)
                            RankingPodiumSection(top3: vm.rankingList.take(3).toList()),
                          const Divider(height: 1, color: AppColors.divider),
                          ...vm.rankingList.skip(3).map(
                                (entity) => RankingListItem(
                                  entity: entity,
                                  onTap: () => widget.onUserTap?.call(entity.userId),
                                ),
                              ),
                          if (vm.errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                vm.errorMessage!,
                                style: AppTextStyles.txtSm.copyWith(
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ],
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
