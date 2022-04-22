import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:c19/features/covid_news/presentation/bloc/covid_news_bloc.dart';
import '../bloc/covid_news_bloc.dart';
import '../widgets/widgets.dart';

class UsaCovidNewsPage extends StatefulWidget {
  const UsaCovidNewsPage({Key? key}) : super(key: key);

  @override
  _UsaCovidNewsPageState createState() => _UsaCovidNewsPageState();
}

class _UsaCovidNewsPageState extends State<UsaCovidNewsPage> {
  @override
  void initState() {
    BlocProvider.of<CovidNewsBloc>(context).add(GetUsaCovidNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CovidNewsBloc, CovidNewsState>(
      builder: (context, state) {
        if (state is CovidNewsInitial) {
          return const LoadingWidget();
        } else if (state is CovidNewsLoading) {
          return const LoadingWidget();
        } else if (state is CovidNewsLoaded) {
          return CovidNewsDisplay(covidNews: state.covidNews);
        } else if (state is CovidNewsFailed) {
          return MessageDisplay(message: state.message);
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
