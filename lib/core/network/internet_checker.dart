import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckInternetConnection {
  static List<ConnectivityResult> connectionStatus = [ConnectivityResult.none];

  static Future<bool> checkConnectivity() async {
    connectionStatus = await Connectivity().checkConnectivity();
    if (!connectionStatus.contains(ConnectivityResult.none)) {
      return true;
    }
    return false;
  }

  static Future<bool> check() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      return true;
    }
    return false;
  }
}
