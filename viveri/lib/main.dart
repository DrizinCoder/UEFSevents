import 'package:flutter/material.dart';
import 'package:viveri/events/evento_unico/notifications.dart';
import 'login_page.dart'; // Certifique-se que o caminho está correto
import 'splash_screen.dart';
import 'onboarding_screen.dart';
import 'welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viveri',
      home: Notifications()// Substitua po9r WelcomeScreen() ou OnboardingScreen() conforme necessário
      ///SplashScreen(),
    );
  }
}
