import 'package:daladala_smart/src/api/apis.dart';
import 'package:flutter/material.dart';

class busDetailsService {
  Api api = Api();

  Future getBusDetails(
      BuildContext context, String id) async {
    Map<String, dynamic> data = {
      'id': id.toString(),
    };
    final response = await api.post(context, 'bus/get_byid.php', data);
    return response;
  }
}
