import 'package:daladala_smart/src/functions/slide.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/widgets/app_button.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';
import 'package:flutter/material.dart';

class Slide extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final String? centerText;

  Slide({
    Key? key,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.centerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Your page content goes here
        Positioned.fill(
          child: Image.asset(
            'assets/intro.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: AppConst.black.withOpacity(0.85),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              Image.asset(
                'assets/icon.png',
                height: 150,
                width: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  align: TextAlign.center,
                  txt: centerText,
                  size: 20,
                  weight: FontWeight.w700,
                  color: AppConst.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 70,
          right: 230,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: AppText(
              txt: title,
              size: 25,
              color: AppConst.white,
            ),
          ),
        ),
        Positioned(
          top: 70,
          right: 210,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: AppText(
              txt: '&',
              size: 25,
              color: AppConst.primary,
            ),
          ),
        ),
        Positioned(
          top: 100,
          right: 130,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: AppText(
              txt: description,
              size: 25,
              color: AppConst.white,
              weight: FontWeight.w900,
            ),
          ),
        ),
        // Bubble in the top right corner
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 130,
            width: 120,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
              color: AppConst.primary,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  bottomLeft: Radius.circular(126),
                  bottomRight: Radius.circular(0)),
            ),
          ),
        ),
        Positioned(
            top: 660,
            bottom: 70,
            left: 80,
            right: 80,
            child: AppButton(
              onPress: () => SlideFunction().login(context),
              label: "Travel Now",
              borderRadius: 20,
              textColor: AppConst.white,
              bcolor: AppConst.primary,
            ))
      ],
    );
  }
}
