import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  final LocationData currentLocation;
  const MapView({Key? key, required this.currentLocation}) : super(key: key);

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  late CameraPosition initalCameraPosition;

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    initalCameraPosition = CameraPosition(
      target: LatLng(widget.currentLocation.latitude ?? 37.43296265331129,
          widget.currentLocation.longitude ?? -122.08832357078792),
      zoom: 14.4746,
    );

    selectedLocation = LatLng(
        widget.currentLocation.latitude ?? 37.43296265331129,
        widget.currentLocation.longitude ?? -122.08832357078792);
    super.initState();
  }

  Set<Marker> markers = {};

  late LatLng selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initalCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

          setState(() {
            markers.add(Marker(
                markerId: const MarkerId('Current'),
                position: LatLng(
                    widget.currentLocation.latitude ?? 37.43296265331129,
                    widget.currentLocation.longitude ?? -122.08832357078792)));
          });
        },
        markers: markers,
        onTap: (latlong) {
          setState(() {
            selectedLocation = latlong;
            markers.add(Marker(
                markerId: const MarkerId('Current'),
                position: LatLng(latlong.latitude, latlong.longitude)));
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
