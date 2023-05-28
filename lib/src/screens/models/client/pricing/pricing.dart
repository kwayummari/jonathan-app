import 'package:daladala_smart/src/service/map-serivces.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/widgets/app_map.dart';
import 'package:daladala_smart/src/widgets/app_base_screen.dart';
import 'package:daladala_smart/src/widgets/app_button.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class pricing extends StatefulWidget {
  const pricing({Key? key}) : super(key: key);

  @override
  State<pricing> createState() => _pricingState();
}

class _pricingState extends State<pricing> {
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
  bool marked = true;
  bool marked1 = false;

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
                        markerId: MarkerId("Userlocation"),
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
            height: 400,
            child: Container(
              decoration: BoxDecoration(
                color: AppConst.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        children: [
                          AppText(
                            txt: 'Distance',
                            size: 15,
                            color: AppConst.white,
                            weight: FontWeight.w900,
                          ),
                          Spacer(),
                          AppText(
                            txt: '22.5km',
                            size: 15,
                            color: AppConst.white,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          AppText(
                            txt: 'Price Range',
                            size: 15,
                            color: AppConst.white,
                            weight: FontWeight.w900,
                          ),
                          Spacer(),
                          AppText(
                            txt: '22,500-34,000 Tsh',
                            size: 15,
                            color: AppConst.white,
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Checkbox(
                            fillColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) => AppConst.primary,
                            ),
                            activeColor: AppConst.primary,
                            value: marked,
                            onChanged: (bool? value) {
                              setState(() {
                                marked = !marked;
                              });
                            },
                          ),
                        ),
                        Icon(
                          Icons.money,
                          color: AppConst.white,
                        ),
                        AppText(
                          txt: 'Cash',
                          size: 15,
                          color: AppConst.white,
                        ),
                        Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Checkbox(
                            fillColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) => AppConst.primary,
                            ),
                            activeColor: AppConst.primary,
                            value: marked1,
                            onChanged: (bool? value) {
                              setState(() {
                                marked1 = !marked1;
                              });
                            },
                          ),
                        ),
                        Icon(
                          Icons.credit_card,
                          color: AppConst.white,
                        ),
                        AppText(
                          txt: 'Card',
                          size: 15,
                          color: AppConst.white,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        color: AppConst.grey,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: AppConst.primary,
                        size: 50,
                      ),
                      title: AppText(
                        txt: 'Pickup location',
                        size: 15,
                        weight: FontWeight.w900,
                        color: AppConst.white,
                      ),
                      subtitle: AppText(
                        txt: 'Mlimani City',
                        size: 13,
                        color: AppConst.white,
                      ),
                      trailing: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.edit,
                              color: AppConst.primary,
                            ),
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Icon(
                          Icons.keyboard_double_arrow_down,
                          color: AppConst.primary,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Icon(
                          Icons.keyboard_double_arrow_down,
                          color: AppConst.primary,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: AppConst.primary,
                        size: 50,
                      ),
                      title: AppText(
                        txt: 'Destination',
                        size: 15,
                        weight: FontWeight.w900,
                        color: AppConst.white,
                      ),
                      subtitle: AppText(
                        txt: 'Airport',
                        size: 13,
                        color: AppConst.white,
                      ),
                      trailing: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.edit,
                              color: AppConst.primary,
                            ),
                          )),
                    ),
                    Container(
                      width: 350,
                      child: AppButton(
                          onPress: () => null,
                          // Navigator.pushNamed(context, RouteNames.searchDriver),
                          label: 'Continue',
                          borderRadius: 30,
                          textColor: AppConst.white,
                          bcolor: AppConst.primary),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
