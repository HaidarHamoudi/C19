import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:c19/features/covid_detection/presentation/covid_detection_provider.dart';
import 'app_localizations.dart';
import 'core/util/c19_theme.dart';
import 'features/covid_case/presentation/bloc/country_covid_case_bloc/country_covid_case_bloc.dart';
import 'features/covid_case/presentation/bloc/global_covid_case_bloc/global_covid_case_bloc.dart';
import 'features/covid_news/presentation/bloc/covid_news_bloc.dart';
import 'home_page.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = C19Theme.light();
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalCovidCaseBloc>(
          create: (_) => di.g<GlobalCovidCaseBloc>(),
        ),
        BlocProvider<CountryCovidCaseBloc>(
          create: (_) => di.g<CountryCovidCaseBloc>(),
        ),
        BlocProvider<CovidNewsBloc>(
          create: (_) => di.g<CovidNewsBloc>(),
        ),
      ],
      child: ChangeNotifierProvider<Detection>(
        create: (_) => Detection(),
        child: MaterialApp(
          title: 'C19',
          theme: theme,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ar', 'SY'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportLocale in supportedLocales) {
              if (supportLocale.languageCode == locale!.languageCode &&
                  supportLocale.countryCode == locale.countryCode) {
                return supportLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        ),
      ),
    );
  }
}
