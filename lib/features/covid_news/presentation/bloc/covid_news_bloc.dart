import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:c19/core/error/failure.dart';
import 'package:c19/core/usecases/usecase.dart';
import 'package:c19/features/covid_news/domain/usecases/get_global_covid_news.dart';
import 'package:c19/features/covid_news/domain/usecases/get_usa_covid_news.dart';
import '../../domain/entities/covid_news.dart';

part 'covid_news_event.dart';
part 'covid_news_state.dart';

class CovidNewsBloc extends Bloc<CovidNewsEvent, CovidNewsState> {
  CovidNewsBloc({
    required GetGlobalCovidNews global,
    required GetUsaCovidNews usa,
  })  : globalCovidNews = global,
        usaCovidNews = usa,
        super(CovidNewsInitial());

  final GetGlobalCovidNews globalCovidNews;
  final GetUsaCovidNews usaCovidNews;

  @override
  Stream<CovidNewsState> mapEventToState(
    CovidNewsEvent event,
  ) async* {
    if (event is GetGlobalCovidNewsEvent) {
      yield CovidNewsLoading();
      final result = await globalCovidNews(NoParams());
      yield result.fold(
        (failure) => CovidNewsFailed(message: failure.mapFailureToMessage),
        (covidNews) => CovidNewsLoaded(covidNews: covidNews),
      );
    } else if (event is GetUsaCovidNewsEvent) {
      yield CovidNewsLoading();
      final result = await usaCovidNews(NoParams());
      yield result.fold(
        (failure) => CovidNewsFailed(message: failure.mapFailureToMessage),
        (covidNews) => CovidNewsLoaded(covidNews: covidNews),
      );
    }
  }
}
