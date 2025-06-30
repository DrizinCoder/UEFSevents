import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:viveri/faq/question_model/faq_model.dart';
import 'auth_service.dart';

class FaqService {
  final String _baseUrl = 'http://localhost:8000/api';
  final AuthService _authService = AuthService();

  Future<List<FaqQuestion>> fetchQuestion() async {
    final token = await _authService.getToken();
    if (token == null) throw Exception('Não autenticado');

    final response = await http.get(
      Uri.parse('$_baseUrl/perguntas-frequentes/'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] ?? data;
      return List<FaqQuestion>.from(
        results.map((e) => FaqQuestion.fromJson(e)),
      );
    } else {
      throw Exception(('Erro ao carregar perguntas: ${response..statusCode}'));
    }
  }

  Future<void> sendQuestion(String text, int userId, int eventId) async {
    final token = await _authService.getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/perguntas-frequentes/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'question_description': text,
        'question_fk_user': userId,
        'question_fk_events': eventId,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao enviar pergunta');
    }
  }

  Future<void> sendAnswer(String text, int questionId, int userId) async {
    final token = await _authService.getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/respostas/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application',
      },
      body: jsonEncode({
        'answer_description': text,
        'answer_fk_question': questionId,
        'answer_fk_user': userId,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('erro ao enviar resposta');
    }
  }

  Future<void> voteQuestion(int questionId, int userId, String type) async {
    final token = await _authService.getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/question-votes/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'question': questionId,
        'user': userId,
        'vote_type': type,
      }),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erro ao votar na pergunta: ${response.body}');
    }
  }
}
