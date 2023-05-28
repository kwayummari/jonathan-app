// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, duplicate_ignore, prefer_const_constructors, body_might_complete_normally_nullable, prefer_if_null_operators, no_leading_underscores_for_local_identifiers, unused_element, avoid_print, unused_label

import 'package:daladala_smart/src/service/busHours-service.dart';
import 'package:daladala_smart/src/utils/animations/fadeanimation.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/utils/routes/route-names.dart';
import 'package:daladala_smart/src/widgets/app-image-network.dart';
import 'package:daladala_smart/src/widgets/app_button.dart';
import 'package:daladala_smart/src/widgets/app_listview_builder.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';
import 'package:flutter/material.dart';

class viewBusDetails extends StatefulWidget {
  var id;
  var driver;
  var conductor;
  var number_of_seat;
  var bus_type;
  var owner;
  var image;
  var busNumber;

  // ignore: non_constant_identifier_names
  viewBusDetails({
    Key? key,
    required this.id,
    required this.driver,
    required this.conductor,
    required this.number_of_seat,
    required this.bus_type,
    required this.owner,
    required this.image,
    required this.busNumber,
  }) : super(key: key);

  @override
  State<viewBusDetails> createState() => _viewBusDetailsState();
}

class _viewBusDetailsState extends State<viewBusDetails> {
  @override
  void initState() {
    super.initState();
    getBusesHours();
  }

  List hours = [];

  Future<List> getBusesHours() async {
    final busHoursService _busesHoursService = await busHoursService();
    final List busesHoursList =
        await _busesHoursService.getBusHours(context, widget.id);
    setState(() {
      hours = busesHoursList;
    });
    return busesHoursList;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FadeAnimation(
              1.2,
              appImageNetwork(
                endPoint: 'bus/images/${widget.image}',
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: FadeAnimation(
              1.2,
              CircleAvatar(
                backgroundColor: AppConst.primary,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: mediaQuery.size.height / 1.5,
            child: FadeAnimation(
              1.2,
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppConst.black,
                  border: Border.all(color: AppConst.primary),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeAnimation(
                        1.3,
                        Center(
                          child: AppText(
                            txt: '${widget.busNumber}',
                            color: AppConst.white,
                            size: 18,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: AppConst.primary,
                      ),
                      FadeAnimation(
                        1.3,
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppConst.primary,
                              child: Icon(Icons.person, color: AppConst.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                              txt: 'Bus Owner - ${widget.owner}',
                              color: AppConst.white,
                              size: 15,
                              weight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.3,
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppConst.primary,
                              child: Icon(Icons.drive_eta_rounded,
                                  color: AppConst.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                              txt: 'Bus Driver - ${widget.driver}',
                              color: AppConst.white,
                              size: 15,
                              weight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.3,
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: AppConst.primary,
                                child: Icon(Icons.assignment_ind,
                                    color: AppConst.white)),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                              txt: 'Bus Conductor - ${widget.conductor}',
                              color: AppConst.white,
                              size: 15,
                              weight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        1.3,
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: AppConst.primary,
                                child: Icon(Icons.bus_alert_rounded,
                                    color: AppConst.white)),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                              txt: 'Bus type - ${widget.bus_type}',
                              color: AppConst.white,
                              size: 15,
                              weight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: AppConst.primary,
                      ),
                      if (hours.isNotEmpty)
                        AppText(
                          txt: 'Working Hours',
                          size: 15,
                          color: AppConst.white,
                          weight: FontWeight.w900,
                        ),
                      if (hours.isNotEmpty)
                        AppListviewBuilder(
                            itemnumber: hours.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: AppText(
                                  txt: hours[index]['timeline'],
                                  size: 15,
                                  color: AppConst.white,
                                ),
                              );
                            }),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 300,
                          height: 50,
                          child: AppButton(
                            onPress: () => Navigator.pushNamed(
                                context, RouteNames.bookBus,
                                arguments: {'id': widget.id, 'seats': widget.number_of_seat}),
                            label: 'Book Bus',
                            bcolor: AppConst.primary,
                            borderRadius: 20,
                            textColor: AppConst.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
