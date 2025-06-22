from django.db import models
from Users.models import CustomUser
from Events.models import Event


#Class que armazena as perguntas
class Questions(models.Model):
    question_description = models.CharField(max_length = 1000)
    question_likes = models.IntegerField(default=0)
    question_dislikes = models.IntegerField(default=0)
    question_fk_user = models.ForeignKey(CustomUser, on_delete = models.CASCADE, null=True)
    question_fk_events = models.ForeignKey(Event, on_delete = models.CASCADE, null=True)
    question_created_at = models.DateTimeField(auto_now_add=True)


#Class que armazena as respostas de cada pergunta
class Answers(models.Model):
    answer_description = models.CharField(max_length = 1000)
    answer_fk_question = models.ForeignKey(Questions, on_delete = models.CASCADE, null=True, related_name='answers')
    answer_fk_user = models.ForeignKey(CustomUser, on_delete = models.CASCADE, null=True)
    answer_created_at = models.DateTimeField(auto_now_add=True)

#Class respostas para respostas
class Answer_To_Answer(models.Model):
    ans_to_ans_description = models.CharField(max_length = 1000)
    ans_to_ans_fk_answer = models.ForeignKey(Answers, on_delete = models.CASCADE, null=True, related_name='answers')
    ans_to_ans_fk_user = models.ForeignKey(CustomUser, on_delete = models.CASCADE, null=True)
    ans_to_ans_created_at = models.DateTimeField(auto_now_add=True)

#Class reclamações
class Complaints(models.Model):
    complaint_status = models.CharField(max_length = 100)
    complaint_reason = models.CharField(max_length = 500)
    complaint_fk_user = models.ForeignKey(CustomUser, on_delete = models.CASCADE, null=True)
    complaint_fk_event = models.ForeignKey(Event, on_delete = models.CASCADE, null=True)
    complaint_created_at = models.DateTimeField(auto_now_add=True)


class QuestionVote(models.Model):
    VOTE_CHOICES = (
        ('like', 'Like'),
        ('dislike', 'Dislike'),
    )

    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    question = models.ForeignKey(Questions, on_delete=models.CASCADE, related_name='votes')
    vote_type = models.CharField(max_length=10, choices=VOTE_CHOICES)
    voted_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ('user', 'question')  # garante 1 voto por usuário por pergunta

    def __str__(self):
        return f"{self.user} - {self.vote_type} - {self.question}"
