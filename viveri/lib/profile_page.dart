import 'package:flutter/material.dart';
import 'package:viveri/preferences_page.dart';
import 'package:viveri/about_account_cpf_page.dart';
import 'package:viveri/custom_back_button.dart';
import 'package:viveri/about_account_cnpj_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'events/data/repositories/event_repositories.dart';
import 'events/data/model/event_model.dart';
import 'events/data/http/http_client.dart';
import 'events/telas_criar_evento/create_favorite.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String accessToken;

  const ProfilePage({
    Key? key,
    required this.userData,
    required this.accessToken,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int participatedCount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadParticipatedEvents();
  }

  Future<void> _loadParticipatedEvents() async {
    final repo = EventRepository(client: HttpClient());
    int page = 1;
    int count = 0;
    bool limit = false;
    final userId = widget.userData['id'];
    while (!limit) {
      final events = await repo.getEvent(page);
      if (events.isEmpty) break;
      for (final event in events) {
        if (event.participants.contains(userId)) {
          count++;
        }
      }
      if (events.length < 10) limit = true;
      page++;
    }
    setState(() {
      participatedCount = count;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Extrai dados do usuário
    final firstName = widget.userData['first_name'] ?? '';
    final lastName = widget.userData['last_name'] ?? '';
    final username = widget.userData['username'] ?? '';
    final userType = widget.userData['user_type'] ?? '';
    final verified = widget.userData['verified_seal'] ?? false;
    final userId = widget.userData['id']?.toString() ?? '';
    final vat = widget.userData['vat'] ?? '';
    print('DEBUG: vat do usuário = $vat');
    String tipoDoc = 'CPF';
    if (vat is String && vat.replaceAll(RegExp(r'\D'), '').length == 14) {
      tipoDoc = 'CNPJ';
    }

    // Nome completo ou username como fallback
    final displayName = '$firstName $lastName'.trim().isNotEmpty
        ? '$firstName $lastName'
        : username;

    return Scaffold(
      backgroundColor: const Color(0xFFD3E0D1),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                    '$tipoDoc • ID: $userId',
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
                      _buildStatColumn('0', 'Avaliados'),
                      _buildStatColumn('0', 'Favoritados'),
                      _buildStatColumn(participatedCount.toString(), 'Participado'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Lista de opções
                  _buildProfileOption(context, 'Sobre a conta', () {
                    final vat = widget.userData['vat'] ?? '';
                    print('DEBUG: vat do usuário ao clicar = $vat');
                    final isCnpj = vat is String && vat.replaceAll(RegExp(r'\D'), '').length == 14;
                    if (isCnpj) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutAccountCnpjPage(
                            userData: widget.userData,
                            accessToken: widget.accessToken,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutAccountCpfPage(
                            userData: widget.userData,
                            accessToken: widget.accessToken,
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
                  _buildProfileOption(context, 'Eventos', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateFavorite(),
                      ),
                    );
                  }),
                  _buildProfileOption(context, 'Sobre o Viveri', () {}),
                  _buildProfileOption(context, 'Obter Ajuda', () {}),
                  _buildProfileOption(context, 'Convidar amigos', () {}),
                  _buildProfileOption(context, 'Sair', () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('access_token');
                    await prefs.remove('refresh_token');
                    await prefs.remove('user_data');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                    );
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