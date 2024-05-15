import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/connectivity/wrapper/connectivity_wrapper.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectivityWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Offline'),
        ),
        body: Center(
          child: Text(
            'You are offline!',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
