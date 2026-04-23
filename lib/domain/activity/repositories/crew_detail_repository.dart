import 'package:dartz/dartz.dart';
import 'package:pedal/domain/activity/entities/crew_detail_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class CrewDetailRepository {
  Future<Either<Failure, CrewDetailEntity>> getCrewDetail(String crewId);
  Future<Either<Failure, void>> joinCrew(String crewId);
}
