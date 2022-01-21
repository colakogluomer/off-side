import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapTest extends StatelessWidget {
  const MapTest({Key? key}) : super(key: key);

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("map Test"),
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
