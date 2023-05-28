import 'package:daladala_smart/src/screens/models/client/rides/history.dart';
import 'package:daladala_smart/src/screens/models/client/rides/myRides.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';
import 'package:flutter/material.dart';

class rides extends StatefulWidget {
  const rides({super.key});

  @override
  State<rides> createState() => _ridesState();
}

class _ridesState extends State<rides> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
              physics: BouncingScrollPhysics(),
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, value) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.black,
                    stretch: true,
                    floating: true,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    // expandedHeight: 200,
                    title: AppText(
                      txt: 'Your Rides',
                      color: AppConst.white,
                      size: 15,
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        'assets/ads.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    bottom: TabBar(tabs: [
                      Tab(
                        icon: Icon(
                          Icons.car_rental,
                          color: AppConst.primary,
                        ),
                        child: Text(
                          'My Rides',
                          style:
                          TextStyle(color: Color.fromARGB(255, 208, 208, 208)),
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.history_edu_outlined,
                          color: AppConst.primary,
                        ),
                        child: Text(
                          'History',
                          style:
                          TextStyle(color: Color.fromARGB(255, 208, 208, 208)),
                        ),
                      ),
                    ]),
                  ),
                ];
              },
              body: TabBarView(children: [
                myRides(),
                history(),
              ])),
        ));
  }
}
