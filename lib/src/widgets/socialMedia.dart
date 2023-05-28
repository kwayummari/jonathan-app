import 'package:flutter/material.dart';

class socialMedia extends StatefulWidget {
  const socialMedia({Key? key}) : super(key: key);

  @override
  State<socialMedia> createState() => _socialMediaState();
}

class _socialMediaState extends State<socialMedia> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Spacer(),
          GestureDetector(
            onTap: () => null,
            child: Image.asset(
              'assets/google.png',
              height: 40,
            ),
          ),
          SizedBox(width: 20,),
          GestureDetector(
            onTap: () => null,
            child: Image.asset(
              'assets/facebook.png',
              height: 40,
            ),
          ),
          SizedBox(width: 20,),
          GestureDetector(
            onTap: () => null,
            child: Image.asset(
              'assets/twitter.png',
              height: 40,
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
