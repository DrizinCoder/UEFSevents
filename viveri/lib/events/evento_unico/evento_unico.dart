import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventoUnico extends StatefulWidget {
  const EventoUnico({super.key});
  

  @override
  State<EventoUnico> createState() => _EventoUnico();
}


class _EventoUnico extends State<EventoUnico> {
  @override

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool _isFavorito = false;


    return Scaffold(
      backgroundColor: Color(0x33284017),
      body: SingleChildScrollView(
      

      child:

       Stack(
       alignment: Alignment.topCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,  // Ocupa toda a largura da tela
              height: 200, // Altura proporcional
              decoration: const BoxDecoration(
              color:  Color(0xFF586C61), // Cor da bola
              shape: BoxShape.rectangle,
              
          ),
          ),

        Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
                onPressed: () {
                  Navigator.of(context).pop(); // ou outra lógica de voltar
                },
              ),
            ),
            Positioned(
              top: 30,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.share, color: Color(0xFFF4B134), size: 30),
                onPressed: () {
                  // lógica de compartilhar
                },
              ),
            ),
            
            Positioned(
            top: 130,
            right: 20,
            child: IconButton(
              icon: Icon(
                _isFavorito ? Icons.favorite : Icons.favorite_border,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  _isFavorito = !_isFavorito;
                });
              },
            ),
          ),
            
          
         Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),

              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(height: 70),
            Row(
              children: [
                SizedBox(height: 60),
                Align(
                  // alignment: Alignment. centerLeft  ,
                  child: Image.asset(
                    'assets/quadrado.png',
                    height: 200,
                    width: 200,
                  ),
                ),

                 Column(
                   children: [
                     Text(
                        'Evento',
                        style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                       SizedBox(height: 20),
                       _buildInfoRow(Icons.location_on, 'Rua dos Bobos, Nº 0'),
                      SizedBox(height: 40),
                      _buildInfoRow(Icons.calendar_today, 'Sábado, 24 de Julho'),
                      SizedBox(width: 20),
                      _buildInfoRow(Icons.access_time, '21:00 - 23:00'),
                          
                   ],
                 ),

              ],
            ),     

                  SizedBox(height: 20),


                  // Endereço, Data e hora
                  

                  SizedBox(height: 20),

                  // Tipo de evento
                  _buildInfoSection(
                    'Tipo do Evento:',
                    'Presencial',
                    Icons.event_available,
                  ),

                  SizedBox(height: 20),

                  // Descrição
                  
                   
                
                  _buildSectionTitle('Descrição:'),

                  Row(
                    children: [
                      Container(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.eighteen_up_rating, color: Color(0xFF586C61), size: 30),
                          ),
                      
                      Expanded(
                        child: 
                          Text(
                            'Evento de exemplo com música ao vivo e área de alimentação. Proibida a entrada de menores de 18 anos.',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        
                      ),

                    ],
                  ),

                  SizedBox(height: 20),

                  // Descrição
                  _buildSectionTitle('Para mais informações'),
                  //LINK
                  SizedBox(height: 30),
                  Column(
                    children: [

                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.location_on, color: Color.fromRGBO(88, 108, 97, 1), size: 30),
                          ),
                           _buildSectionTitle('Onde vai rolar?'),
                        ],
                      ),

                       Stack(
                         children: [
                           Container(
                            width: 500,
                            height: 150,
                            padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(152, 175, 162, 1),// Primeiro círculo (mais ao fundo)
                                  shape: BoxShape.rectangle,
                                ),
                            ),
                         ],
                       ),

                    ],
                  ),
                 
                  
                   // LINK MAPS

                  SizedBox(height: 30),

                  //if(usuario não cadastrado){}
                 SizedBox(
                    width: 130, // Largura calculada para 3 círculos de 50px com sobreposição de 20px: (50-20)*2 + 50
                    height: 50, // Altura de um círculo
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[600], // Primeiro círculo (mais ao fundo)
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        Positioned(
                          left: 30, // Deslocamento para sobrepor (50 de largura - 20 de sobreposição)
                          top: 0,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[500], // Segundo círculo
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        
                        Positioned(
                          left: 60, // Deslocamento para sobrepor (30 anterior + (50 de largura - 20 de sobreposição))
                          top: 0,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white70, // Terceiro círculo (mais à frente)
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        Positioned(
                          left: 120, // Deslocamento para centralizar o ícone
                          top: 0,
                          child: Text(
                            '+',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Positioned(
                          left: 120, // Deslocamento para centralizar o ícone
                          top: 10,
                          child: Text(
                            '+',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  //if(usuario não cadastrado){}
                  
                  SizedBox(height: 20),
                  
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Center(
                          child: 
                            Text('Organizador:',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          
                        ),
                    
                        SizedBox(height: 10), 
                        
                        Center(
                          child:
                            Icon(Icons.emoji_emotions_rounded,color: Color(0xFFF4B134), size: 200),
                          
                        ),
                        
                        SizedBox(height: 10), 

                        // Nome do organizador
        
                            Center(
                              child: 
                                Text('Nome',
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                            
                            ),
                        ]
                      ),
                  
                  //if(usuario não cadastrado){}
                  SizedBox(height: 20),
                  // Botão de ação
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF586C61),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: Text(
                        'Inscrever-se',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                //if(usuario não cadastrado){}

                  SizedBox(height: 20),

                 Center(
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Icon(Icons.question_answer, color:  Color(0xFF586C61), size: 30), // Verde mais claro
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(152, 175, 162, 1), 
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                        child: Text(
                          'FAQ',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black, // Mantendo a cor do texto preta para contraste
                          ),
                        ),
                      ),

                      SizedBox(width: 15), // Aumentar o espaçamento entre os botões

                      Icon(Icons.warning_amber, color: Colors.amber[300], size: 30), // Amarelo/âmbar mais claro
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(152, 175, 162, 1), // Mesma cor do botão "Inscrever-se"
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                        child: Text(
                          'Algo errado?',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black, // Mantendo a cor do texto preta para contraste
                          ),
                        ),
                      ),
                    ],
                                   ),
                 ),

                  SizedBox(height: 20),

                ],
              ),
            ),
          ],
        ),
        ],
      ),
    ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(String title, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 24, color: Color(0xFF586C61)),
            SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 34, top: 5),
          child: Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
