import 'package:flutter/material.dart';
import 'package:viveri/events/evento_unico/notifications.dart';
import 'login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'splash_screen.dart';
import 'onboarding_screen.dart';
import 'welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 1) Delegates para tradução de Material, Widgets e Cupertino
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // 2) Definição dos idiomas que o app vai suportar
      supportedLocales: [
        const Locale('pt', 'BR'),
        // você pode adicionar outros, ex: const Locale('en', 'US')
      ],

      debugShowCheckedModeBanner: false,
      title: 'Viveri',
      home: Notifications()// Substitua po9r WelcomeScreen() ou OnboardingScreen() conforme necessário
      ///SplashScreen(),
    );
  }
}
