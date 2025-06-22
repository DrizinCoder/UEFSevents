import 'package:flutter/material.dart';
import 'package:viveri/about_account_cnpj_page.dart';
import 'package:viveri/change_password_page.dart';
import 'package:viveri/custom_back_button.dart';

// Página "Sobre a conta" para CPF
class AboutAccountCpfPage extends StatelessWidget {
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
                  // Seção do tipo de documento
                  const Text('Tipo de documento:', style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text('CPF:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text('***.***.***-**'), // CPF ofuscado
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AboutAccountCnpjPage()));
                    },
                    child: const Text('Alterar para CNPJ?', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  const Divider(),
                  // Informações do usuário
                  _buildInfoRow('Nome:', 'John Doe'),
                  _buildInfoRow('Nome Social:', 'John Doe'),
                  _buildInfoRow('Data de Nascimento:', 'xx/xx/xx'),
                  _buildInfoRow('Telefone de Contato:', '(xx) xxxx-xxxx'),
                  _buildInfoRow('Email:', 'john.doe@example.com'),
                  const Divider(),
                  // Opção para alterar senha
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));
                    },
                    child: const Text('Alterar senha', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  // Opção para desativar conta
                  TextButton(
                    onPressed: () {
                      // Ação para desativar conta
                    },
                    child: const Text('Desativar conta', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  // Opção para excluir conta
                  TextButton(
                    onPressed: () {
                      // Ação para excluir conta
                    },
                    child: const Text('Excluir conta', style: TextStyle(color: Color(0xFF425C44))),
                  ),
                  const SizedBox(height: 50),
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
                child: Text('Sobre a conta', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
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

  // Widget para construir uma linha de informação
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
} 