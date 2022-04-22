import 'package:flutter/cupertino.dart';

import 'package:c19/core/util/c19_theme.dart';
import '../../../../app_localizations.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 6,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(AppLocalizations.of(context)!.translate('loadingMessage')!,style: C19Theme.lightTextTheme.headline6!.copyWith(fontSize: 18.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
            ),
            const SizedBox(height: 12.0),
            const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
