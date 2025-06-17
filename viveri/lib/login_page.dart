import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_password_page.dart';
import 'sign_up_page.dart';
import 'welcome_page.dart';

void showInvalidDataDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Color(0xDDE8F1E8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        'Dados invalidos',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red[900],
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Dados incorretos, favor\ntentar novamente',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red[900]),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2F4F2F),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(
            'Tentar novamente',
            style: TextStyle(
              color: Color(0xFFFFD700), // amarelo ouro
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key}); // Chave adicionada para evitar warnings

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

            // Email
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email:',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: darkGreen,
                ),
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: emailController,
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

            // Esqueci minha senha
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

            // Botão de Login
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String email = emailController.text.trim();
                  String senha = passwordController.text.trim();

                  if (email.isEmpty || senha.isEmpty || !email.contains('@')) {
                    showInvalidDataDialog(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => WelcomeBackPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
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

            // Linha com "ou"
            Row(
              children: [
                const Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text("ou"),
                ),
                const Expanded(child: Divider(thickness: 1)),
              ],
            ),

            const SizedBox(height: 16),

            // Botões sociais
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset('assets/gmail.png', height: 40),
                  onPressed: () {},
                ),
                const SizedBox(width: 24),
                IconButton(
                  icon: Image.asset('assets/instagram.png', height: 40),
                  onPressed: () {},
                ),
              ],
            ),

            const Spacer(),

            // Criar conta
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignupPage()),
                );
              },
              child: Text(
                'Criar conta',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

