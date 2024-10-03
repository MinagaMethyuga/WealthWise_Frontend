import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class NetworkProvider with ChangeNotifier {
  bool _isConnected = true;
  late StreamSubscription<ConnectivityResult> _subscription;

  bool get isConnected => _isConnected;

  NetworkProvider() {
    _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _isConnected = result != ConnectivityResult.none;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
