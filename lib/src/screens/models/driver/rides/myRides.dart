import 'package:daladala_smart/src/functions/bus_rides.dart';
import 'package:daladala_smart/src/service/booking-service.dart';
import 'package:daladala_smart/src/service/ride-servirvice.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/widgets/app_base_screen.dart';
import 'package:daladala_smart/src/widgets/app_button.dart';
import 'package:daladala_smart/src/widgets/app_listtile.dart';
import 'package:daladala_smart/src/widgets/app_listview_builder.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class myRides extends StatefulWidget {
  const myRides({Key? key}) : super(key: key);

  @override
  State<myRides> createState() => _myRidesState();
}

class _myRidesState extends State<myRides> {
  late Future<List> _futureRideList;

  @override
  void initState() {
    super.initState();
    _futureRideList = getRides();
  }

  Future<List> getRides() async {
    final RideService _ridesService = await RideService();
    final List ridesList = await _ridesService.getdriverRides(context);
    return ridesList;
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
        child: StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 120))
              .asyncMap((i) => _futureRideList = getRides()),
          builder: (context, snapshot) => FutureBuilder<List>(
            future: _futureRideList,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: SpinKitThreeInOut(
                  size: 50,
                  color: AppConst.white,
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final rideList = snapshot.data!;
                return AppListviewBuilder(
                  itemnumber: rideList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final rides = Rides.fromMap(rideList[index]);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppListTile(
                        leading: CircleAvatar(
                            backgroundColor: AppConst.grey400,
                            radius: 20.0,
                            child: AppText(
                                color: AppConst.black,
                                txt: rides.user_id.toString().substring(0, 1),
                                size: 15)),
                        title: AppText(
                          txt: rides.date.substring(0, 11),
                          size: 15,
                          weight: FontWeight.bold,
                          color: AppConst.black,
                        ),
                        subTitle: AppText(
                          txt: rides.time,
                          color: AppConst.black,
                          size: 12,
                        ),
                        trailing: AppButton(
                            onPress: () {
                              if (rides.status == '0') {
                                bookingService()
                                    .updatebookings(context, rides.id);
                              } else {
                                null;
                              }
                            },
                            label: rides.status == '0' ? 'Pending' : 'Accepted',
                            borderRadius: 10,
                            textColor: AppConst.white,
                            bcolor: AppConst.primary),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text('No Buses available at the moment'));
              }
            },
          ),
        ),
        isvisible: false,
        backgroundImage: false,
        backgroundAuth: false);
  }
}
