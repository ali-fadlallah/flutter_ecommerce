import 'package:location/location.dart';

class LocationManager {
  Location location = Location();

  bool _serviceEnabled = false;
  bool _isLocationEnabled = false;
  bool _isPermissionGranted = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  Future<bool> isLocationPermissionGranted() async {
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    return _permissionGranted == PermissionStatus.granted;
  }

  Future<bool> isLocationServiceEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    return _serviceEnabled;
  }

  Future<bool> canGetLocation() async {
    _isLocationEnabled = await isLocationServiceEnabled();
    _isPermissionGranted = await isLocationPermissionGranted();
    return _isLocationEnabled && _isPermissionGranted;
  }

  Future<LocationData> getDeviceLocation() async {
    return await location.getLocation();
  }

  Stream<LocationData> trackUserLocation() {
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 5000,
      distanceFilter: 50,
    );
    return location.onLocationChanged;
  }
}
