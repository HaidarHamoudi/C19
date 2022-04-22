import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/covid_news.dart';
import '../../domain/repositories/covid_news_repository.dart';
import '../datasources/covid_news_local_data_source.dart';
import '../datasources/covid_news_remote_data_source.dart';

class CovidNewsRepositoryImpl implements CovidNewsRepository {
  CovidNewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final CovidNewsRemoteDataSource remoteDataSource;
  final CovidNewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<CovidNews>>> getGlobalCovidNews() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteGlobalCovidNews =
            await remoteDataSource.getGlobalCovidNews();
        await localDataSource.cacheGlobalCovidNews(remoteGlobalCovidNews);
        return Right(remoteGlobalCovidNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedGlobalCovidNews =
            await localDataSource.getLastGlobalCovidNews();
        return Right(cachedGlobalCovidNews);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<CovidNews>>> getUsaCovidNews() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUsaCovidNews = await remoteDataSource.getUsaCovidNews();
        await localDataSource.cacheUsaCovidNews(remoteUsaCovidNews);
        return Right(remoteUsaCovidNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedUsaCovidNews =
            await localDataSource.getLastUsaCovidNews();
        return Right(cachedUsaCovidNews);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
