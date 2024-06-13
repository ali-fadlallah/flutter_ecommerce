import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenState extends Equatable {
  final LatLng initialPosition;
  final LatLng currentPosition;
  final String currentAddress;
  final String currentName;
  final String currentThoroughfare;
  final String currentAdministrativeArea;
  final String currentSubAdministrativeArea;
  final Marker? marker;
  final Uint8List? imageBytes;

  const MapScreenState({
    required this.initialPosition,
    required this.currentPosition,
    required this.currentAddress,
    required this.currentName,
    required this.currentThoroughfare,
    required this.currentAdministrativeArea,
    required this.currentSubAdministrativeArea,
    this.marker,
    this.imageBytes,
  });

  MapScreenState copyWith({
    LatLng? initialPosition,
    LatLng? currentPosition,
    String? currentAddress,
    String? currentName,
    String? currentThoroughfare,
    String? currentAdministrativeArea,
    String? currentSubAdministrativeArea,
    Marker? marker,
    Uint8List? imageBytes,
  }) {
    return MapScreenState(
      initialPosition: initialPosition ?? this.initialPosition,
      currentPosition: currentPosition ?? this.currentPosition,
      currentAddress: currentAddress ?? this.currentAddress,
      currentName: currentName ?? this.currentName,
      currentThoroughfare: currentThoroughfare ?? this.currentThoroughfare,
      currentAdministrativeArea: currentAdministrativeArea ?? this.currentAdministrativeArea,
      currentSubAdministrativeArea: currentSubAdministrativeArea ?? this.currentSubAdministrativeArea,
      marker: marker ?? this.marker,
      imageBytes: imageBytes ?? this.imageBytes,
    );
  }

  @override
  List<Object?> get props => [
        initialPosition,
        currentPosition,
        currentAddress,
        currentName,
        currentThoroughfare,
        currentAdministrativeArea,
        currentSubAdministrativeArea,
        marker,
        imageBytes,
      ];
}
