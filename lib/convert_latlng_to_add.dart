import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({super.key});

  @override
  State<ConvertLatLangToAddress> createState() => _ConvertLatLangToAddressState();
}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {
  String address = '123 Main St';
  double latitude = 0.0;
  double longitude = 0.0;
  Future<void> getLocationFromAddress(String inputAddress) async {
    try {
      List<Location> locations = await locationFromAddress(inputAddress);
      setState(() {
        latitude = locations.first.latitude;
        longitude = locations.first.longitude;
      });
    } catch (e) {
      print('Error: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Address"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(latitude.toString()),
            Text(longitude.toString()),
            ElevatedButton(
              onPressed: ()async{
                getLocationFromAddress("B-3/411, 33 Foota Road, Harsh Vihar, Delhi -110093");
            }, 
            child: const Text("Convert"))
          ],
        ),
      ),
    );
  }
}