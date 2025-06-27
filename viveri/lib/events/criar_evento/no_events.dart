
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viveri/login_page.dart';
import 'package:viveri/events/criar_evento/build_event1.dart';


class NoEvents extends StatelessWidget {


  const NoEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x33284017),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cancel, size: 100, color:Color.fromARGB(255, 155, 13, 13) ),
            const SizedBox(height: 20),
            Text(
              'Nenhum Evento\nCriado!',
              style: GoogleFonts.poppins(
                fontSize: 24,
                
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0), // Adiciona um preenchimento ao redor do botão
        child: SafeArea( // Garante que o botão não seja obscurecido por elementos da interface do sistema (como a barra de navegação do iOS)
          child: SizedBox(
            width: double.infinity, // Faz o botão ocupar toda a largura disponível
            height: 50, // Define uma altura fixa para o botão
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const BuildEvent1()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F4F2F),
                padding: const EdgeInsets.symmetric(vertical: 16), // Mantém o preenchimento vertical para o texto
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Adiciona um leve arredondamento nas bordas
                ),
              ),
              child: const Text(
                'Criar Evento',
                style: TextStyle(fontSize: 18, color:  Color(0xFFDB9E33),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

