import 'package:flutter/material.dart';

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';

import 'package:c19/app_localizations.dart';
import 'package:c19/core/util/c19_theme.dart';
import 'package:c19/features/covid_detection/presentation/covid_detection_provider.dart';
import 'package:c19/features/covid_detection/presentation/widgets/background.dart';
import 'package:c19/home_page.dart';

class CovidDetectionDisplay extends StatefulWidget {
  const CovidDetectionDisplay({Key? key}) : super(key: key);

  @override
  _CovidDetectionDisplayState createState() => _CovidDetectionDisplayState();
}

class _CovidDetectionDisplayState extends State<CovidDetectionDisplay>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    Provider.of<Detection>(context, listen: false).loadModel().then((value) {
      setState(() {
        // pass
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _isLoading = Provider.of<Detection>(context).loading;
    var _image = Provider.of<Detection>(context).image;
    var _output = Provider.of<Detection>(context).output;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate('covidDetectionAppBarTitle')!,
          style: C19Theme.lightTextTheme.bodyText1!
              .copyWith(color: Colors.white, fontSize: 22),
        ),
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
      body: Background(
        child: Column(
          children: <Widget>[
            Center(
              child: _isLoading
                  ? Column(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/images/undraw_medical_research_qg4d.svg',
                        ),
                      ],
                    )
                  : Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.grey.shade300,
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            constraints: const BoxConstraints.expand(
                              width: 350,
                              height: 370,
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: Image.file(_image!).image,
                                fit: BoxFit.fill,
                              ),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                          _output != null
                              ? Text(
                                  double.parse(_output
                                              .toString()
                                              .split(',')[0]
                                              .split(':')[1]) >
                                          0.7
                                      ? AppLocalizations.of(context)!.translate('covidDetectionCovidDetected')!
                                      : AppLocalizations.of(context)!.translate('covidDetectionReportNormal')!,
                                  style: C19Theme.lightTextTheme.bodyText1!
                                      .copyWith(
                                          color: Colors.black,
                                          fontSize: 25),
                                )
                              : Text(
                            AppLocalizations.of(context)!.translate('covidDetectionUnknownResult')!,
                                  style: C19Theme.lightTextTheme.bodyText1!
                                      .copyWith(
                                          color: Colors.black,
                                          fontSize: 25),
                                ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
            title: AppLocalizations.of(context)!
                .translate('covidDetectionFloatingActionBubble3')!,
            iconColor: Colors.white,
            bubbleColor: Color.alphaBlend(
                const Color(0XFF7BA8E6), const Color(0XFF1D53C4)),
            icon: Icons.photo_library,
            titleStyle: C19Theme.lightTextTheme.bodyText1!
                .copyWith(color: Colors.white, fontSize: 16),
            onPress: () {
              Provider.of<Detection>(context, listen: false).pickGalleryImage();
              _animationController!.reverse();
            },
          ),
          Bubble(
            title: AppLocalizations.of(context)!
                .translate('covidDetectionFloatingActionBubble2')!,
            iconColor: Colors.white,
            bubbleColor: Color.alphaBlend(
                const Color(0XFF7BA8E6), const Color(0XFF1D53C4)),
            icon: Icons.camera_outlined,
            titleStyle: C19Theme.lightTextTheme.bodyText1!
                .copyWith(color: Colors.white, fontSize: 16),
            onPress: () {
              Provider.of<Detection>(context, listen: false).pickImage();
              _animationController!.reverse();
            },
          ),
          Bubble(
            title: AppLocalizations.of(context)!
                .translate('covidDetectionFloatingActionBubble1')!,
            iconColor: Colors.white,
            bubbleColor: Color.alphaBlend(
                const Color(0XFF7BA8E6), const Color(0XFF1D53C4)),
            icon: Icons.arrow_back_sharp,
            titleStyle: C19Theme.lightTextTheme.bodyText1!
                .copyWith(color: Colors.white, fontSize: 16),
            onPress: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomePage()));
              _animationController!.reverse();
            },
          ),
        ],
        animation: _animation!,
        onPress: () => _animationController!.isCompleted
            ? _animationController!.reverse()
            : _animationController!.forward(),
        iconColor:
            Color.alphaBlend(const Color(0XFF7BA8E6), const Color(0XFF1D53C4)),
        iconData: Icons.settings,
        backGroundColor: Colors.white,
      ),
    );
  }
}
