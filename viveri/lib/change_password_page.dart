import 'package:flutter/material.dart';
import 'package:viveri/custom_back_button.dart';

// Página para alterar a senha
class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3E0D1), // Cor de fundo da tela
      body: SafeArea(
        child: Stack(
          children: [
            // O conteúdo que rola fica aqui, no fundo do Stack.
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 20.0), // Padding para o conteúdo não ficar atrás do header
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Campo para a senha atual
                  _buildPasswordField('Informe a senha atual:'),
                  const SizedBox(height: 20),
                  // Campo para a nova senha
                  _buildPasswordField('Informe a nova senha:'),
                  const SizedBox(height: 20),
                  // Campo para confirmar a nova senha
                  _buildPasswordField('Confirme a senha:'),
                  const SizedBox(height: 40),
                  // Botão para redefinir a senha
                  SizedBox(
                    width: double.infinity, // Botão ocupa toda a largura
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF425C44), // Cor do botão
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        // Ação para redefinir a senha
                      },
                      child: const Text(
                        'Redefinir',
                        style: TextStyle(fontSize: 18, color: Color(0xFFFFB300)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40), // Espaçamento fixo em vez de Spacer
                  // Rodapé com informações de versão
                  const Center(
                    child: Text(
                      'Version 1.0',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
             // Header fixo que fica sobre o conteúdo
            Container(
              height: 60, // Altura do header
              color: const Color(0xFF425C44),
              child: const Center(
                child: Text('Alterar senha', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            // Botão de voltar posicionado sobre tudo
            Positioned(
              left: 16, // Mais para a esquerda
              top: 8,  // Posição mais alta
              child: CustomBackButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir um campo de senha
  Widget _buildPasswordField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 5),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
} 