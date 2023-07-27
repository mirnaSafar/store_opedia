import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

import '../location_service.dart';

class MapPage extends StatefulWidget {
  final LocationData currentLocation;
  const MapPage({Key? key, required this.currentLocation}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  late CameraPosition initalCameraPosition;

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
    LocationService()
        .getAddressInfo(LocationData.fromMap({
          'latitude': selectedLocation.latitude,
          'longitude': selectedLocation.longitude,
        }))
        .then(
          (value) => selectedLocationAddress =
              '${value?.administrativeArea ?? ''}-${value?.street ?? ''}',
        );
    markers.add(Marker(
        markerId: const MarkerId('Current'),
        position: LatLng(widget.currentLocation.latitude ?? 37.43296265331129,
            widget.currentLocation.longitude ?? -122.08832357078792)));
    // BlocProvider.of<FilterCubit>(context)
    //     .filterPostsWithLocation(location: selectedLocationAddress);
    // List<dynamic> shops = BlocProvider.of<FilterCubit>(context).filteredPosts;

    // for (var element in shops) {
    //   markers.add(Marker(
    //       markerId: MarkerId(element.ownerID + element.shopID),
    //       position: LatLng(element.latitude ?? 37.43296265331129,
    //           element.longitude ?? -122.08832357078792)));
    // }
    super.initState();
  }

  Set<Marker> markers = {};

  late LatLng selectedLocation;
  String selectedLocationAddress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initalCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

          setState(() {});
        },
        markers: markers,
        onTap: (latlong) {
          setState(() {
            selectedLocation = latlong;
            changeStoreLoaction();
            markers.add(Marker(
                markerId: const MarkerId('Current'),
                position: LatLng(latlong.latitude, latlong.longitude)));
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pop(selectedLocation),
        label: Text(selectedLocationAddress),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  void changeStoreLoaction() {
    setState(() {
      LocationService()
          .getAddressInfo(LocationData.fromMap({
            'latitude': selectedLocation.latitude,
            'longitude': selectedLocation.longitude,
          }))
          .then(
            (value) => selectedLocationAddress =
                '${value?.administrativeArea ?? ''}-${value?.street ?? ''}',
          );
    });
    setState(() {});
  }
}
