import 'package:flutter/material.dart';
import 'package:viveri/preferences_page.dart';
import 'package:viveri/about_account_cpf_page.dart';
import 'package:viveri/custom_back_button.dart';
import 'package:viveri/about_account_cnpj_page.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;
  final String accessToken;

  const ProfilePage({
    Key? key,
    required this.userData,
    required this.accessToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extrai dados do usuário
    final firstName = userData['first_name'] ?? '';
    final lastName = userData['last_name'] ?? '';
    final username = userData['username'] ?? '';
    final userType = userData['user_type'] ?? '';
    final verified = userData['verified_seal'] ?? false;
    final userId = userData['id']?.toString() ?? '';

    // Nome completo ou username como fallback
    final displayName = '$firstName $lastName'.trim().isNotEmpty
        ? '$firstName $lastName'
        : username;

    return Scaffold(
      backgroundColor: const Color(0xFFD3E0D1),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top + 60,
            child: Stack(
              children: [
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
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    child: Stack(
                      children: [
                        Icon(Icons.person, size: 50, color: Colors.grey.shade700),
                        if (verified)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.verified,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${userType == 'fugleman' ? 'CNPJ' : 'CPF'} • ID: $userId',
                    style: const TextStyle(
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
                    if (userType == 'fugleman') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutAccountCnpjPage(
                            userData: userData,
                            accessToken: accessToken,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutAccountCpfPage(
                            userData: userData,
                            accessToken: accessToken,
                          ),
                        ),
                      );
                    }
                  }),
                  _buildProfileOption(context, 'Preferências', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreferencesPage(),
                      ),
                    );
                  }),
                  _buildProfileOption(context, 'Eventos', () {}),
                  _buildProfileOption(context, 'Sobre o Viveri', () {}),
                  _buildProfileOption(context, 'Obter Ajuda', () {}),
                  _buildProfileOption(context, 'Convidar amigos', () {}),
                  _buildProfileOption(context, 'Sair', () {
                    // Implementar lógica de logout
                  }),
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

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption(BuildContext context, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}