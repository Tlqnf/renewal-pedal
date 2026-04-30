import 'package:flutter/material.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/features/my/widgets/crew_card.dart';
import 'package:pedal/features/my/viewmodels/my_crew_list_view_model.dart';
import 'package:provider/provider.dart';

class MyCrewListPage extends StatefulWidget {
  const MyCrewListPage({super.key});

  @override
  State<MyCrewListPage> createState() => _MyCrewListPageState();
}

class _MyCrewListPageState extends State<MyCrewListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyCrewListViewModel>().fetchCrewList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MyCrewListViewModel>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: BackAppBar(
        title: '참여한 크루',
        onBackPressed: () => Navigator.of(context).pop(),
        actions: [
          Text(
            '${vm.crewList.length}',
            style: AppTextStyles.titSmMedium.copyWith(color: AppColors.primary),
          ),
          SizedBox(width: AppSpacing.md),
        ],
      ),
      body: _buildBody(vm),
    );
  }

  Widget _buildBody(MyCrewListViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.errorMessage != null) {
      return Center(
        child: Text(
          vm.errorMessage!,
          style: AppTextStyles.txtSm.copyWith(color: AppColors.textSecondary),
        ),
      );
    }

    if (vm.crewList.isEmpty) {
      return Center(
        child: Text(
          '참여한 크루가 없습니다',
          style: AppTextStyles.txtSm.copyWith(color: AppColors.textSecondary),
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.all(AppSpacing.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 0.85,
      ),
      itemCount: vm.crewList.length,
      itemBuilder: (context, index) {
        final crew = vm.crewList[index];
        return CrewCard(
          crew: crew,
          onTap: () => vm.navigateToCrewDetail(crew.id),
        );
      },
    );
  }
}
