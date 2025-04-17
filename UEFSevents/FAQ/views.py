from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from rest_framework.filters import SearchFilter, OrderingFilter
from django_filters.rest_framework import DjangoFilterBackend
from .models import Questions, Answers, Complaints
from .serializers import QuestionsSerializer, AnswerSerializer, ComplaintsSerializer
from .filters import QuestionsFilter, AnswersFilter, ComplaintsFilter


class QuestionViewSet(viewsets.ModelViewSet):
    #Apenas usuários altenticados podem reclamar, o resto vai chorar pela selação bostil
    permission_classes = [IsAuthenticated]
    serializer_class = QuestionsSerializer
    queryset = Questions.objects.all() #Pega todas as perguntas existentes

    filter_backends = [DjangoFilterBackend, OrderingFilter, SearchFilter]
    filterset_class = QuestionsFilter #Filtra cada pergunta por eventos
    search_fields = ['question_desciption', 'question_fk_events__title']


class AnswerViewSet(viewsets.ModelViewSet):
    #Apenas usuários altenticados podem reclamar, o resto vai jogar no tigrinho
    permission_classes = [IsAuthenticated]
    serializer_class = AnswerSerializer
    queryset = Answers.objects.all() #Pega todas as respostas

    filter_backends = [DjangoFilterBackend, SearchFilter]
    filterset_class =  AnswersFilter
    search_fields = ['answer_description']


class ComplaintsViewSet(viewsets.ModelViewSet):
    #Apenas usuários altenticados podem reclamar, o resto vai tomar no c*
    permission_classes = [IsAuthenticated]
    serializer_class = ComplaintsSerializer
    queryset = Complaints.objects.all() #Pega todas as reclamações

    filter_backends = [DjangoFilterBackend]
    filterset_class = ComplaintsFilter