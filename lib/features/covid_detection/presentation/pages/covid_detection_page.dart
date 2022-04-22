import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:c19/features/covid_detection/presentation/covid_detection_provider.dart';
import 'package:c19/features/covid_detection/presentation/widgets/covid_detection_display.dart';

class CovidDetectionPage extends StatelessWidget {
  const CovidDetectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Detection>(
      builder: (ctx, value, _) {
        return const CovidDetectionDisplay();
      },
    );
  }
}
