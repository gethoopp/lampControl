
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityCHeck {
  void checkConnect() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      Get.toNamed('/HomePage');
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      SnackBar(content: Container());
    } else {}
  }

 /* void changeConnection() {
    StreamSubscription<List<ConnectivityResult>> connectivityChange =
        Connectivity()
            .onConnectivityChanged
            .listen((List<ConnectivityResult> result) {
      switch (result) {
        case result:
          break;
        default:
      }
    });

    connectivityChange.cancel();
  }*/
}
