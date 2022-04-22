import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:c19/core/util/c19_theme.dart';
import '../../../../app_localizations.dart';
import '../../../../core/util/number_formatter.dart';
import '../../domain/entities/covid_case.dart';

class CountryCovidCaseDisplay extends StatefulWidget {
  const CountryCovidCaseDisplay({Key? key, required this.covidCaseList})
      : super(key: key);
  final List<CovidCase> covidCaseList;

  static const purple = Color(0xFF9B8AFF);
  static const red = Color(0xFFEF827D);

  @override
  _CountryCovidCaseDisplayState createState() =>
      _CountryCovidCaseDisplayState();
}

class _CountryCovidCaseDisplayState extends State<CountryCovidCaseDisplay> {
  int segmentedControlGroupValue = 0;

  @override
  void initState() {
    widget.covidCaseList
        .sort((a, b) => b.totalConfirmed.compareTo(a.totalConfirmed));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              clipBehavior: Clip.hardEdge,
              child: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: Colors.grey.shade400,
                padding: EdgeInsets.zero,
                onValueChanged: (val) => setState(() {
                  segmentedControlGroupValue = val!;
                  switch (val) {
                    case 0:
                      widget.covidCaseList.sort((a, b) =>
                          b.totalConfirmed.compareTo(a.totalConfirmed));
                      return;
                    case 1:
                      widget.covidCaseList.sort(
                          (a, b) => b.totalDeaths.compareTo(a.totalDeaths));
                      return;
                  }
                }),
                groupValue: segmentedControlGroupValue,
                thumbColor: getSelectedColor(segmentedControlGroupValue),
                children: <int, Widget>{
                  0: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.translate('activeCases')!,
                      style: C19Theme.lightTextTheme.bodyText1!
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  1: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.translate('deaths')!,
                      style: C19Theme.lightTextTheme.bodyText1!
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                  ),
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            AppLocalizations.of(context)!.translate('updatedAtText')! +
                ' ' +
                widget.covidCaseList[0].updatedAt.substring(0, 10) +
                ', ' +
                AppLocalizations.of(context)!.translate('timePrefixText')! +
                widget.covidCaseList[0].updatedAt.substring(11, 16) +
                ' ' +
                AppLocalizations.of(context)!.translate('timeSuffixText')!,
            style: C19Theme.lightTextTheme.bodyText1!.copyWith(fontSize: 14),
          ),
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: const Color.fromRGBO(199, 199, 201, 1.0),
            elevation: 10,
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.covidCaseList.length,
                itemBuilder: (context, index) {
                  final CovidCase country = widget.covidCaseList[index];
                  return _buildListContent(
                      country, context, segmentedControlGroupValue);
                },
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListContent(CovidCase country, BuildContext context, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              country.country!,
              style:
                  C19Theme.lightTextTheme.bodyText1!.copyWith(fontSize: 16.0),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '+ ' + getNewCase(value, country),
                  style: C19Theme.lightTextTheme.bodyText1!.copyWith(
                      fontSize: 13.0,
                      color: getSelectedColor(value).withAlpha(240)),
                ),
                const SizedBox(height: 1.5),
                Text(
                  getTotalCase(value, country),
                  style: C19Theme.lightTextTheme
                      .bodyText1!
                      .copyWith(fontSize: 17.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getTotalCase(int index, CovidCase country) {
    switch (index) {
      case 0:
        return country.totalConfirmed.formatNumberToString;
      case 1:
        return country.totalDeaths.formatNumberToString;
      default:
        return country.totalConfirmed.formatNumberToString;
    }
  }

  String getNewCase(int index, CovidCase country) {
    switch (index) {
      case 0:
        return country.newConfirmed.formatNumberToString;
      case 1:
        return country.newDeaths.formatNumberToString;
      default:
        return country.newConfirmed.formatNumberToString;
    }
  }

  Color getSelectedColor(int index) {
    switch (index) {
      case 0:
        return CountryCovidCaseDisplay.purple;
      case 1:
        return CountryCovidCaseDisplay.red;
      default:
        return CountryCovidCaseDisplay.purple;
    }
  }
}
