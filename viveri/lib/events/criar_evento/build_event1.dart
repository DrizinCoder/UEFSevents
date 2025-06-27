import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viveri/login_page.dart';
import 'package:viveri/events/data/repositories/event_repositories.dart';
import 'package:viveri/home_page.dart';


class BuildEvent1 extends StatefulWidget {
  const BuildEvent1({super.key});

  @override
  State<BuildEvent1> createState() => _BuildEvent1();
}

class _BuildEvent1 extends State<BuildEvent1> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0x33284017),

      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [

            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFF586C61),
                shape: BoxShape.rectangle,
              ),
            ),

            Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFDB9E33), size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                  MaterialPageRoute(builder: (_) =>  HomePage());
                },
              ),
            ),

            
          Container(
              width: width,
              height: height,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Criar Evento',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDB9E33),
                    ),
                  ),

                  const SizedBox(height: 60),
                  _buildTextFieldColumn('Nome do Evento',1),
                  const SizedBox(height: 20),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextFieldColumn('Início', 0),
                            const SizedBox(height: 16),
                            Text(
                              'Fim',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),



                      const SizedBox(height: 16),
                      Expanded(child: _buildTextFieldColumn('Data', 2)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTextFieldColumn('Hora', 2)),
                    ],
                  ),

                      const SizedBox(width: 16),
                      Row(children: []),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTextFieldColumn('Tipo de evento', 1)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTextFieldColumn('Frequência', 1)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTextFieldColumn('Faixa Etária', 1)),
                      const SizedBox(width: 16),
                      
                      // Expanded(
                      //   child:Column(
                      //     children: [
                      //           Text(
                      //             textAlign: TextAlign.left,
                      //             "Descrição",
                      //             style: GoogleFonts.roboto(
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.w500,
                      //               color: Colors.black87,
                      //             ),
                      //           ),

                      //           const SizedBox(height: 8),
                                
                      //             TextField(
                      //             decoration: InputDecoration(
                      //               border: OutlineInputBorder(),
                      //               contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      //               filled: true,
                      //               fillColor: const Color.fromRGBO(191,205,189, 0.8), // Light background for better visibility
                      //             ),
                      //           ),
                      
                                
                      //       ],
                      //   )
                      // ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Descrição",
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: TextField(
                              maxLines: 5,  // Aumenta a altura do campo
                              minLines: 5,
                                maxLength: 200,  // Define limite de caracteres
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  filled: true,
                                  fillColor: const Color.fromRGBO(191, 205, 189, 0.8),
                                  counterStyle: TextStyle(  // Estilo para o contador
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                            // Contador de caracteres (aparece automaticamente com maxLength)
                          ],
                        ),
                      ),
                 




                ],
              ),
              
            ),
      
            
          ],
        ),
      ),

      // botao
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const BuildEvent1()), // 
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F4F2F),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              
              child: const Text(
                'Próximo',
                style: TextStyle(fontSize: 18, color: Color(0xFFDB9E33)),
              ),
            ),
          ),
        ),
      ),
      // botao



    );
  }

  Widget _buildTextFieldColumn(String text, int num) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
            Text(
              textAlign: TextAlign.left,
              text,
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),

             const SizedBox(height: 8),
            
            for (int i = 0; i < num; i++)
              TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                filled: true,
                fillColor: const Color.fromRGBO(191,205,189, 0.8), // Light background for better visibility
              ),
            ),
   
             
        ],
        );
  }

}