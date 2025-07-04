import 'package:flutter/material.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/faq/services/faq_service.dart';
import 'package:viveri/faq/question_model/faq_question_tile.dart';
import 'package:viveri/faq/question_model/faq_utils.dart';
import 'package:viveri/faq/question_model/faq_model.dart';
import 'package:viveri/events/data/model/event_model.dart';
import 'package:viveri/events/data/repositories/event_repositories.dart';

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
  final FaqService _faqService = FaqService();

  final EventRepository _eventRepo = EventRepository(client: HttpClient());
  List<EventModel> _eventos = [];
  EventModel? _eventoSelecionado;

  @override
  void initState() {
    super.initState();
    configurarTimeago();
    _loadingEvent();
  }

  Future<void> _loadingEvent() async {
    try {
      final eventos = await _eventRepo.getEvent(1);
      setState(() {
        _eventos = eventos;
        _eventoSelecionado = eventos.isNotEmpty ? eventos.first : null;
      });
      _fetchQuestions();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar eventos: $e')));
    }
  }

  Future<void> _fetchQuestions() async {
    try {
      final eventId = _eventoSelecionado?.id;
      final questions = await _faqService.fetchQuestion(eventId: eventId);

      setState(() {
        _questions = questions;
        _loading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar perguntas: ${e.toString()}')),
      );
      setState(() => _loading = false);
    }
  }

  void _enviarMensagem() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _eventoSelecionado == null) return;

    final userId = int.parse(widget.currentUser);

    try {
      if (_respondendoIndex != null) {
        final pergunta = _questions[_respondendoIndex!];
        await _faqService.sendAnswer(
          text,
          pergunta.id, // ID da pergunta
          userId,
        );
        final newAnswer = FaqAnswer(
          autor: widget.currentUser,
          text: text,
          isDono: widget.isDono,
        );

        setState(() {
          _questions[_respondendoIndex!] = FaqQuestion(
            id: pergunta.id,
            autor: pergunta.autor,
            text: pergunta.text,
            date: pergunta.date,
            isDono: pergunta.isDono,
            likes: pergunta.likes,
            dislikes: pergunta.dislikes,
            answers: List.from(pergunta.answers)..add(newAnswer),
          );
          _respondendoIndex = null;
          _controller.clear();
        });
      } else {
        final newQuestion = await _faqService.sendQuestion(
          text,
          int.parse(widget.currentUser),
          _eventoSelecionado!.id,
        );

        setState(() {
          _questions.insert(0, newQuestion);
          _controller.clear();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: ${e.toString()}')));
    }
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: DropdownButton<EventModel>(
                    isExpanded: true,
                    hint: const Text("Selecione um evento"),
                    value: _eventoSelecionado,
                    items:
                        _eventos.map((event) {
                          return DropdownMenuItem(
                            value: event,
                            child: Text(event.title),
                          );
                        }).toList(),
                    onChanged: (event) {
                      setState(() {
                        _eventoSelecionado = event;
                        _loading = true;
                      });
                      _fetchQuestions();
                    },
                  ),
                ),
                Expanded(
                  child:
                      _loading
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                            padding: const EdgeInsets.only(bottom: 90),
                            child: ListView.builder(
                              padding: const EdgeInsets.all(12),
                              itemCount: _questions.length,
                              itemBuilder: (context, index) {
                                return FaqQuestionTile(
                                  question: _questions[index],
                                  currentUser: widget.currentUser,
                                  isDono: widget.isDono,
                                  questionIndex: index,
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
                        'Respondendo a ${_questions[_respondendoIndex!].autor}...',
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
                        child: Text(
                          _respondendoIndex != null
                              ? 'Enviar resposta'
                              : 'Enviar',
                        ),
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
