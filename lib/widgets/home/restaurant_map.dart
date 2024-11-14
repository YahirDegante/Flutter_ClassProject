import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RestaurantMap extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  const RestaurantMap({super.key, this.latitude, this.longitude});

  @override
  State<RestaurantMap> createState() => RestaurantMapState();
}

class RestaurantMapState extends State<RestaurantMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition? _initialPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    if (widget.latitude != null && widget.longitude != null) {
      _initialPosition = CameraPosition(
        target: LatLng(widget.latitude!, widget.longitude!),
        zoom: 14.4746,
      );
      _markers.add(Marker(
        markerId: const MarkerId("providedLocation"),
        position: LatLng(widget.latitude!, widget.longitude!),
        infoWindow: const InfoWindow(title: 'Ubicación proporcionada'),
      ));
    } else {
      _determinePosition().then((position) {
      setState(() {
        _initialPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.4746,
        );
        _markers.add(Marker(
            markerId: const MarkerId("currentLocation"),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'mi localizacion')));
      });
    });
    }
  }

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _initialPosition != null
          ? GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _initialPosition!,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
            )
          : const Center(
              child:
                  CircularProgressIndicator()), // Cargando hasta que se defina la posición
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
