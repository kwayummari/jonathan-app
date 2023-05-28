import 'package:daladala_smart/src/widgets/app_base_screen.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';
import 'package:flutter/material.dart';

class myRides extends StatefulWidget {
  const myRides({Key? key}) : super(key: key);

  @override
  State<myRides> createState() => _myRidesState();
}

class _myRidesState extends State<myRides> {
  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(child: Column(
      children: [
        Row(
          children: [
            AppText(txt: '', size: 15)
          ],
        )
      ],
    ), isvisible: false, backgroundImage: false, backgroundAuth: false);
  }
}
