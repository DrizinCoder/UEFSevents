import 'package:viveri/events/data/model/event_model.dart';
import 'package:viveri/faq/faq_tela.dart';
import 'package:viveri/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viveri/events/pages/home/stores/event_store.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/repositories/event_repositories.dart';
import 'package:viveri/home_page.dart';
import 'package:viveri/events/data/repositories/space_repositories.dart';
import 'package:viveri/events/data/model/space_model.dart';

import '../data/model/image_model.dart';
import '../data/repositories/image_repositories.dart';
//import 'package:viveri/events/evento_unico/evento_deletado.dart';

class EventoUnico extends StatefulWidget {
  final String url;
  final String accessToken;
  final Map<String, dynamic> userData;
  final EventModel event;
  const EventoUnico({super.key, required this.accessToken, required this.userData, required this.event, required this.url});


  @override
  State<EventoUnico> createState() => _EventoUnico();
}


class _EventoUnico extends State<EventoUnico> {

  final EventStore store = EventStore(
      repository: EventRepository(
        client: HttpClient(),
      )
  );

  final ImageRepository imageRepository = ImageRepository(client: HttpClient());
  bool _isFavorito = false;
  SpaceModel? _currentSpace;

  @override
  void initState() {
    super.initState();
    store.getEvents(1);
    if (store.events.isNotEmpty) {
      final evento = store.events.first;
      _loadSpace(widget.event.space);
    }
  }

  @override

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool _isFavorito = false;


    return Scaffold(
      backgroundColor: Color.fromRGBO(212, 224, 212, 1),
      body: ValueListenableBuilder(
          valueListenable: store.state,
          builder: (context, events, _) {
            if (store.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (store.erro.value != null && store.erro.value!.isNotEmpty) {
              return Center(child: Text('Erro: ${store.erro.value}'));
            }

            if (events.isEmpty) {
              return const Center(child: Text('Nenhum evento encontrado.'));
            }

            final evento = events.first;




            return SingleChildScrollView(
              child: Stack(
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

                    child: Tooltip(
                      message: 'Voltar',
                      child:
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => HomePage()),
                          );
                          //Navigator.of(context).pop(); // ou outra lógica de voltar
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 10,
                    child: Tooltip(
                      message: 'Compartilhar',
                      child:
                      IconButton(
                        icon: Icon(Icons.share, color: Color(0xFFF4B134), size: 30),
                        onPressed: () {
                          // lógica de compartilhar
                        },
                      ),
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
                                  child: Image.network(
                                    '${widget.url}',
                                    height: 200,
                                    width: 200,
                                  ),
                                ),

                                Column(
                                  children: [
                                    Text(
                                      '${widget.event.title}',
                                      style: GoogleFonts.roboto(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    _buildInfoRow(Icons.location_on, _currentSpace?.name ?? 'Carregando...'),
                                    SizedBox(height: 40),
                                    _buildInfoRow(Icons.calendar_today, widget.event.start_date.toString().substring(0, 10)),
                                    SizedBox(width: 20),
                                    _buildInfoRow(Icons.access_time,  widget.event.start_time),

                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 20),

                            // Tipo de evento
                            _buildInfoSection(
                              'Tipo do Evento:',
                              widget.event.category,
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
                                    widget.event.description,
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20),

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
                                onPressed: () {
                                  final EventRepository repo = EventRepository(client: HttpClient());
                                  repo.registerUserToEvent(
                                    accessToken: widget.accessToken,
                                    userId: widget.userData['id'],
                                    eventId: widget.event.id,
                                  );

                                },
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
//-------------------------------BOTÕES DE REDIRECIONAMENTO-------------------------------

                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Tooltip(
                                    message: 'FAQ',
                                    child: ElevatedButton(
                                      onPressed: ()
                                      {
                                        //Navigator.pushReplacement
                                        // (
                                        //   context,
                                        //   MaterialPageRoute(builder: (_) => FaqTela(currentUser: currentUser.toString(), isDono: isDono)),
                                        // );

                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromRGBO(152, 175, 162, 1),
                                        padding: EdgeInsets.all(10),
                                        shape: CircleBorder(), // botão circular
                                      ),
                                      child: Icon(
                                        Icons.question_answer,
                                        color: Color(0xFF586C61),
                                        size: 24,
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 15),

                                  Tooltip(
                                    message: 'Algo errado?',
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   MaterialPageRoute(builder: (_) => FaqTela(currentUser: currentUser.toString(), isDono: isDono)),
                                        // );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromRGBO(152, 175, 162, 1),
                                        padding: EdgeInsets.all(10),
                                        shape: CircleBorder(),
                                      ),
                                      child: Icon(
                                        Icons.warning_amber,
                                        color: Colors.amber[300],
                                        size: 24,
                                      ),
                                    ),
                                  ),

                                ],

                              ),
                            ),
//-------------------------------BOTOES DE REDIRECIONAMENTO--------------------------------------------
                            SizedBox(height: 20),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
      ),
    );
  }


//WIDGETS
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


//METODOS
  Future<void> _loadSpace(int spaceId) async {
    final spaceRepo = SpaceRepository(client: HttpClient());
    try {
      final space = await spaceRepo.getSpaceById(spaceId);
      setState(() {
        _currentSpace = space;
      });
    } catch (e) {
      print('Erro ao carregar espaço: $e');
    }
  }


}