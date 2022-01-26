import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Screen"),
      ),
      body: SizedBox(
        width: 200,
        height: 200,
        child: FutureBuilder<Position>(
          future: _determinePosition(),
          builder: (_, snapshot) {
            final position = snapshot.data;
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (position == null) {
              return const Center(child: Text("cannot access position"));
            }
            return MapTile(
              position: LatLng(position.latitude, position.longitude),
            );
          },
        ),
      ),
    );
  }
}

class MapTile extends StatelessWidget {
  const MapTile({
    required this.position,
    Key? key,
  }) : super(key: key);

  final LatLng position;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: position,
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            Marker(
                width: 80.0,
                height: 80.0,
                point: position,
                builder: (ctx) => const Icon(Icons.place_outlined)),
          ],
        ),
      ],
    );
  }
}
