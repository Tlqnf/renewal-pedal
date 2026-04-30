import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:pedal/features/map/viewmodels/map_search_viewmodel.dart';
import 'package:pedal/common/components/inputs/search_field.dart';
import 'package:pedal/features/map/widgets/record_list_card.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class MapSearchPage extends StatefulWidget {
  const MapSearchPage({super.key});

  @override
  State<MapSearchPage> createState() => _MapSearchPageState();
}

class _MapSearchPageState extends State<MapSearchPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<MapSearchViewModel>();
      final initialQuery = GoRouterState.of(context).extra as String?;
      if (initialQuery != null && initialQuery.isNotEmpty) {
        _searchController.text = initialQuery;
        vm.searchRoutes(search: initialQuery);
      } else {
        vm.searchRoutes(search: initialQuery);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _MapSearchPageContent(searchController: _searchController);
  }
}

class _MapSearchPageContent extends StatelessWidget {
  final TextEditingController searchController;

  const _MapSearchPageContent({required this.searchController});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MapSearchViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 검색 필드
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: AppSpacing.lg,
              ),
              child: SearchField(
                hintText: '루트 또는 장소 검색',
                controller: searchController,
                onSubmitted: viewModel.onSearchSubmitted,
              ),
            ),

            // 검색 결과 또는 루트 목록
            Expanded(
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.routes.isEmpty
                  ? Center(
                      child: Text(
                        "검색과 일치하는 경로가 없습니다.",
                        style: AppTextStyles.txtSm,
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: AppSpacing.md,
                      ),
                      itemCount: viewModel.routes.length,
                      separatorBuilder: (_, _) =>
                          SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final route = viewModel.routes[index];
                        return RecordListCard(
                          routeName: route.routeName,
                          distance: route.distance,
                          duration: route.duration,
                          calories: route.calories,
                          onAction: () => context.pop(route),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
