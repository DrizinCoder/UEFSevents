import 'package:flutter/material.dart';
import 'package:viveri/faq_utils.dart';
import 'package:viveri/faq_toggle_icon.dart';
import 'package:viveri/faq_tela.dart';

class FaqQuestionTile extends StatelessWidget {
  final FaqQuestion question;
  final bool isDono;
  final void Function(String autor) onResponder;

  const FaqQuestionTile({
    super.key,
    required this.question,
    required this.isDono,
    required this.onResponder,
  });

  @override
  Widget build(BuildContext context) {
    final questionColor = question.isDono ? Colors.green[100] : Colors.white;
    final textStyle = TextStyle(fontSize: 14);


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: questionColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho com nome e data
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(
                  question.isDono
                      ? 'assets/emojievento.png'
                      : 'assets/emojisorrindo.png',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.autor,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      tempoRelativo(question.date),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_vert, size: 20),
            ],
          ),

          const SizedBox(height: 10),

          // Texto da pergunta
          Text(question.text, style: textStyle),

          const SizedBox(height: 12),

          // Ações: likes, dislikes, respostas
          Row(
            children: [
              ToggleIcon(
                outlinedIcon: Icons.favorite_border,
                filledIcon: Icons.favorite,
                initialCount: question.likes,
                activeColor: Colors.green,
              ),
              const SizedBox(width: 12),
              ToggleIcon(
                outlinedIcon: Icons.thumb_down_alt_outlined,
                filledIcon: Icons.thumb_down_alt,
                initialCount: question.dislikes,
                activeColor: Colors.red,
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.chat_bubble_outline,
                size: 18,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 4),
              Text('${question.answers.length}', style: textStyle),
              const Spacer(),
              if (isDono && !question.isDono)
                TextButton(
                  onPressed: () => onResponder(question.autor),
                  child: const Text("Responder"),
                ),
            ],
          ),

          // Lista de respostas (se houver)
          if (question.answers.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Divider(),
            ...question.answers.map((answer) {
              final isDonoAnswer = answer.isDono;
              final corAnswer =
                  isDonoAnswer ? Colors.green[50] : Colors.grey[100];
              final avatar =
                  isDonoAnswer
                      ? 'assets/emojievento.png'
                      : 'assets/emojisorrindo.png';

              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(avatar),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: corAnswer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              answer.autor,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(answer.text, style: textStyle),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }
}
