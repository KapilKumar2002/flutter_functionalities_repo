// providers/connectivity_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

class ConnectivityProvider with ChangeNotifier {
  bool _isConnected = true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _isMonitoringStarted = false;

  bool get isConnected => _isConnected;

  void startMonitoring(BuildContext context) {
    if (_isMonitoringStarted) return;
    _isMonitoringStarted = true;

    _subscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> resultList) async {
      final hasConnection = await _hasInternetAccess();

      if (hasConnection != _isConnected) {
        _isConnected = hasConnection;
        notifyListeners();

        final currentRoute = ModalRoute.of(context)?.settings.name;

        if (!_isConnected && currentRoute != '/no-connection') {
          debugPrint("🔴 No internet. Navigating to /no-connection");
          Navigator.of(context).pushReplacementNamed('/no-connection');
        } else if (_isConnected && currentRoute == '/no-connection') {
          debugPrint("🟢 Internet restored. Returning to home.");
          Navigator.of(context).pushReplacementNamed('/');
        }
      }
    });

    // Initial check on app startup
    _checkInitialConnectivity(context);
  }

  Future<void> _checkInitialConnectivity(BuildContext context) async {
    final result = await _connectivity.checkConnectivity();
    _isConnected = await _hasInternetAccess();

    notifyListeners();

    final currentRoute = ModalRoute.of(context)?.settings.name;

    if (!_isConnected && currentRoute != '/no-connection') {
      Navigator.of(context).pushReplacementNamed('/no-connection');
    }
  }

  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void disposeStream() {
    _subscription.cancel();
  }
}
