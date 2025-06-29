import 'package:flutter/material.dart';
import 'package:viveri/faq/question_model/faq_utils.dart';
import 'package:viveri/faq/question_model/faq_toggle_icon.dart';
import 'faq_model.dart';

class FaqQuestionTile extends StatefulWidget {
  final FaqQuestion question;
  final String currentUser;
  final bool isDono;
  final void Function(int index) onResponder;

  const FaqQuestionTile({
    super.key,
    required this.question,
    required this.currentUser,
    required this.isDono,
    required this.onResponder,
  });

  @override
  State<FaqQuestionTile> createState() => _FaqQuestionTileState();
}

class _FaqQuestionTileState extends State<FaqQuestionTile> {
  bool liked = false;
  bool disliked = false;

  @override
  Widget build(BuildContext context) {
    final question = widget.question;
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
                      question.autorFormatado,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      tempoRelativo(question.date),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
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
                isActive: liked,
                count: question.likes,
                activeColor: Colors.green,
                onPressed: () {
                  setState(() {
                    if (!liked) {
                      question.likes++;
                      if (disliked) {
                        disliked = false;
                        question.dislikes--;
                      }
                      liked = true;
                    } else {
                      question.likes--;
                      liked = false;
                    }
                  });
                },
              ),
              const SizedBox(width: 12),
              ToggleIcon(
                outlinedIcon: Icons.thumb_down_alt_outlined,
                filledIcon: Icons.thumb_down_alt,
                isActive: disliked,
                count: question.dislikes,
                activeColor: Colors.red,
                onPressed: () {
                  setState(() {
                    if (!disliked) {
                      question.dislikes++;
                      if (liked) {
                        question.likes--;
                        liked = false;
                      }
                      disliked = true;
                    } else {
                      question.dislikes--;
                      disliked = false;
                    }
                  });
                },
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
              TextButton(
                onPressed: () => widget.onResponder(question.id),
                child: const Text("Responder"),
              ),
            ],
          ),

          // Lista de respostas (se houver)
          if (question.answers.isNotEmpty) ...[
            // const SizedBox(height: 10),
            const Divider(),
            ...question.answers.map((answer) {
              // final isDonoAnswer = answer.isDono;
              final corAnswer =
                  answer.isDono ? Colors.green[50] : Colors.grey[200];
              final avatar =
                  answer.isDono
                      ? 'assets/emojievento.png'
                      : 'assets/emojisorrindo.png';

              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(avatar),
                    ),
                    const SizedBox(width: 8),
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
                              answer.autorFormatado,
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
            }),
          ],
        ],
      ),
    );
  }
}
