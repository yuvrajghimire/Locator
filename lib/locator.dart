import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Locator extends StatefulWidget {
  const Locator({Key? key}) : super(key: key);

  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  @override
  void initState() {
    super.initState;
  }

  var latitude = 0.0;
  var longitude = 0.0;

  getLocation() async {
    Location location = Location();

    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;
    LocationData? _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blueGrey.shade800,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Icon(Icons.location_on, color: Colors.white, size: 60),
              ),
              const SizedBox(height: 20),
              Text(
                'Latitude : $latitude',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Longitude : $longitude',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10)),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () async {
                    var location = await getLocation();
                    setState(() {
                      latitude = location.latitude;
                      longitude = location.longitude;
                    });
                  },
                  child: const Text('Get My Location',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10)),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () async {
                    var location = await getLocation();
                    Navigator.pushNamed(context, 'map', arguments: {
                      'latitude': location.latitude,
                      'longitude': location.longitude
                    });
                  },
                  child: const Text(
                    'See on Map',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
