import 'package:flutter/material.dart';
import 'login_page.dart';
import 'onboarding_screen.dart';

// Widget da tela de boas-vindas
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Define a cor de fundo como verde claro
      backgroundColor: Color(0xFFD3E0D1),
      body: SafeArea(
        child: GestureDetector(
          // Detecta o gesto de deslizar da direita para a esquerda
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) { // Deslizar da esquerda para a direita
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => OnboardingScreen(initialPage: 1), // Última página do onboarding
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = Offset(-1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 400),
                ),
              );
            }
          },
          child: Center(
            child: Padding(
              // Adiciona padding horizontal de 24 pixels
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                // Centraliza os elementos verticalmente
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Exibe o logo da aplicação
                  Image.asset('assets/logo.png', width: 120),
                  SizedBox(height: 24),
                  SizedBox(height: 32),
                  // Título de boas-vindas
                  Text(
                    'Olá, Bem-vindo!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Mensagem de instrução
                  Text(
                    'Para começar, você deve criar uma conta!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 24),
                  // Seção de login para usuários existentes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Já tem conta? '),
                      // Botão de login com efeito de cursor ao passar o mouse
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                var begin = Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.easeInOut;
                                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 400),
                            ),
                          );
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            'Faça login!',
                            style: TextStyle(
                              color: Color(0xFF425C44),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  // Botão principal para criar conta
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // Define a cor de fundo do botão como verde escuro
                      backgroundColor: Color(0xFF425C44),
                      // Define o tamanho mínimo do botão
                      minimumSize: Size(double.infinity, 48),
                    ),
                    onPressed: () {
                      // Navegar para tela de cadastro se necessário
                    },
                    child: Text(
                      'Criar uma conta',
                      // Define o estilo do texto do botão
                      style: TextStyle(fontSize: 18, color: Color(0xFFFAA215)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 