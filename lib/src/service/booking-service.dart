import 'package:daladala_smart/src/api/apis.dart';
import 'package:daladala_smart/src/functions/splash.dart';
import 'package:daladala_smart/src/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';

class bookingService {
  Api api = Api();

  Future getbookings(
      BuildContext context, String date, String time, String bus_id) async {
    Map<String, dynamic> data = {
      'date': date.toString(),
      'time': time.toString(),
      'bus_id': bus_id.toString(),
    };
    final response = await api.post(context, 'bookings/get_number.php', data);
    return response;
  }

  Future postbookings(BuildContext context, String bus_id, String date,
      String time, String paymentType, String seats) async {
    final SplashFunction _splashFunction = await SplashFunction();
    var user_id = await _splashFunction.getId();
    Map<String, dynamic> data = {
      'bus_id': bus_id.toString(),
      'user_id': user_id.toString(),
      'date': date.toString(),
      'time': time.toString(),
      'payment_type': paymentType.toString(),
      'seats': seats.toString(),
    };
    final response = await api.post(context, 'bookings/post_book.php', data);
    if (response == 'Successfully booked enjoy your trip') {
      AppSnackbar(
        isError: false,
        response: response,
      ).show(context);
    } else {
      AppSnackbar(
        isError: true,
        response: response,
      ).show(context);
    }
    return response;
  }
}
