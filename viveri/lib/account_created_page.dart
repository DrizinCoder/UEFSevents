import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountCreatedPage extends StatelessWidget {
  const AccountCreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xDDE8F1E8); // Cor de fundo
    final darkGreen = const Color(0xFF2F4F2F); // Verde escuro
    final orange = const Color(0xFFFF8C00); // Texto do botão

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/sucess.png',
                  height: 160,
                ),
                const SizedBox(height: 40),
                Text(
                  'Conta criada com sucesso!!!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navegar para a próxima página após alteração de senha
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'Continuar',
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
    );
  }
}
