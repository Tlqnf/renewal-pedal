import 'package:dartz/dartz.dart';
import 'package:pedal/domain/activity/repositories/crew_detail_repository.dart';
import 'package:pedal/domain/activity/entities/crew_detail_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/mock/data/activity_crew_detail_mock_data.dart';

class ActivityCrewDetailMockRepository implements CrewDetailRepository {
  @override
  Future<Either<Failure, CrewDetailEntity>> getCrewDetail(String crewId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Right(ActivityCrewDetailMockData.crewDetail);
  }

  @override
  Future<Either<Failure, void>> joinCrew(String crewId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const Right(null);
  }
}
