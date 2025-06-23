import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viveri/events/data/model/notifications_model.dart';
import 'package:viveri/events/data/repositories/notifications_repositories.dart';
import 'package:viveri/events/pages/home/stores/notifications_store.dart';
import 'package:viveri/events/data/http/http_client.dart';


class Notificacao {
  final String title;
  final String text;
  final String date;

  Notificacao({required this.title, required this.text, required this.date});
}

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _Notifications();
}

class _Notifications extends State<Notifications> {

  final NotificationsStore store = NotificationsStore(
    repository: NotificationsRepository(
      client: HttpClient(), // certifique-se que esse client exista
    ),
  );


  @override
  void initState() {
    super.initState();
    store.getNotifications();
  }

  // Lista de exemplo com nossas notificações

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor:  Color(0x33284017),// Cor que você pediu
      body: SingleChildScrollView(

      child:

       Stack(
       alignment: Alignment.topCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,  // Ocupa toda a largura da tela
              height: 150, // Altura proporcional
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
          
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'Notificações',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          
          // Conteúdo principal com as notificações
          Padding(
            padding: EdgeInsets.only(top: 170, left: 16, right: 16, bottom: 16), // Posição abaixo do cabeçalho
            child: ListView.builder(
              itemCount: store.state.value.length, // O número de itens na nossa lista
              shrinkWrap: true, // Essencial para ListView dentro de Column/Stack
              physics: NeverScrollableScrollPhysics(), // A rolagem é controlada pelo SingleChildScrollView
              itemBuilder: (BuildContext context, int index) {
                // Pega a notificação atual da lista
                final notificacao = store.state.value[index];
                // Constrói o widget para a notificação
                return _buildNotification(notificacao);
              },
            ),
          ),
        ]
      ),
    ),
    );
  }

  Widget _buildNotification(NotificationsModel notificacao) {
    return Container(
      width: double.infinity, // Ocupa toda a largura disponível
      margin: const EdgeInsets.only(bottom: 8.0), // Adiciona margem inferior
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 192, 201, 194),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 91, 115, 102).withOpacity(0.5), // Sombra mais suave
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding interno
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinha os textos à esquerda
              children: [
                Text(
                  notificacao.title, // O texto principal da notificação
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4), // Espaço entre os textos
                Text(
                  notificacao.text, // A data da notificação, que já estava disponível
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.black87, // Cor mais suave para a data
                  ),
                ),
              ],
            ),
          ),
          Text(
            notificacao.date,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}




