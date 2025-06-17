import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeBackPage extends StatelessWidget {
  const WelcomeBackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xDDE8F1E8); // Cor de fundo
    final darkGreen = const Color(0xFF2F4F2F); // Texto e botão
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
                  'assets/welcome.png',
                  height: 180,
                ),
                const SizedBox(height: 32),
                Text(
                  'Bem-vinda de volta!',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Muito bom ter você de volta! Vamos ver\nqual vai ser seu proximo evento?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navegar para próxima página
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
                        color: orange,
                        fontWeight: FontWeight.bold,
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
