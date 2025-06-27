import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'verify_code_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  
  // Credenciais de administrador
  final String _adminUsername = 'admin';
  final String _adminPassword = 'suporte123';

  Future<Map<String, dynamic>?> _findUserByEmail() async {
    final email = _emailController.text.trim().toLowerCase();
    if (email.isEmpty) return null;

    try {
      // 1. Obter token de administrador
      final tokenResponse = await http.post(
        Uri.parse('http://localhost:8000/api/token/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': _adminUsername,
          'password': _adminPassword,
        }),
      );

      if (tokenResponse.statusCode != 200) {
        print('Erro ao obter token: ${tokenResponse.statusCode}');
        print('Resposta: ${tokenResponse.body}');
        return null;
      }

      final tokenData = json.decode(tokenResponse.body);
      final accessToken = tokenData['access'];

      // 2. Buscar usuário pelo email
      final usersResponse = await http.get(
        Uri.parse('http://localhost:8000/api/users/'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (usersResponse.statusCode != 200) {
        print('Erro ao buscar usuários: ${usersResponse.statusCode}');
        print('Resposta: ${usersResponse.body}');
        return null;
      }

      final users = json.decode(usersResponse.body);
      
      // Se a resposta for paginada
      final userList = users is List ? users : (users['results'] ?? []);
      
      // 3. Procurar pelo email
      for (var user in userList) {
        final userEmail = user['email']?.toString().trim().toLowerCase();
        if (userEmail == email) {
          return user;
        }
      }
      
      return null;
    } catch (e) {
      print('Exceção: $e');
      return null;
    }
  }

  Future<void> _verifyUser() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Digite um email válido';
      });
      return;
    }

    try {
      final user = await _findUserByEmail();
      
      if (user != null) {
        print('Usuário encontrado: ${user['id']}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VerifyCodePage(userData: user),
          ),
        );
      } else {
        print('Email não encontrado: $email');
        setState(() {
          _isLoading = false;
          _errorMessage = 'Email não encontrado em nosso sistema';
        });
      }
    } catch (e) {
      print('Erro no processo: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erro ao verificar email: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Color(0xDDE8F1E8);
    final darkGreen = Color(0xFF2F4F2F);
    final lightGreen = Color(0xFFC5D3C3);
    final orange = Color(0xFFFF8C00);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              Spacer(),

              Image.asset(
                'assets/logo.png',
                height: 100,
              ),
              SizedBox(height: 12),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email cadastrado:',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: darkGreen,
                  ),
                ),
              ),

              SizedBox(height: 4),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: lightGreen,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  errorText: _errorMessage,
                ),
              ),

              SizedBox(height: 12),

              Text(
                'Você receberá um código de redefinição por email!',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: darkGreen,
                ),
              ),

              SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: orange)
                      : Text(
                          'Enviar',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: orange,
                          ),
                        ),
                ),
              ),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}