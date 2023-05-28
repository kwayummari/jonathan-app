import 'package:daladala_smart/src/functions/slide.dart';
import 'package:daladala_smart/src/screens/introduction/slides.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Slide> slides = [
    Slide(
      title: "Let\'s Travel",
      description: "Move Purposefully!",
      backgroundColor: AppConst.primary,
      centerText:
          'Offers a convenient way to plan your commute and get around town.',
    ),
    Slide(
      title: "Let\'s Travel",
      description: "Move Purposefully!",
      backgroundColor: AppConst.primary,
      centerText:
          'Rely on daladala smart up-to-date schedules and real-time information about your bus route.',
    ),
    Slide(
      title: "Let\'s Travel",
      description: "Move Purposefully!",
      backgroundColor: AppConst.primary,
      centerText: 'Save money on transportation costs with the daladala app',
    ),
  ];
  Color activeColor = const Color(0xFF00967B);
  Color inactiveColor = Color.fromARGB(255, 255, 255, 255);
  double sizeIndicator = 20;

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
        isShowNextBtn: false,
        isShowPrevBtn: false,
        isShowSkipBtn: false,
        isShowDoneBtn: false,
        isScrollable: true,
        curveScroll: Curves.easeInOutCubicEmphasized,
        scrollPhysics: const BouncingScrollPhysics(),
        indicatorConfig: IndicatorConfig(
          sizeIndicator: sizeIndicator,
          indicatorWidget: Container(
            width: sizeIndicator,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: inactiveColor),
          ),
          activeIndicatorWidget: Container(
            width: sizeIndicator,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: activeColor),
          ),
          spaceBetweenIndicator: 10,
          typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
        ),
        listCustomTabs: slides);
  }
}
