from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from .models import Questions, Answers, Complaints
from .serializers import QuestionsSerializer, AnswerSerializer, ComplaintsSerializer


class QuestionViewSet(viewsets.ModelViewSet):
    #Apenas usuários altenticados podem reclamar, o resto vai chorar pela selação bostil
    permission_classes = [IsAuthenticated]
    queryset = Questions.objects.all()
    serializer_class = QuestionsSerializer


class AnswerViewSet(viewsets.ModelViewSet):
    #Apenas usuários altenticados podem reclamar, o resto vai jogar no tigrinho
    permission_classes = [IsAuthenticated]
    serializer_class = AnswerSerializer

    #Filtra  as respostas de cada pergunta
    def get_queryset(self):
        question_id = self.request.query_params.get('question_id')
        if question_id:
            return Answers.objects.filter(answer_fk_question_id=question_id)
        return Answers.objects.all()


class ComplaintsViewSet(viewsets.ModelViewSet):
    #Apenas usuários altenticados podem reclamar, o resto vai tomar no c*
    permission_classes = [IsAuthenticated]
    queryset = Complaints.objects.all()
    serializer_class = ComplaintsSerializer