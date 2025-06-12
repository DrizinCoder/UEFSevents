import 'package:flutter/material.dart';
import 'package:viveri/faq_question_tile.dart';

class FaqQuestion {
  final String autor;
  final String text;
  final bool isDono;
  final DateTime date;
  final int likes;
  final int dislikes;
  final List<FaqAnswer> answers;

  FaqQuestion({
    required this.autor,
    required this.text,
    this.isDono = false,
    required this.date,
    this.likes = 0,
    this.dislikes = 0,
    this.answers = const [],
  });
}

class FaqAnswer {
  final String autor;
  final String text;
  final bool isDono;

  FaqAnswer({required this.autor, required this.text, this.isDono = false});
}

class FaqTela extends StatefulWidget {
  final bool isDono;

  const FaqTela({super.key, required this.isDono});

  @override
  State<FaqTela> createState() => _FaqTelaState();
}

class _FaqTelaState extends State<FaqTela> {
  final TextEditingController _controller = TextEditingController();
  final List<FaqQuestion> _question = [
    FaqQuestion(
      autor: 'João',
      text: 'Vai ter comida vegana?',
      date: DateTime.now().subtract(Duration(hours: 2)),
      likes: 3,
      dislikes: 1,
      answers: [
        FaqAnswer(
          autor: 'Organizador',
          text: 'Sim! Teremos opções veganas.',
          isDono: true,
        ),
      ],
    ),
    FaqQuestion(
      autor: 'Maria', 
      text: 'Pode levar animal?',
      date: DateTime.now().subtract(Duration(hours: 1)),
    ),
  ];

  String? _respondendoA;

  void _enviarMensagem() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      if (_respondendoA != null) {
        final question = _question.firstWhere((p) => p.autor == _respondendoA);
        question.answers.add(
          FaqAnswer(
            autor: widget.isDono ? 'Dono do evento' : 'Você',
            text: text,
            isDono: widget.isDono,
          ),
        );
        _respondendoA = null;
      } else {
        _question.add(
          FaqQuestion(
            autor: widget.isDono ? 'Dono do evento' : 'Você',
            text: text,
            isDono: widget.isDono,
            date: DateTime.now(),
          ),
        );
      }
      _controller.clear();
    });
  }

  void _responderPergunta(String autor) {
    setState(() => _respondendoA = autor);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: const Color(0xffeaf1e7),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  color: const Color(0xff546d64),
                  child: const Center(
                    child: Text(
                      'FAQ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 90),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: _question.length,
                      itemBuilder: (context, index) {
                        final question = _question[index];
                        return FaqQuestionTile(
                          question: question,
                          isDono: widget.isDono,
                          onResponder: _responderPergunta,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: const Color(0xffeaf1e7),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_respondendoA != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text('Respondendo a $_respondendoA...'),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Digite sua pergunta...',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _enviarMensagem,
                        child: const Text('Enviar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
