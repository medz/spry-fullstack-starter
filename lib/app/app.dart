import 'package:flutter/material.dart';
import 'package:unrouter/flutter.dart';

import 'router.dart';

class StarterApp extends StatelessWidget {
  const StarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Spry Starter',
      debugShowCheckedModeBanner: false,
      theme: .new(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: Colors.teal),
      ),
      routerConfig: createRouterConfig(router),
    );
  }
}
