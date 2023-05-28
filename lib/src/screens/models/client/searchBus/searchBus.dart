import 'package:daladala_smart/src/service/map-serivces.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/utils/routes/route-names.dart';
import 'package:daladala_smart/src/widgets/app_button.dart';
import 'package:daladala_smart/src/widgets/app_base_screen.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

class searchBus extends StatefulWidget {
  var destination;
  var dire;
  var route;
  searchBus({
    Key? key,
    required this.destination,
    required this.dire,
    required this.route,
  }) : super(key: key);

  @override
  State<searchBus> createState() => _searchBusState();
}

class _searchBusState extends State<searchBus> {
  Position? position;
  @override
  void initState() {
    super.initState();
    _navigatortohome();
  }

  Future getHome() async {
    final mapService _mapService = await mapService();
    position = await _mapService.determinePosition();
  }

  _navigatortohome() async {
    await getHome().whenComplete(() async {
      await Future.delayed(Duration(seconds: 5), () {});
      Navigator.pushNamed(
        context,
        RouteNames.buses,
        arguments: {
          'destination': widget.destination.toString(),
          'dire': widget.dire.toString(),
          'route': widget.route.toString(),
        },
      );
    });
  }

  TextEditingController search = TextEditingController();
  bool marked = true;
  bool marked1 = false;
  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      isvisible: true,
      backgroundImage: false,
      backgroundAuth: false,
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          SizedBox(height: 150,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Image.asset('assets/kfc.jpg'),
          ),
          SizedBox(height: 10,),
          AppText(txt: 'Get 10% off when you order \n      with our promo code', size: 20, weight: FontWeight.w900, color: AppConst.gold,),
          AppButton(onPress: () => null, label: "Order Now", borderRadius: 20, textColor: AppConst.white, bcolor: AppConst.primary),
          SpinKitThreeInOut(
            size: 50,
            color: AppConst.white,
          ),
          AppText(
            txt: 'Searching for Provider',
            size: 15,
            color: AppConst.white,
          ),
        ],
      ),
    );
  }
}
