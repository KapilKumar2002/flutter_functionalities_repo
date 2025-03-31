// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_functionalities/providers/connectivity_provider.dart';
import 'package:flutter_functionalities/views/screens/home_screen.dart';
import 'package:flutter_functionalities/views/screens/no_connection_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ConnectivityProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/no-connection': (context) => const NoConnectionScreen(),
          },
        ));
  }
}
