import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_page.dart';
import 'forgot_password_page.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/token/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': usernameController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final tokens = json.decode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', tokens['access']);
        await prefs.setString('refresh_token', tokens['refresh']);
        
        // Obter dados do usuário usando o token
        final userResponse = await http.get(
          Uri.parse('http://localhost:8000/api/users/me/'),
          headers: {'Authorization': 'Bearer ${tokens['access']}'},
        );

        if (userResponse.statusCode == 200) {
          final userData = json.decode(userResponse.body);
          await prefs.setString('user_data', json.encode(userData));
          
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => WelcomeBackPage(userData: userData)),
          );
        } else {
          showInvalidDataDialog(context, 'Falha ao obter dados do usuário');
        }
      } else {
        showInvalidDataDialog(context, 'Credenciais inválidas');
      }
    } catch (e) {
      showInvalidDataDialog(context, 'Erro de conexão: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xDDE8F1E8);
    final darkGreen = const Color(0xFF2F4F2F);
    final orange = const Color(0xFFFF8C00);

    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Image.asset(
              'assets/logo.png',
              height: 100,
            ),
            const SizedBox(height: 12),

            // Usuário (username)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Usuário:',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: darkGreen,
                ),
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white60,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Senha
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Senha:',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: darkGreen,
                ),
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white60,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            // Botão de Login
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Color(0xFFFFD700))
                    : Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              
            ),
            const SizedBox(height: 16),
             Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SignupPage()),
                  );
                },
                child: Text(
                  'Não tem uma conta? Crie uma',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
             Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ForgotPasswordPage()),
                  );
                },
                child: Text(
                  'Esqueci minha senha',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showInvalidDataDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: const Color(0xDDE8F1E8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        'Erro de autenticação',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red[900],
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red[900]),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2F4F2F),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(
            'Tentar novamente',
            style: TextStyle(
              color: const Color(0xFFFFD700),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}