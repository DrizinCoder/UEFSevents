import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'verify_code_page.dart';

class ForgotPasswordPage extends StatelessWidget {
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
              // Botão de voltar
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: lightGreen,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 12),

              Text(
                'Você recebera um código de redefinição por email!',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: darkGreen,
                ),
              ),

              SizedBox(height: 32),

              // Botão Enviar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => VerifyCodePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
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
