// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:viveri/events/pages/home/stores/event_store.dart';
// import 'package:viveri/events/data/http/http_client.dart';
// import 'package:viveri/events/data/repositories/event_repositories.dart';
// import 'package:viveri/home_page.dart';
// import 'package:viveri/events/data/repositories/space_repositories.dart';
// import 'package:viveri/events/data/model/space_model.dart';


// class EventoUnico extends StatefulWidget {
//   const EventoUnico({super.key});

//   @override
//   State<EventoUnico> createState() => _EventoUnicoState();
// }

// class _EventoUnicoState extends State<EventoUnico> {
//   final EventStore store = EventStore(
//     repository: EventRepository(
//       client: HttpClient(),
//     ),
//   );

//   bool _isFavorito = false;
//   SpaceModel? _currentSpace;

//   @override
//   void initState() {
//     super.initState();
//     store.getEvents(Page);
//     if (store.events.isNotEmpty) {
//         final evento = store.events.first; 
//         _loadSpace(evento.space); 
//       }
//   }



// Future<void> _loadSpace(String spaceId) async {
//     final spaceRepo = SpaceRepository(client: HttpClient());
//     try {
//       final space = await spaceRepo.getSpaceById(int.parse(spaceId));
//       setState(() {
//         _currentSpace = space;
//       });
//     } catch (e) {
//       print('Erro ao carregar espaço: $e');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0x33284017),
//       body: ValueListenableBuilder(
//         valueListenable: store.state,
//         builder: (context, events, _) {
//           if (store.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (store.erro.value != null && store.erro.value!.isNotEmpty) {
//             return Center(child: Text('Erro: ${store.erro.value}'));
//           }

//           if (events.isEmpty) {
//             return const Center(child: Text('Nenhum evento encontrado.'));
//           }

//           final evento = events.first; // Pega o primeiro evento da lista

//           return SingleChildScrollView(
//             child: Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 200,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF586C61),
//                     shape: BoxShape.rectangle,
//                   ),
//                 ),
//                 Positioned(
//                   top: 30,
//                   left: 10,
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (_) => const HomePage()),
//                       );
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   top: 30,
//                   right: 10,
//                   child: IconButton(
//                     icon: const Icon(Icons.share, color: Color(0xFFF4B134), size: 30),
//                     onPressed: () {},
//                   ),
//                 ),
//                 Positioned(
//                   top: 130,
//                   right: 20,
//                   child: IconButton(
//                     icon: Icon(
//                       _isFavorito ? Icons.favorite : Icons.favorite_border,
//                       color: Colors.black,
//                       size: 30,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isFavorito = !_isFavorito;
//                       });
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 200.0),
//                   child: Column(
//                     children: [
//                       Image.asset(
//                         'assets/quadrado.png',
//                         height: 200,
//                         width: 200,
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         evento.title,
//                         style: GoogleFonts.roboto(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
                    
//                       const SizedBox(height: 16),
//                       _buildInfoRow(Icons.location_on,  _currentSpace?.name ?? 'Carregando...'),
//                       const SizedBox(height: 10),
//                       _buildInfoRow(Icons.calendar_today, evento.start_date),
//                       const SizedBox(height: 10),
//                       _buildInfoRow(Icons.access_time, evento.start_time),
//                       const SizedBox(height: 20),
//                       _buildInfoSection('Tipo do Evento:', evento.category, Icons.event_available),
//                       const SizedBox(height: 20),
//                       _buildSectionTitle('Descrição:'),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Text(
//                           evento.description,
//                           style: GoogleFonts.roboto(fontSize: 16, color: Colors.black87),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF586C61),
//                           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                         ),
//                         child: Text(
//                           'Inscrever-se',
//                           style: GoogleFonts.roboto(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildInfoRow(IconData icon, String text) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, size: 20, color: Colors.black54),
//         const SizedBox(width: 8),
//         Text(
//           text,
//           style: GoogleFonts.roboto(
//             fontSize: 16,
//             color: Colors.black87,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildInfoSection(String title, String value, IconData icon) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 24, color: const Color(0xFF586C61)),
//             const SizedBox(width: 10),
//             Text(
//               title,
//               style: GoogleFonts.roboto(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 5),
//           child: Text(
//             value,
//             style: GoogleFonts.roboto(
//               fontSize: 16,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSectionTitle(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Text(
//         text,
//         style: GoogleFonts.roboto(
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viveri/events/pages/home/stores/event_store.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/repositories/event_repositories.dart';
import 'package:viveri/home_page.dart';
import 'package:viveri/events/data/repositories/space_repositories.dart';
import 'package:viveri/events/data/model/space_model.dart';


class EventoUnico extends StatefulWidget {
  const EventoUnico({super.key});

  @override
  State<EventoUnico> createState() => _EventoUnicoState();
}

class _EventoUnicoState extends State<EventoUnico> {
  final EventStore store = EventStore(
    repository: EventRepository(
      client: HttpClient(),
    ),
  );

  bool _isFavorito = false;
  SpaceModel? _currentSpace;

  @override
  void initState() {
    super.initState();
    store.getEvents(Page);
    if (store.events.isNotEmpty) {
        final evento = store.events.first; 
        _loadSpace(evento.space); 
      }
  }



Future<void> _loadSpace(String spaceId) async {
    final spaceRepo = SpaceRepository(client: HttpClient());
    try {
      final space = await spaceRepo.getSpaceById(int.parse(spaceId));
      setState(() {
        _currentSpace = space;
      });
    } catch (e) {
      print('Erro ao carregar espaço: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x33284017),
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

          final evento = events.first; // Pega o primeiro evento da lista

          return SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xFF586C61),
                    shape: BoxShape.rectangle,
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.share, color: Color(0xFFF4B134), size: 30),
                    onPressed: () {},
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
                Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/quadrado.png',
                        height: 200,
                        width: 200,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        evento.title,
                        style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    
                      const SizedBox(height: 16),
                      _buildInfoRow(Icons.location_on,  _currentSpace?.name ?? 'Carregando...'),
                      const SizedBox(height: 10),
                      _buildInfoRow(Icons.calendar_today, evento.start_date),
                      const SizedBox(height: 10),
                      _buildInfoRow(Icons.access_time, evento.start_time),
                      const SizedBox(height: 20),
                      _buildInfoSection('Tipo do Evento:', evento.category, Icons.event_available),
                      const SizedBox(height: 20),
                      _buildSectionTitle('Descrição:'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          evento.description,
                          style: GoogleFonts.roboto(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF586C61),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 8),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: const Color(0xFF586C61)),
            const SizedBox(width: 10),
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
          padding: const EdgeInsets.only(top: 5),
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
      padding: const EdgeInsets.only(bottom: 10),
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

