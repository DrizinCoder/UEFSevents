from rest_framework import viewsets
from .models import Questions, Answers, Complaints
from .serializer import QuestionsSerializer, AnswerSerializer, ComplaintsSerializer

class QuestionViewSet(viewsets.ModelViewSet):
    queryset = Questions.objects.all()
    serializer_class = QuestionsSerializer

class AnswerViewSet(viewsets.ModelViewSet):
    queryset = Answers.objects.all()
    serializer_class = AnswerSerializer

class complaintsViewSet(viewsets.ModelViewSet):
    queryset = Complaints.objects.all()
    serializer_class = ComplaintsSerializer