from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from rest_framework.filters import SearchFilter, OrderingFilter
from django_filters.rest_framework import DjangoFilterBackend
from django.shortcuts import get_object_or_404
from .models import Questions, Answers, Complaints
from .serializers import QuestionsSerializer, AnswerSerializer, ComplaintsSerializer
from .filters import QuestionsFilter, AnswersFilter, ComplaintsFilter


#Todas as classes usam IsAuthenticated para garantir que apenas usarios cadastrados possam fazer algo.
#Todas as classes usam modulos externos para filtragem
class QuestionViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    serializer_class = QuestionsSerializer
    queryset = Questions.objects.all().order_by('-question_created_at') #Pega todas as perguntas existentes

    filter_backends = [DjangoFilterBackend, OrderingFilter, SearchFilter]
    filterset_class = QuestionsFilter #Filtra cada pergunta por eventos
    search_fields = ['question_description', 'question_fk_events__title']
    ordering_fields = ['question_created_at']


class AnswerViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    serializer_class = AnswerSerializer
    queryset = Answers.objects.all().order_by('-answer_created_at') #Pega todas as respostas ordenadas em data antiga

    filter_backends = [DjangoFilterBackend, SearchFilter]
    filterset_class =  AnswersFilter
    search_fields = ['answer_description']
    ordering_fields = ['question_created_at']

    def perform_create(self, serializer):
        # Garante que a pergunta existe antes de criar a resposta
        question_id = self.request.data.get('answer_fk_question')
        question = get_object_or_404(Questions, id=question_id)
        serializer.save(answer_fk_question=question)


class ComplaintsViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    serializer_class = ComplaintsSerializer

    filter_backends = [DjangoFilterBackend]
    filterset_class = ComplaintsFilter
    ordering_fields = ['question_created_at']

    def get_queryset(self):
        queryset = Complaints.objects.all().order_by('-complaint_created_at')
        if not self.request.user.is_staff:
            queryset = queryset.filter(complaint_fk_user=self.request.user)
        return queryset