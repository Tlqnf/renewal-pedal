import 'package:flutter/material.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/features/my/widgets/crew_card.dart';
import 'package:pedal/features/my/viewmodels/my_crew_list_view_model.dart';
import 'package:provider/provider.dart';

class MyCrewListPage extends StatelessWidget {
  final List<CrewEntity> crewList;
  final bool isLoading;
  final String? errorMessage;

  final void Function(String crewId) onCrewTap;
  final VoidCallback onBack;

  const MyCrewListPage({
    super.key,
    required this.crewList,
    required this.isLoading,
    required this.errorMessage,
    required this.onCrewTap,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: BackAppBar(
        title: '참여한 크루',
        onBackPressed: onBack,
        actions: [
          Text(
            '${crewList.length}',
            style: AppTextStyles.titSm.copyWith(color: AppColors.primary),
          ),
          SizedBox(width: AppSpacing.md),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Text(
          errorMessage!,
          style: AppTextStyles.txtSm.copyWith(color: AppColors.textSecondary),
        ),
      );
    }

    if (crewList.isEmpty) {
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
      itemCount: crewList.length,
      itemBuilder: (context, index) {
        final crew = crewList[index];
        return CrewCard(
          crew: crew,
          onTap: () => onCrewTap(crew.id),
        );
      },
    );
  }
}

class MyCrewListPageConnected extends StatefulWidget {
  const MyCrewListPageConnected({super.key});

  @override
  State<MyCrewListPageConnected> createState() => _MyCrewListPageConnectedState();
}

class _MyCrewListPageConnectedState extends State<MyCrewListPageConnected> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyCrewListViewModel>().fetchCrewList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCrewListViewModel>(
      builder: (context, vm, _) {
        return MyCrewListPage(
          crewList: vm.crewList,
          isLoading: vm.isLoading,
          errorMessage: vm.errorMessage,
          onCrewTap: vm.navigateToCrewDetail,
          onBack: () {
            vm.navigateBack();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
