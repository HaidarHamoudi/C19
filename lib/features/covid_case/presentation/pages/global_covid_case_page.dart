import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:c19/core/util/c19_theme.dart';
import '../../../../app_localizations.dart';
import '../bloc/global_covid_case_bloc/global_covid_case_bloc.dart';
import '../widgets/widgets.dart';

class GlobalCovidCasePage extends StatefulWidget {
  const GlobalCovidCasePage({Key? key}) : super(key: key);

  @override
  _GlobalCovidCasePageState createState() => _GlobalCovidCasePageState();
}

class _GlobalCovidCasePageState extends State<GlobalCovidCasePage> {
  @override
  void initState() {
    BlocProvider.of<GlobalCovidCaseBloc>(context)
        .add(GetGlobalCovidCaseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16.0),
            BlocBuilder<GlobalCovidCaseBloc, GlobalCovidCaseState>(
              builder: (context, state) {
                if (state is GlobalCovidCaseInitial) {
                  return const LoadingWidget();
                } else if (state is GlobalCovidCaseLoading) {
                  return const LoadingWidget();
                } else if (state is GlobalCovidCaseLoaded) {
                  return GlobalCovidCaseDisplay(covidCase: state.covidCase);
                } else if (state is GlobalCovidCaseFailed) {
                  return MessageDisplay(message: state.message);
                } else {
                  return const LoadingWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: AppLocalizations.of(context)!.translate('covidCasesWorldwideHeading0')!,
        style: C19Theme.lightTextTheme.headline6!.copyWith(fontSize: 18.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
        children: <TextSpan>[
          TextSpan(
            text: ' - ' +
                AppLocalizations.of(context)!
                    .translate('covidCasesWorldwideHeading1')!,
            style: C19Theme.lightTextTheme.headline6!.copyWith(fontStyle: FontStyle.normal,fontSize: 15.0,color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
