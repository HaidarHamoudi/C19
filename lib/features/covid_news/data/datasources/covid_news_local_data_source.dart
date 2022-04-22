import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:c19/core/error/exception.dart';
import '../models/covid_news_model.dart';

abstract class CovidNewsLocalDataSource {
  /// Gets the cached list of [CovidNewsModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is found.
  Future<List<CovidNewsModel>> getLastGlobalCovidNews();

  /// Gets the cached list of [CovidNewsModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is found.
  Future<List<CovidNewsModel>> getLastUsaCovidNews();

  Future<void> cacheGlobalCovidNews(List<CovidNewsModel> globalNewsToCache);
  Future<void> cacheUsaCovidNews(List<CovidNewsModel> usaNewsToCache);
}

const CACHED_GLOBAL_COVID_NEWS = 'CACHED_GLOBAL_COVID_NEWS';
const CACHED_USA_COVID_NEWS = 'CACHED_INDIA_COVID_NEWS';

class CovidNewsLocalDataSourceImpl implements CovidNewsLocalDataSource {
  CovidNewsLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<List<CovidNewsModel>> getLastGlobalCovidNews() {
    final jsonString = sharedPreferences.getString(CACHED_GLOBAL_COVID_NEWS);
    if (jsonString != null) {
      final globalCovidNews = <CovidNewsModel>[];
      json.decode(jsonString).forEach((json) => globalCovidNews
          .add(CovidNewsModel.fromJson(json as Map<String, dynamic>)));
      return Future.value(globalCovidNews);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<CovidNewsModel>> getLastUsaCovidNews() {
    final jsonString = sharedPreferences.getString(CACHED_USA_COVID_NEWS);
    if (jsonString != null) {
      final usaCovidNews = <CovidNewsModel>[];
      json.decode(jsonString).forEach((json) => usaCovidNews
          .add(CovidNewsModel.fromJson(json as Map<String, dynamic>)));
      return Future.value(usaCovidNews);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheGlobalCovidNews(
      List<CovidNewsModel> globalNewsToCache) async {
    final cacheData = <Map<String, dynamic>>[];
    for (var data in globalNewsToCache) {
      cacheData.add(data.toJson());
    }
    await sharedPreferences.setString(
      CACHED_GLOBAL_COVID_NEWS,
      json.encode(cacheData),
    );
  }

  @override
  Future<void> cacheUsaCovidNews(
      List<CovidNewsModel> usaNewsToCache) async {
    final cacheData = <Map<String, dynamic>>[];
    for (var data in usaNewsToCache) {
      cacheData.add(data.toJson());
    }
    await sharedPreferences.setString(
      CACHED_USA_COVID_NEWS,
      json.encode(cacheData),
    );
  }
}
