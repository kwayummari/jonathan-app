import 'package:daladala_smart/src/service/navigation-service.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/utils/routes/route-names.dart';
import 'package:daladala_smart/src/widgets/app_base_screen.dart';
import 'package:daladala_smart/src/widgets/app_button.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';
import 'package:daladala_smart/src/widgets/app_typeAheadFormFIeld.dart';
import 'package:flutter/material.dart';

class navigation extends StatefulWidget {
  const navigation({super.key});
  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  @override
  void initState() {
    super.initState();
    getDestination();
  }

  var destination;
  List destinations = [];
  List directions = [];
  var pickupPoint;
  Future<void> getDestination() async {
    final navigationService _navigationService = await navigationService();
    final List destinationsList =
        await _navigationService.getDestination(context, 'destination/get.php');
    setState(() {
      this.destinations = destinationsList;
    });
  }

  TextEditingController destin = TextEditingController();
  TextEditingController pickup = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
        isvisible: true,
        backgroundImage: false,
        backgroundAuth: false,
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: AppConst.white,
                    size: 25,
                  ),
                  AppText(
                    txt: 'Your route',
                    size: 25,
                    weight: FontWeight.w900,
                    color: AppConst.white,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TypeAheadFormFieldWidget(
              controller: destin,
              hintText: 'Destination',
              hintStyle: TextStyle(color: AppConst.white, fontSize: 15),
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              suggestionsCallback: (String pattern) async {
                List<dynamic> filteredDestinations = destinations
                    .where((destination) => destination['name']
                        .toLowerCase()
                        .contains(pattern.toLowerCase()))
                    .toList();
                return Future.value(filteredDestinations);
              },
              itemBuilder: (BuildContext context, dynamic suggestion) {
                return ListTile(
                  title: AppText(
                    txt: suggestion['name'],
                    size: 15,
                    color: AppConst.primary,
                  ),
                );
              },
              onSuggestionSelected: (dynamic suggestion) {
                setState(() {
                  destin.text = suggestion['name'];
                  List<String> d = destin.text.toString().split('-');
                  directions = List.generate(
                      d.length,
                      (index) => {
                            'name': d[index],
                            'id': (index + 1).toString(),
                          });

                  destination = suggestion['id'];
                });
              },
            ),
            TypeAheadFormFieldWidget(
              controller: pickup,
              hintText: 'Pickup Point',
              hintStyle: TextStyle(color: AppConst.white, fontSize: 15),
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              suggestionsCallback: (String pattern) async {
                List<dynamic> filteredDestinations = destinations
                    .where((destination) => destination['name']
                        .toLowerCase()
                        .contains(pattern.toLowerCase()))
                    .toList();
                return Future.value(filteredDestinations);
              },
              itemBuilder: (BuildContext context, dynamic suggestion) {
                return ListTile(
                  title: AppText(
                    txt: suggestion['name'],
                    size: 15,
                    color: AppConst.primary,
                  ),
                );
              },
              onSuggestionSelected: (dynamic suggestion) {
                setState(() {
                  pickup.text = suggestion['name'];
                  List<String> d = pickup.text.toString().split('-');
                  pickupPoint = suggestion['id'];
                  print(pickupPoint);
                });
              },
            ),
            Container(
              width: 330,
              height: 45,
              child: AppButton(
                  onPress: () => Navigator.pushNamed(
                        context,
                        RouteNames.searchBus,
                        arguments: {
                          'destination': destination.toString(),
                          'pickupPoint': pickupPoint.toString(),
                        },
                      ),
                  label: 'Submit',
                  borderRadius: 20,
                  textColor: AppConst.white,
                  bcolor: AppConst.primary),
            )
          ],
        ));
  }
}
