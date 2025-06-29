import 'package:flutter/material.dart';
import 'faq_tela.dart'; // onde está sua classe FaqTela
import 'question_model/faq_utils.dart'; // onde está tempoRelativo() e configurarTimeago()
import 'question_model/faq_model.dart'; // modelo das classes FaqQuestion e FaqAnswer

void main() {
  configurarTimeago(); // define o locale pt_br para o timeago
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Exemplo: o usuário atual é o dono
    const bool isDono = true;
    const String currentUser = "Carlos";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FaqTela(
        isDono: isDono,
        currentUser: currentUser,
        perguntas: [
          FaqQuestion(
            id: 0,
            autor: "Maria",
            text: "Vai ter bebida?",
            date: DateTime.now().subtract(const Duration(minutes: 30)),
            isDono: false,
            likes: 2,
            dislikes: 0,
            answers: [
              FaqAnswer(
                autor: "Carlos",
                text: "Sim! Refrigerante e suco.",
                isDono: true,
              ),
            ],
          ),
          FaqQuestion(
            id: 1,
            autor: "João",
            text: "Pode levar animal?",
            date: DateTime.now().subtract(const Duration(hours: 1)),
            isDono: false,
          ),
        ],
      ),
    );
  }
}
