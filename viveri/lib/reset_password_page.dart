import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'password_changed_page.dart';
import 'login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  final int userId;

  const ResetPasswordPage({super.key, required this.userId});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _showError = false;
  bool _isLoading = false;
  String? _apiError;
  List<String> _passwordErrors = [];

  // Credenciais de administrador
  final String _adminUsername = 'admin';
  final String _adminPassword = 'suporte123';

  final Color bgColor = const Color(0xDDE8F1E8);
  final Color darkGreen = const Color(0xFF2F4F2F);
  final Color orange = const Color(0xFFFF8C00);
  final Color lightGreen = const Color(0xFFC5D3C3);

  List<String> _validatePasswordRules(String password) {
    List<String> errors = [];

    if (password.length < 9) {
      errors.add("Mais de 8 caracteres");
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add("Conter letras maiúsculas");
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add("Conter letras minúsculas");
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      errors.add("Incluir pelo menos um número");
    }
    if (!RegExp(r'[!@#\$&*~%^(),.?":{}|<>]').hasMatch(password)) {
      errors.add("Incluir pelo menos um caractere especial");
    }

    return errors;
  }

  Future<void> _updatePassword() async {
    setState(() {
      _isLoading = true;
      _apiError = null;
      _passwordErrors = _validatePasswordRules(_newPasswordController.text);
      _showError = _newPasswordController.text != _confirmPasswordController.text;
    });

    // Validação local
    if (_passwordErrors.isNotEmpty || _showError) {
      setState(() => _isLoading = false);
      return;
    }

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
        setState(() {
          _apiError = 'Erro de autenticação do sistema. Tente novamente.';
        });
        return;
      }

      final tokenData = json.decode(tokenResponse.body);
      final accessToken = tokenData['access'];

      // 2. Atualizar a senha do usuário - CORREÇÃO: Enviar apenas o campo 'password'
      final response = await http.patch(
        Uri.parse('http://localhost:8000/api/users/${widget.userId}/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'password': _newPasswordController.text, // Apenas o campo necessário
        }),
      );

      print('Senha: ${_newPasswordController.text}');
      print('Resposta da API: ${response.body}');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PasswordChangedPage()),
        );
      } else {
        // Tenta extrair a mensagem de erro
        String errorMsg = 'Erro ao atualizar senha';
        try {
          final errorData = json.decode(response.body);
          print("Erro da API: $errorData");
          
          // Verifica diferentes formatos de erro
          if (errorData.containsKey('detail')) {
            errorMsg = errorData['detail'];
          } else if (errorData.containsKey('password')) {
            errorMsg = errorData['password'].join(', ');
          } else if (errorData.containsKey('non_field_errors')) {
            errorMsg = errorData['non_field_errors'].join(', ');
          } else if (errorData is Map && errorData.isNotEmpty) {
            // Pega o primeiro erro encontrado
            errorMsg = errorData.values.first.join(', ');
          }
        } catch (e) {
          print('Erro ao decodificar resposta: $e');
        }
        setState(() {
          _apiError = errorMsg;
        });
      }
    } catch (e) {
      setState(() {
        _apiError = 'Erro de conexão: ${e.toString()}';
      });
      print("Exceção completa: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Botão de voltar
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  
                  Image.asset(
                    'assets/logo.png',
                    height: 120,
                  ),
                  const SizedBox(height: 24),
                  
                  Text(
                    'Redefinir Senha',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Campo Nova Senha
                  _buildPasswordField("Nova senha:", _newPasswordController, false),

                  // Erros de critérios de senha
                  if (_passwordErrors.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "A senha deve conter:",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.red[900],
                            ),
                          ),
                          const SizedBox(height: 4),
                          ..._passwordErrors.map((e) => Row(
                                children: [
                                  Icon(Icons.circle, color: Colors.red[900], size: 6),
                                  const SizedBox(width: 6),
                                  Text(
                                    e,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.red[900],
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Campo Confirmar Senha
                  _buildPasswordField("Confirmar nova senha:", _confirmPasswordController, _showError),

                  // Erro de confirmação de senha
                  if (_showError)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'As senhas não coincidem!',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.red[900],
                        ),
                      ),
                    ),
                  
                  // Erro da API
                  if (_apiError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _apiError!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.red[900],
                        ),
                      ),
                    ),

                  const SizedBox(height: 32),

                  // Botão Redefinir
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _updatePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: orange)
                          : Text(
                              'Redefinir',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: orange,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool showError) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: lightGreen,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: showError
                  ? const BorderSide(color: Colors.red)
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: showError
                  ? const BorderSide(color: Colors.red)
                  : BorderSide(color: darkGreen),
            ),
          ),
        ),
      ],
    );
  }
}