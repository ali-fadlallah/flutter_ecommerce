import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  ConnectivityCubit() : super(ConnectivityStatus.connected);

  static ConnectivityCubit get(context) => BlocProvider.of(context);

  void checkConnectivity() async {
    List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

    _updateConnectivityStatus(connectivityResult);
  }

  void _updateConnectivityStatus(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(ConnectivityStatus.disconnected);
    } else {
      emit(ConnectivityStatus.connected);
    }
  }

  late StreamSubscription<List<ConnectivityResult>?> _subscription;

  void trackConnectivityChange() {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      _updateConnectivityStatus(result);
    });
  }

  void dispose() {
    _subscription.cancel();
  }
}
