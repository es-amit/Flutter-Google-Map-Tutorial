import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Completer<GoogleMapController> _controller = Completer();

  // getting user current location
  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.702070, 77.313880),
    zoom: 14.4746);

  List<Marker> _marker = [];
  final List<Marker> _list= [
    // Marker(
    //   markerId: MarkerId("1"),
    //   position: LatLng(28.702070, 77.313880),
    //   infoWindow: InfoWindow(
    //     title: "My position"
    //   )
    // ),
    Marker(
      markerId: MarkerId("2"),
      position: LatLng(28.707190, 77.322180),
      infoWindow: InfoWindow(
        title: "Hindon"
      )
    ),
    Marker(
      markerId: MarkerId("3"),
      position: LatLng(28.7214, 77.1409),
      infoWindow: InfoWindow(
        title: "Vips"
      )
    ),
  ];
  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_marker),
        compassEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          getUserCurrentLocation().then((value) async {
            // print(value.latitude.toString() + " "+ value.longitude.toString());
            _marker.add(
              Marker(
                markerId: const MarkerId("10"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(
                  title: "My current Location"
                )
              )
            );

            CameraPosition cameraPosition = CameraPosition(
              zoom: 16,
              target: LatLng(value.latitude, value.longitude));

            final GoogleMapController controller = await _controller.future;

            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {
              
            });
          });
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}