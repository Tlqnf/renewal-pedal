import 'package:flutter/material.dart';
import 'package:pedal/common/components/appbars/pedal_appbar.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/features/crew/pages/crew_tab_view.dart';
import 'package:pedal/features/crew/viewmodels/crew_view_model.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActivityViewModel>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ActivityViewModel>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: PedalAppBar(title: '크루', onNotificationTap: vm.onNotification),
      body: CrewTabView(
        crews: vm.crews,
        isLoading: vm.isLoadingCrews,
        errorMessage: vm.errorMessage,
        stats: vm.stats,
        userName: vm.userName,
        onCrewTap: vm.onCrewTap,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        onPressed: vm.onCreateCrew,
        child: const Icon(Icons.add),
      ),
    );
  }
}
