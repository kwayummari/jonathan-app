import 'package:daladala_smart/src/functions/bus.dart';
import 'package:daladala_smart/src/functions/distance.dart';
import 'package:daladala_smart/src/service/bus-services.dart';
import 'package:daladala_smart/src/utils/animations/busesListShimmer.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/utils/routes/route-names.dart';
import 'package:daladala_smart/src/widgets/app_base_screen.dart';
import 'package:daladala_smart/src/widgets/app_listtile.dart';
import 'package:daladala_smart/src/widgets/app_listview_builder.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class buses extends StatefulWidget {
  var destination;
  var dire;
  var route;

  buses({
    Key? key,
    required this.destination,
    required this.dire,
    required this.route,
  }) : super(key: key);

  @override
  State<buses> createState() => _busesState();
}

class _busesState extends State<buses> {
  late Future<List> _futureBusList;

  @override
  void initState() {
    super.initState();
    _futureBusList = getBuses();
  }

  Future<List> getBuses() async {
    final busService _busesService = await busService();
    final List busesList = await _busesService.getBus(
        context, widget.destination, widget.dire, widget.route);
    return busesList;
  }

  Future<String> getDistance(live_location) async {
    final distanceFunction _distance = distanceFunction();
    final double distance = await _distance.getHome(live_location);
    final double actualDistance = double.parse(distance.toStringAsFixed(4));
    return actualDistance.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppConst.white,
          ),
          onPressed: () => Navigator.pushNamed(context, RouteNames.navigation),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: AppConst.white,
            ),
            onPressed: () => Navigator.pushNamed(context, RouteNames.bottomNavigationBar),
          )
        ],
        backgroundColor: AppConst.primary,
        title: AppText(
          txt: 'Available Buses',
          size: 15,
          color: AppConst.white,
        ),
      ),
      child: StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 60)).asyncMap((i) =>
            _futureBusList =
                getBuses()), // i is null here (check periodic docs)
        builder: (context, snapshot) => FutureBuilder<List>(
          future: _futureBusList,
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
              final busList = snapshot.data!;
              return AppListviewBuilder(
                itemnumber: busList.length,
                itemBuilder: (BuildContext context, int index) {
                  final bus = Bus.fromMap(busList[index]);
                  return FutureBuilder<String>(
                    future: getDistance(bus.liveLocation),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return busesShimmerLoading(
                            width: MediaQuery.of(context).size.width,
                            height: 70,
                            borderRadius: 0);
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final distance = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppListTile(
                            leading: CircleAvatar(
                                backgroundColor: AppConst.grey400,
                                radius: 20.0,
                                child: AppText(
                                    color: AppConst.black,
                                    txt: bus.number.substring(0, 3),
                                    size: 15)),
                            title: AppText(
                              txt: bus.number,
                              size: 15,
                              weight: FontWeight.bold,
                              color: AppConst.black,
                            ),
                            subTitle: AppText(
                              txt: '${distance} Km',
                              color: AppConst.black,
                              size: 12,
                            ),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.exploreBuses,
                                arguments: {
                                  'id': bus.id.toString(),
                                  'busNumber': bus.number.toString(),
                                },
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                            child: Text('No Buses available at the moment'));
                      }
                    },
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
      backgroundAuth: false,
    );
  }
}
