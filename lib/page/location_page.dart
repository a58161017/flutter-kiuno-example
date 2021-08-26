import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  @override
  LocationState createState() => LocationState();
}

class LocationState extends State<LocationPage> {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> checkEnableAndPermission() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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
    if (mounted) {
      setState(() {
        latitude = _locationData.latitude ?? -1.0;
        longitude = _locationData.longitude ?? -1.0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkEnableAndPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildLocationWidget(),
    );
  }

  Widget _buildLocationWidget() {
    return SafeArea(
      child: Center(
        child: Text('$latitude, $longitude'),
      ),
    );
  }
}
