import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:viveri/faq/question_model/faq_model.dart';
import 'auth_service.dart';

class FaqService {
  final String _baseUrl =
      'http://192.168.0.117:8000/api'; // 'http://localhost:8000/api';
  final AuthService _authService = AuthService();

  Future<List<FaqQuestion>> fetchQuestion({int? eventId}) async {
    final token = await _authService.getToken();
    if (token == null) throw Exception('Não autenticado');

    final uri = Uri.parse(
      '$_baseUrl/perguntas-frequentes${eventId != null ? '?event_name=$eventId' : ''}',
    );

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] ?? data;

      // Buscar votos do usuário
      final userVotes = await getUserVotes();
      final voteMap = {
        for (var vote in userVotes) vote['question']: vote['vote_type'],
      };

      return List<FaqQuestion>.from(
        results.map((e) {
          final question = FaqQuestion.fromJson(e);
          question.userVote = voteMap[question.id];
          return question;
        }),
      );
    } else {
      throw Exception(('Erro ao carregar perguntas: ${response.statusCode}'));
    }
  }

  Future<FaqQuestion> sendQuestion(String text, int userId, int eventId) async {
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

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return FaqQuestion.fromJson(json);
    } else {
      throw Exception('Erro ao enviar pergunta');
    }
  }

  Future<void> sendAnswer(String text, int questionId, int userId) async {
    final token = await _authService.getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/respostas/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
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

  Future<List<Map<String, dynamic>>> getUserVotes() async {
    final token = await _authService.getToken();
    if (token == null) throw Exception('Não autenticado');

    final response = await http.get(
      Uri.parse('$_baseUrl/question-votes/'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao carregar votos do usuário');
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
