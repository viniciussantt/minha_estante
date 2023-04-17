import 'package:flutter/material.dart';
import 'package:minha_estante/features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashPage()
    );
  }
}
