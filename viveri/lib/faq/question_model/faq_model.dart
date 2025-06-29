class FaqQuestion {
  final int id;
  final String autor;
  final String text;
  final bool isDono;
  final DateTime date;
  int likes;
  int dislikes;
  final List<FaqAnswer> answers;

  FaqQuestion({
    required this.id,
    required this.autor,
    required this.text,
    required this.date,
    required this.isDono,
    this.likes = 0,
    this.dislikes = 0,
    this.answers = const [],
  });

  String get autorFormatado => isDono ? '$autor (Dono do evento)' : autor;

  factory FaqQuestion.fromJson(Map<String, dynamic> json) {
    return FaqQuestion(
      id: json['id'],
      autor: json['question_fk_user']['fk_user'] ?? 'Anônimo',
      text: json['question_description'],
      date: DateTime.parse(json['question_created_at']),
      isDono: json['question_fk_user']['is_event_owner'] ?? false,
      likes: json['question_likes'],
      dislikes: json['question_dislikes'],
      answers:
          (json['answers'] as List<dynamic>?)
              ?.map((e) => FaqAnswer.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class FaqAnswer {
  final String autor;
  final String text;
  final bool isDono;

  FaqAnswer({required this.autor, required this.text, this.isDono = false});

  String get autorFormatado => isDono ? '$autor (Dono do evento)' : autor;

  factory FaqAnswer.fromJson(Map<String, dynamic> json) {
    return FaqAnswer(
      autor: json['answer_fk_user']['fk_user'] ?? 'Anônimo',
      text: json['answer_description'],
      isDono: json['answer_fk_user']['is_event_owner'] ?? false,
    );
  }
}
