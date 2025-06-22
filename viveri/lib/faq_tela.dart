import 'package:flutter/material.dart';
import 'faq_question_tile.dart';
import 'faq_model.dart';

class FaqTela extends StatefulWidget {
  final String currentUser;
  final bool isDono;
  final List<FaqQuestion> perguntas;

  const FaqTela({
    super.key,
    required this.currentUser,
    required this.isDono,
    required this.perguntas,
  });

  @override
  State<FaqTela> createState() => _FaqTelaState();
}

class _FaqTelaState extends State<FaqTela> {
  final TextEditingController _controller = TextEditingController();
  int? _respondendoIndex;
  late List<FaqQuestion> _question;

  @override
  void initState() {
    super.initState();
    _question = [...widget.perguntas];
  }

  void _enviarMensagem() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      if (_respondendoIndex != null) {
        final idx = _respondendoIndex!;
        _question[idx] = FaqQuestion(
          index: idx,
          autor: _question[idx].autor,
          text: _question[idx].text,
          isDono: _question[idx].isDono,
          date: _question[idx].date,
          likes: _question[idx].likes,
          dislikes: _question[idx].dislikes,
          answers: List.from(_question[idx].answers)..add(
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
            index: _question.length,
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
