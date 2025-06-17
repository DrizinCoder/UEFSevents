import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'password_changed_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _showError = false;
  List<String> _passwordErrors = [];

  final Color bgColor = const Color(0xDDE8F1E8);
  final Color darkGreen = const Color(0xFF2F4F2F);
  final Color orange = const Color(0xFFFF8C00);

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

  void _validateAndSubmit() {
    setState(() {
      _passwordErrors = _validatePasswordRules(_newPasswordController.text);
      _showError = _newPasswordController.text != _confirmPasswordController.text;
    });

    if (_passwordErrors.isEmpty && !_showError) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PasswordChangedPage()),
      );
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
                  Image.asset(
                    'assets/logo.png',
                    height: 160,
                  ),
                  const SizedBox(height: 24),

                  // Campo Nova Senha
                  _buildPasswordField("Informe a nova senha:", _newPasswordController, false),

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
                  _buildPasswordField("Confirme a senha:", _confirmPasswordController, _showError),

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

                  const SizedBox(height: 32),

                  // Botão Redefinir
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _validateAndSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
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
            fillColor: Colors.grey[300],
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: showError
                  ? BorderSide(color: Colors.red[900]!)
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: showError
                  ? BorderSide(color: Colors.red[900]!)
                  : BorderSide(color: darkGreen),
            ),
          ),
        ),
      ],
    );
  }
}
