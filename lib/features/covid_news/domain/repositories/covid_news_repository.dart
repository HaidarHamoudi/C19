import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/covid_news.dart';

abstract class CovidNewsRepository {
  Future<Either<Failure, List<CovidNews>>> getUsaCovidNews();
  Future<Either<Failure, List<CovidNews>>> getGlobalCovidNews();
}
