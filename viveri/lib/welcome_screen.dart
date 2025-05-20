import 'package:flutter/material.dart';
import 'login_page.dart';

// Widget da tela de boas-vindas
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Define a cor de fundo como verde claro
      backgroundColor: Color(0xFFD3E0D1),
      body: SafeArea(
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
                        // Navega para a tela de login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
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
    );
  }
} 