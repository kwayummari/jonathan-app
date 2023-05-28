import 'package:daladala_smart/src/service/map-serivces.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/utils/routes/route-names.dart';
import 'package:daladala_smart/src/widgets/app_map.dart';
import 'package:daladala_smart/src/widgets/app_base_screen.dart';
import 'package:daladala_smart/src/widgets/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  Position? position;
  @override
  void initState() {
    super.initState();
    getHome();
  }

  Future getHome() async {
    final mapService _mapService = await mapService();
    position = await _mapService.determinePosition();
  }

  TextEditingController search = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      padding: EdgeInsets.all(0),
      child: Stack(
        children: [
          FutureBuilder(
            future: getHome(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: CustomGoogleMap(
                    initialCameraPosition:
                        LatLng(position!.latitude, position!.longitude),
                    markers: Set<Marker>.of([
                      Marker(
                        markerId: MarkerId("Your Location"),
                        position:
                            LatLng(position!.latitude, position!.longitude),
                        icon: BitmapDescriptor.defaultMarker,
                        infoWindow: InfoWindow(
                          title: 'Your Location',
                          onTap: () => null,
                        ),
                      ),
                    ]),
                  ),
                );
              }
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 200,
            child: Container(
              decoration: BoxDecoration(
                color: AppConst.black,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: GestureDetector(
                      onTap: () => 
                      Navigator.pushNamed(context, RouteNames.navigation),
                      child: AppInputText(
                          enabled: false,
                          suffixicon: IconButton(
                              onPressed: () => null,
                              icon: Icon(
                                Icons.search,
                                color: AppConst.white,
                              )),
                          // circle: 50,
                          textfieldcontroller: search,
                          isemail: false,
                          fillcolor: AppConst.primary,
                          label: 'Where to?',
                          ispassword: false,
                          obscure: false),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
