import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viveri/events/data/model/event_model.dart';
import 'package:viveri/events/data/repositories/event_repositories.dart';
import 'package:viveri/events/pages/home/stores/event_store.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/model/space_model.dart';

class EventoUnicoCadastro extends StatefulWidget {
  const EventoUnicoCadastro({super.key});

  @override
  State<EventoUnicoCadastro> createState() => _EventoUnicoCadastroState();
}

class _EventoUnicoCadastroState extends State<EventoUnicoCadastro> {
  final EventStore store = EventStore(
    repository: EventRepository(client: HttpClient()),
  );

  @override
  void initState() {
    super.initState();
    store.getEvents(1); // Pega os eventos na página 1
  }

  bool _isFavorito = false;
  SpaceModel? _currentSpace;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(212, 224, 212, 1),
      body: ValueListenableBuilder<List<EventModel>>(
        valueListenable: store.state,
        builder: (context, events, _) {
          if (store.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (events.isEmpty) {
            return const Center(child: Text('Nenhum evento encontrado.'));
          }

          final event = events.first; // ou selecione um específico

          return SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: double.infinity,
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
                      Navigator.of(context).pop();
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 70),
                          Row(
                            children: [
                              Image.asset(
                                'assets/quadrado.png',
                                height: 200,
                                width: 200,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.title,
                                      style: GoogleFonts.roboto(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    _buildInfoRow(Icons.location_on, _currentSpace?.name ?? 'Local desconhecido'),
                                    const SizedBox(height: 10),
                                    _buildInfoRow(Icons.calendar_today, event.start_date ),
                                    const SizedBox(height: 10),
                                    _buildInfoRow(Icons.access_time, '${event.start_time} - ${event.endtime}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildInfoSection('Tipo do Evento:', event.category, Icons.event_available),
                          const SizedBox(height: 20),
                          _buildSectionTitle('Descrição:'),
                          Row(
                            children: [
                              const Icon(Icons.eighteen_up_rating, size: 30, color: Color(0xFF586C61)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  event.description,
                                  style: GoogleFonts.roboto(fontSize: 16, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildSectionTitle('Para mais informações'),
                          const SizedBox(height: 20),
                          _buildInfoRow(Icons.phone, _currentSpace?.phone ?? 'Telefone indisponível'),
                          const SizedBox(height: 30),
                          Center(
                            child: Column(
                              children: [
                                const Icon(Icons.emoji_emotions_rounded, size: 80, color: Color(0xFFF4B134)),
                                Text(
                                  'Organizador: ${_currentSpace?.name ?? 'Desconhecido'}',
                                  style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.question_answer, color: Color(0xFF586C61)),
                                const SizedBox(width: 8),
                                _faqButton('FAQ'),
                                const SizedBox(width: 15),
                                const Icon(Icons.warning_amber, color: Colors.amber),
                                const SizedBox(width: 8),
                                _faqButton('Algo errado?'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
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
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.roboto(fontSize: 16, color: Colors.black87),
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
            Icon(icon, size: 24, color: const Color(0xFF586C61)),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 34, top: 5),
          child: Text(value, style: GoogleFonts.roboto(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _faqButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(152, 175, 162, 1),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }
}