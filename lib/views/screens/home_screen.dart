// views/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/connectivity_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ConnectivityProvider _connectivityProvider;

  @override
  void initState() {
    super.initState();
    _connectivityProvider =
        Provider.of<ConnectivityProvider>(context, listen: false);
    _connectivityProvider.startMonitoring(context);
  }

  @override
  void dispose() {
    _connectivityProvider.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("You are online!")),
    );
  }
}
