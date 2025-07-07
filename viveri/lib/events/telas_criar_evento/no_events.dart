import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viveri/login_page.dart';
import 'package:viveri/events/telas_criar_evento/create_favorite.dart';
import 'package:viveri/bottom_nav_bar.dart';


class NoEvents extends StatelessWidget {
final Map<String, dynamic> userData;
final String accessToken;
  const NoEvents({super.key, required this.userData, required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(212, 224, 212, 1),
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) =>  CreateFavorite(
                        accessToken: accessToken, userData:userData,
                          //skipNoEventsRedirect: true
                      )),
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
                    'Criar Evento',
                    style: TextStyle(fontSize: 18, color: Color(0xFFDB9E33),),
                  ),
                ),
              ),
            ),
          ),
           CustomBottomNavBar(currentIndex: 1, userData: userData, accessToken: accessToken,),
        ],
      ),
    );
  }
}

