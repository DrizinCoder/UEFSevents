import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class WelcomeBackPage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const WelcomeBackPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, ${userData['username']}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('access_token');
              await prefs.remove('refresh_token');
              await prefs.remove('user_data');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tipo de usuário: ${userData['user_type']}'),
            Text('Selo verificado: ${userData['verified_seal'] ? 'Sim' : 'Não'}'),
          ],
        ),
      ),
    );
  }
}
