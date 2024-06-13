import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../manager/map_cubit.dart';
import '../manager/map_state.dart';
import '../widgets/address_display.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapScreenCubit _mapScreenCubit;

  @override
  void initState() {
    super.initState();
    _mapScreenCubit = MapScreenCubit();
    _mapScreenCubit.getUserLocation(context);
  }

  @override
  void dispose() {
    _mapScreenCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _mapScreenCubit,
      child: BlocBuilder<MapScreenCubit, MapScreenState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.selectDeliveryLocation),
            ),
            body: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.hybrid,
                  compassEnabled: true,
                  initialCameraPosition: CameraPosition(target: state.initialPosition, zoom: 15),
                  onMapCreated: (controller) => _mapScreenCubit.controller = controller,
                  onCameraMove: _mapScreenCubit.onCameraMove,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  onTap: (LatLng position) {
                    _mapScreenCubit.updateCurrentPosition(position);
                  },
                  markers: state.marker != null ? {state.marker!} : {},
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: AddressDisplay(address: state.currentAddress),
                ),
                Positioned(
                  bottom: 90,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _mapScreenCubit.getUserLocation(context);
                      },
                      icon: Icon(
                        Icons.my_location,
                        color: Theme.of(context).colorScheme.primary,
                        size: 30.sp,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () => _mapScreenCubit.confirmAddress(context),
                    child: Text(AppLocalizations.of(context)!.confirmAddress),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
