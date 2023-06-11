import 'package:daladala_smart/src/api/apis.dart';
import 'package:flutter/material.dart';

class busService {
  Api api = Api();

  Future getBus(
      BuildContext context, String destination, String pickupPoint) async {
    Map<String, dynamic> data = {
      'destination': destination.toString(),
      'pickupPoint': pickupPoint.toString(),
    };
    final response = await api.post(context, 'bus/get.php', data);
    return response;
  }
}
