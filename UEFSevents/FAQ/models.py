from django.db import models

#lembrar de colocar Foreignkey de usuário e eventos

class questions(models.Model):
    question_description = models.CharField(max_length = 1000)
    question_likes = models.IntegerField()
    question_dislike = models.IntegerField()

class answers(models.Model):
    answer_description = models.CharField(max_length = 1000)
    answer_fk_question = models.ForeignKey('questions', on_delete = models.CASCADE)

class complaints(models.Model):
    complaint_status = models.CharField(max_length = 100)
    complaint_reason = models.CharField(max_length = 500)