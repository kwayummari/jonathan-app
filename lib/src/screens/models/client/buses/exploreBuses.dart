import 'package:daladala_smart/src/screens/models/client/buses/view.dart';
import 'package:daladala_smart/src/service/exploreBusesDetails-service.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class exploreBuses extends StatefulWidget {
  var id;
  var busNumber;

  exploreBuses({Key? key, required this.id, required this.busNumber})
      : super(key: key);

  @override
  State<exploreBuses> createState() => _exploreBusesState();
}

class _exploreBusesState extends State<exploreBuses> {
  @override
  void initState() {
    super.initState();
    getBusesDetails();
  }

  List details = [];

  Future<List> getBusesDetails() async {
    final busDetailsService _busesDetailsService = await busDetailsService();
    final List busesDetailsList =
        await _busesDetailsService.getBusDetails(context, widget.id);
    setState(() {
      details = busesDetailsList;
    });
    return busesDetailsList;
  }

  @override
  Widget build(BuildContext context) {
    return details.length == 0
        ? Container(
            child: SpinKitThreeInOut(
              size: 50,
              color: AppConst.white,
            ),
          )
        : viewBusDetails(
            id: widget.id,
            busNumber: widget.busNumber,
            driver: details[0]['driver_name'],
            conductor: details[0]['conductor_name'],
            number_of_seat: details[0]['number_of_seat'],
            bus_type: details[0]['bus_type'],
            owner: details[0]['owner'],
            image: details[0]['image']);
  }
}
