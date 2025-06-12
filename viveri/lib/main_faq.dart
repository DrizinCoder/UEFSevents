import 'package:flutter/material.dart';
import 'faq_tela.dart'; // onde está sua classe FaqQuestion
import 'faq_utils.dart'; // onde está tempoRelativo() e configurarTimeago()

void main() {
  configurarTimeago(); // importante para habilitar o locale pt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FaqTela(isDono: true),
    );
  }
}
