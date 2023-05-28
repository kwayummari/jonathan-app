import 'package:daladala_smart/src/api/apis.dart';
import 'package:flutter/material.dart';

class busHoursService {
  Api api = Api();

  Future getBusHours(
      BuildContext context, String id) async {
    Map<String, dynamic> data = {
      'id': id.toString(),
    };
    final response = await api.post(context, 'bus/get_bushours.php', data);
    return response;
  }
}