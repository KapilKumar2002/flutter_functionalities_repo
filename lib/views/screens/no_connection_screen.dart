// views/screens/no_connection_screen.dart
import 'package:flutter/material.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: const Center(
        child: Text(
          'No Internet Connection',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
