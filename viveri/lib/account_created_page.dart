import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class AccountCreatedPage extends StatelessWidget {
  final String accessToken;
  final String refreshToken;

  const AccountCreatedPage({
    Key? key,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            Text(
              'Conta Criada com Sucesso!',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            
            // Opcional: Exibir parte dos tokens para debug
            // (Remova em produção)
            Text('Access Token: ${accessToken.substring(0, 20)}...'),
            const SizedBox(height: 10),
            Text('Refresh Token: ${refreshToken.substring(0, 20)}...'),
            
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F4F2F),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text(
                'Fazer Login',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}