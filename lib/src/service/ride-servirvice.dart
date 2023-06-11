import 'package:daladala_smart/src/api/apis.dart';
import 'package:daladala_smart/src/functions/splash.dart';
import 'package:flutter/material.dart';

class RideService {
  Api api = Api();

  Future getRides(
      BuildContext context) async {
        final SplashFunction _splashFunction = await SplashFunction();
        var user_id = await _splashFunction.getId();
    Map<String, dynamic> data = {
      'id': user_id.toString(),
    };
    final response = await api.post(context, 'bookings/get.php', data);
    return response;
  }

  Future getdriverRides(
      BuildContext context) async {
        final SplashFunction _splashFunction = await SplashFunction();
        var bus_id = await _splashFunction.getBusId();
    Map<String, dynamic> data = {
      'id': bus_id.toString(),
    };
    final response = await api.post(context, 'bookings/get_by_bus.php', data);
    return response;
  }
}
