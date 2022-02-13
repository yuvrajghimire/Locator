import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMap extends StatefulWidget {
  const OpenStreetMap({Key? key}) : super(key: key);

  @override
  _OpenStreetMapState createState() => _OpenStreetMapState();
}

class _OpenStreetMapState extends State<OpenStreetMap> {
  var latitude = 51.5;
  var longitude = -0.09;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    latitude = arguments['latitude'];
    longitude = arguments['longitude'];
    return SafeArea(
      child: Scaffold(
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(latitude, longitude),
            zoom: 13.0,
            crs: const Epsg3857(),
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(latitude, longitude),
                  builder: (ctx) => const Icon(Icons.location_on,
                      color: Colors.red, size: 40),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
