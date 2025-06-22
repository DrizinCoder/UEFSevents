import 'package:flutter/material.dart';
import 'package:viveri/preferences_page.dart';
import 'package:viveri/about_account_cpf_page.dart';
import 'package:viveri/custom_back_button.dart';

// Página de perfil do usuário
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3E0D1), // Cor de fundo da tela
      body: Column(
        children: [
          // Área fixa no topo com o botão de voltar
          Container(
            height: MediaQuery.of(context).padding.top + 60, // Altura da safe area + espaço para o botão
            child: Stack(
              children: [
                // Botão de voltar posicionado sobre tudo
                Positioned(
                  left: 16,
                  top: MediaQuery.of(context).padding.top + 8,
                  child: CustomBackButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          // Conteúdo rolável
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                children: [
                  // Avatar do usuário
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person, size: 50, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 10),
                  // Nome do usuário e localização
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Português - BR 😎',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Estatísticas do usuário
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn('8', 'Avaliados'),
                      _buildStatColumn('20', 'Favoritados'),
                      _buildStatColumn('12', 'Participado'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Lista de opções
                  _buildProfileOption(context, 'Sobre a conta', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutAccountCpfPage()));
                  }),
                  _buildProfileOption(context, 'Preferências', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PreferencesPage()));
                  }),
                  _buildProfileOption(context, 'Eventos', () {}),
                  _buildProfileOption(context, 'Sobre o Viveri', () {}),
                  _buildProfileOption(context, 'Obter Ajuda', () {}),
                  _buildProfileOption(context, 'Convidar amigos', () {}),
                  _buildProfileOption(context, 'Sair', () {}),
                  const SizedBox(height: 40),
                  // Rodapé com informações de versão
                  const Text(
                    '© 2025 EXA622 Comp.',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const Text(
                    'Version 1.0',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para construir uma coluna de estatística
  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xFF284017).withOpacity(0.12), // rgba(40, 64, 23, 0.12)
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // Widget para construir uma opção do perfil
  Widget _buildProfileOption(BuildContext context, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
            ],
          ),
        ),
      ),
    );
  }
} 