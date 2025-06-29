import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:viveri/faq/question_model/faq_model.dart';
import 'auth_service.dart';

class FaqService {
  final String _baseUrl = 'http://localhost:8000/api';

  Future<List<FaqQuestion>> fetchQuestion() async {
    final token = await AuthService().getToken();
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
      throw Exception(('Erro ao carregar perguntas'));
    }
  }

  Future<void> sendQuestion(String text, int userId, int eventId) async {
    final token = await AuthService().getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/perguntas-frequentes/'),
      headers: {
        'Authorization': 'Bearer &$token',
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

  Future<void> voteQuestion(int questionId, int userId, String type) async {
    final token = await AuthService().getToken();
    await http.post(
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
  }
}
