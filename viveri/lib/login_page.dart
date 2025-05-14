import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_password_page.dart';

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
          color: Colors.brown[900],
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Dados incorretos, favor\ntentar novamente',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.brown[900]),
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
  @override
  Widget build(BuildContext context) {
    final bgColor = Color(0xDDE8F1E8);
    final darkGreen = Color(0xFF2F4F2F);
    final orange = Color(0xFFFF8C00);

    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Image.asset(
              'assets/logo.png',
              height: 100,
            ),
            SizedBox(height: 12),

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
            SizedBox(height: 4),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white60,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),

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
            SizedBox(height: 4),
            TextField(
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
                  showInvalidDataDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen,
                  padding: EdgeInsets.symmetric(vertical: 16),
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

            SizedBox(height: 16),

            // Linha com "ou"
            Row(
              children: [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("ou"),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),

            SizedBox(height: 16),

            // Botões sociais
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset('assets/gmail.png', height: 40),
                  onPressed: () {},
                ),
                SizedBox(width: 24),
                IconButton(
                  icon: Image.asset('assets/instagram.png', height: 40),
                  onPressed: () {},
                ),
              ],
            ),

            Spacer(),

            // Criar conta
            GestureDetector(
              onTap: () {},
              child: Text(
                'create account',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
