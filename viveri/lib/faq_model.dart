class FaqQuestion {
  final int index;
  final String autor;
  final String text;
  final bool isDono;
  final DateTime date;
  int likes;
  int dislikes;
  final List<FaqAnswer> answers;

  FaqQuestion({
    required this.index,
    required this.autor,
    required this.text,
    required this.date,
    required this.isDono,
    this.likes = 0,
    this.dislikes = 0,
    this.answers = const [],
  });

  String get autorFormatado => isDono ? '$autor (Dono do evento)' : autor;
}

class FaqAnswer {
  final String autor;
  final String text;
  final bool isDono;

  FaqAnswer({required this.autor, required this.text, this.isDono = false});

  String get autorFormatado => isDono ? '$autor (Dono do evento)' : autor;
}
