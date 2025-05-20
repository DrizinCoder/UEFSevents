// Importações necessárias para o Flutter
import 'package:flutter/material.dart';
import 'dart:async';
import 'onboarding_screen.dart';

// Widget principal da tela de splash
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// Estado da tela de splash
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Configura um timer de 2 segundos antes de navegar para a próxima tela
    Timer(Duration(seconds: 2), () {
      // Navega para a tela de onboarding, substituindo a tela atual
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          // Define a tela de destino
          pageBuilder: (context, animation, secondaryAnimation) => OnboardingScreen(),
          // Configura a animação de transição
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          // Define a duração da transição em 700 milissegundos
          transitionDuration: Duration(milliseconds: 700),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Define a cor de fundo como um verde claro
      backgroundColor: Color(0xFFD3E0D1),
      body: Center(
        child: Column(
          // Centraliza os elementos verticalmente
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exibe o logo da aplicação
            Image.asset('assets/logo.png', width: 180),
            // Adiciona um espaçamento vertical de 24 pixels
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
} 