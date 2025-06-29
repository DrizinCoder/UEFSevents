import 'package:flutter/material.dart';
import 'question_model/faq_question_tile.dart';
import 'question_model/faq_utils.dart';
import 'question_model/faq_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FaqTela extends StatefulWidget {
  final String currentUser;
  final bool isDono;

  const FaqTela({super.key, required this.currentUser, required this.isDono});

  @override
  State<FaqTela> createState() => _FaqTelaState();
}

class _FaqTelaState extends State<FaqTela> {
  final TextEditingController _controller = TextEditingController();
  int? _respondendoIndex;
  List<FaqQuestion> _questions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    configurarTimeago();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    const url = 'http://localhost:8000/api/perguntas-frequentes';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer Seu_Token_JWT_AQUI'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
          json.decode(response.body)['results'] ?? json.decode(response.body);
      setState(() {
        _questions = data.map((e) => FaqQuestion.fromJson(e)).toList();
        _loading = false;
      });
    } else {
      print('Erro ao carregar perguntas: ${response.statusCode}');
    }
  }

  void _enviarMensagem() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      if (_respondendoIndex != null) {
        final idx = _respondendoIndex!;
        _questions[idx] = FaqQuestion(
          id: idx,
          autor: _questions[idx].autor,
          text: _questions[idx].text,
          isDono: _questions[idx].isDono,
          date: _questions[idx].date,
          likes: _questions[idx].likes,
          dislikes: _questions[idx].dislikes,
          answers: List.from(_questions[idx].answers)..add(
            FaqAnswer(
              autor: widget.currentUser,
              text: text,
              isDono: widget.isDono,
            ),
          ),
        );
        _respondendoIndex = null;
      } else {
        _question.add(
          FaqQuestion(
            id: _question.length,
            autor: widget.currentUser,
            text: text,
            isDono: widget.isDono,
            date: DateTime.now(),
          ),
        );
      }
      _controller.clear();
    });
  }

  void _responderPergunta(int index) {
    setState(() {
      _respondendoIndex = index;
    });
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
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xff546d64),
                  child: const Center(
                    child: Text(
                      'FAQ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
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
                        return FaqQuestionTile(
                          question: _question[index],
                          isDono: widget.isDono,
                          currentUser: widget.currentUser,
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
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_respondendoIndex != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Respondendo a ${_question[_respondendoIndex!].autor}...',
                      ),
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
