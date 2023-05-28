import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  final LatLng initialCameraPosition;
  final Set<Marker> markers;

  CustomGoogleMap({
    required this.initialCameraPosition,
    required this.markers,
  });

  @override
  _CustomGoogleMapState createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  bool _mapLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: widget.initialCameraPosition, zoom: 16),
          markers: widget.markers,
          // mapType: MapType.satellite,
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              _mapLoaded = true;
            });
            controller.setMapStyle("mapbox://styles/mapbox/82cd04a44b2dbc35");
          },
        ),
        if (!_mapLoaded)
          Container(
            color: Colors.grey[300],
            child: Center(
              child: SpinKitCircle(
                      color: AppConst.primary,
                    )
            ),
          ),
      ],
    );
  }
}
