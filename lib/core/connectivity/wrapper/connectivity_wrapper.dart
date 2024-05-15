import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/connectivity/test/connectivity_cubit.dart';
import 'package:flutter_ecommerce_app/core/utils/snackbar_global/SnackbarGlobal.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  ConnectivityWrapper({required this.child});

  @override
  _ConnectivityWrapperState createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late ConnectivityStatus _previousStatus;

  @override
  void initState() {
    super.initState();
    _previousStatus = ConnectivityCubit.get(context).state;
  }

  @override
  void dispose() {
    super.dispose();
    ConnectivityCubit.get(context).dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityStatus>(
      listener: (context, state) {
        if (_previousStatus == ConnectivityStatus.disconnected && state == ConnectivityStatus.connected) {
          SnackBarGlobal.showGreen(StringsManager.youAreOnline);
        }
        if (_previousStatus == ConnectivityStatus.connected && state == ConnectivityStatus.disconnected) {
          SnackBarGlobal.showRed(StringsManager.youAreOffline);
        }
        _previousStatus = state;
      },
      child: widget.child,
    );
  }
}
