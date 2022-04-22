import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'app_localizations.dart';
import 'core/util/c19_theme.dart';
import 'features/covid_case/presentation/pages/country_covid_case_page.dart';
import 'features/covid_case/presentation/pages/global_covid_case_page.dart';
import 'features/covid_detection/presentation/pages/covid_detection_page.dart';
import 'features/covid_news/presentation/pages/global_covid_news_page.dart';
import 'features/covid_news/presentation/pages/usa_covid_news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  int segmentedControlGroupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CovidDetectionPage()));
              },
              icon: const Icon(Icons.medical_services))
        ],
        title: Text(
          selectedIndex == 0
              ? AppLocalizations.of(context)!
                  .translate('covidCasesAppBarTitle')!
              : AppLocalizations.of(context)!
                  .translate('covidNewsAppBarTitle')!,
          style: C19Theme.lightTextTheme.bodyText1!.copyWith(
              color: Colors.white,
              fontSize: 22),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [
                Color(0XFF7BA8E6),
                Color(0XFF1D53C4),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15.0),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                clipBehavior: Clip.hardEdge,
                child: CupertinoSlidingSegmentedControl<int>(
                  backgroundColor: Colors.grey.shade300,
                  thumbColor: Color.alphaBlend(
                      const Color(0XFF7BA8E6), const Color(0XFF1D53C4)),
                  onValueChanged: (val) =>
                      setState(() => segmentedControlGroupValue = val!),
                  groupValue: segmentedControlGroupValue,
                  padding: EdgeInsets.zero,
                  children: <int, Widget>{
                    0: Text(
                      selectedIndex == 0
                          ? AppLocalizations.of(context)!
                              .translate('covidCasesWorldwideTitle')!
                          : AppLocalizations.of(context)!
                              .translate('covidNewsWorldwideTitle')!,
                      style: C19Theme.lightTextTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    1: Text(
                      selectedIndex == 0
                          ? AppLocalizations.of(context)!
                              .translate('covidCasesCountryTitle')!
                          : AppLocalizations.of(context)!
                              .translate('covidNewsUsaTitle')!,
                      style: C19Theme.lightTextTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: selectedIndex == 0
                ? segmentedControlGroupValue == 0
                    ? const GlobalCovidCasePage()
                    : const CountryCovidCasePage()
                : segmentedControlGroupValue == 0
                    ? const GlobalCovidNewsPage()
                    : const UsaCovidNewsPage(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [
              Color(0XFF7BA8E6),
              Color(0XFF1D53C4),
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: BottomNavyBar(
          showElevation: true,
          curve: Curves.easeInOutBack,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          backgroundColor: Colors.transparent,
          onItemSelected: (val) => setState(
            () {
              selectedIndex = val;
              segmentedControlGroupValue = 0;
            },
          ),
          iconSize: 32,
          selectedIndex: selectedIndex,
          animationDuration: const Duration(seconds: 1),
          items: [
            BottomNavyBarItem(
                icon: const Icon(Icons.contactless_outlined),
                title: Text(
                  AppLocalizations.of(context)!
                      .translate('bottomBarCaseTitle')!,
                  style: C19Theme.lightTextTheme.bodyText1!.copyWith(color: Colors.white)
                ),
                activeColor: Colors.white,
                inactiveColor: Colors.white70),
            BottomNavyBarItem(
                icon: const Icon(Icons.campaign_outlined),
                title: Text(
                  AppLocalizations.of(context)!
                      .translate('bottomBarNewsTitle')!,
                  style: C19Theme.lightTextTheme.bodyText1!.copyWith(color: Colors.white)
                  ,
                ),
                activeColor: Colors.white,
                inactiveColor: Colors.white70),
          ],
        ),
      ),
    );
  }
}
