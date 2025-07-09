import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viveri/events/data/model/event_model.dart';
import 'package:viveri/login_page.dart';
import 'package:viveri/events/evento_unico/evento_unico.dart';


class Created extends StatelessWidget {
  final String url;
final String accessToken;
final Map<String, dynamic> userData;
final EventModel event;
  const Created({super.key, required this.accessToken, required this.userData, required this.event, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(212, 224, 212, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color:Color(0xFF2F4F2F) ),
            const SizedBox(height: 20),
            Text(
              'Evento Criado\ncom Sucesso!',
              style: GoogleFonts.poppins(
                fontSize: 24,
                
              ),
            ),

            
            
            
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) =>  EventoUnico(
                    url: url??'https://png.pngtree.com/thumb_back/fw800/background/20210207/pngtree-gray-gradient-background-simple-image_557033.jpg',
                    event: event,
                    accessToken: accessToken,
                    userData: userData,
                  )),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F4F2F),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 170, 0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}