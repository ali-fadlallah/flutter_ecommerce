import 'dart:async';
import 'dart:typed_data';

import 'package:app_settings/app_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/location/location_manager.dart';
import '../../../../core/utils/custom_dialog/my_custom_dialogs.dart';
import '../screens/address_screen.dart';
import 'map_state.dart';

class MapScreenCubit extends Cubit<MapScreenState> {
  MapScreenCubit()
      : super(const MapScreenState(
          initialPosition: LatLng(30.0444, 31.2357),
          currentPosition: LatLng(30.0444, 31.2357),
          currentAddress: "Cairo Governorate",
          currentName: "Cairo Governorate",
          currentThoroughfare: "Cairo Governorate",
          currentAdministrativeArea: "Cairo Governorate",
          currentSubAdministrativeArea: "Cairo Governorate",
        ));

  final LocationManager locationManager = LocationManager();
  GoogleMapController? controller;
  Timer? _debounce;

  void updateInitialPosition(LatLng position) {
    emit(state.copyWith(
      initialPosition: position,
      currentPosition: position,
    ));
    _updateMarker(position);
    _updateAddress(position);
    _moveCamera(position); // Move the camera to the new initial position
  }

  void _moveCamera(LatLng position) {
    controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: position, zoom: 15)));
  }

  void updateCurrentPosition(LatLng position) {
    emit(state.copyWith(currentPosition: position));
    _updateMarker(position);
    _updateAddress(position);
  }

  void updateCurrentAddress(String address) {
    emit(state.copyWith(currentAddress: address));
  }

  void updateCurrentName(String name) {
    emit(state.copyWith(currentName: name));
  }

  void updateCurrentThoroughfare(String thoroughfare) {
    emit(state.copyWith(currentThoroughfare: thoroughfare));
  }

  void updateCurrentAdministrativeArea(String administrativeArea) {
    emit(state.copyWith(currentAdministrativeArea: administrativeArea));
  }

  void updateCurrentSubAdministrativeArea(String subAdministrativeArea) {
    emit(state.copyWith(currentSubAdministrativeArea: subAdministrativeArea));
  }

  void updateMarker(Marker? marker) {
    emit(state.copyWith(marker: marker));
  }

  void updateImageBytes(Uint8List? imageBytes) {
    emit(state.copyWith(imageBytes: imageBytes));
  }

  Future<void> getUserLocation(BuildContext context) async {
    bool checkLocation = await locationManager.canGetLocation();
    if (!checkLocation) {
      if (context.mounted) {
        MyCustomDialogs.showMessageDialog(
            context: context,
            message: AppLocalizations.of(context)!.permissionsAreNotAllowed,
            positiveTitle: AppLocalizations.of(context)!.goToSettings,
            positiveClick: () {
              Navigator.pop(context);
              Navigator.pop(context);
              AppSettings.openAppSettings(type: AppSettingsType.settings);
            },
            negativeClick: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            negativeTitle: AppLocalizations.of(context)!.back);
      }
    } else {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      updateInitialPosition(LatLng(position.latitude, position.longitude));
    }
  }

  void _updateMarker(LatLng position) {
    updateMarker(Marker(
      markerId: const MarkerId('current_position'),
      position: position,
    ));
  }

  void onCameraMove(CameraPosition position) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      updateCurrentPosition(position.target);
    });
    updateMarker(Marker(
      markerId: const MarkerId('current_position'),
      position: LatLng(position.target.latitude, position.target.longitude),
    ));
  }

  Future<void> _updateAddress(LatLng position) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];

      List<String> addressComponents = [];

      updateCurrentName(place.name ?? '');
      updateCurrentAdministrativeArea(place.administrativeArea ?? '');
      updateCurrentThoroughfare(place.thoroughfare ?? '');
      updateCurrentSubAdministrativeArea(place.subAdministrativeArea ?? '');

      if (state.currentName.isNotEmpty) {
        addressComponents.add(state.currentName);
      }
      if (state.currentAdministrativeArea.isNotEmpty) {
        addressComponents.add(state.currentAdministrativeArea);
      }
      if (state.currentThoroughfare.isNotEmpty) {
        addressComponents.add(state.currentThoroughfare);
      }
      if (state.currentSubAdministrativeArea.isNotEmpty) {
        addressComponents.add(state.currentSubAdministrativeArea);
      }

      updateCurrentAddress(addressComponents.join(',\n'));
    } catch (e) {
      print(e);
    }
  }

  Future<void> confirmAddress(BuildContext context) async {
    Uint8List? imageBytes = await controller?.takeSnapshot();
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressScreen(
            imageBytes: imageBytes,
            position: state.currentPosition,
            addressName: state.currentName,
            addressThoroughfare: state.currentThoroughfare,
            addressAdministrativeArea: state.currentAdministrativeArea,
            addressSubAdministrativeArea: state.currentSubAdministrativeArea,
          ),
        ),
      );
    }
  }
}
