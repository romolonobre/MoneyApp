import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    Modular.setInitialRoute("/splashscreen");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MoneyApp',
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffc0038a)),
        scaffoldBackgroundColor: const Color(0xffc0038a),
        primaryColor: const Color(0xffc0038a),
        useMaterial3: true,
      ),
    );
  }
}
