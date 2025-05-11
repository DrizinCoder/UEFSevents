
import django_filters
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import OrderingFilter
from .models import Questions, Answers, Answer_To_Answer, Complaints


class QuestionsFilter (django_filters.FilterSet):
    #Coloca a URL com nome do evento ao invés de "question_fk_user"
    event_name = django_filters.CharFilter(
        field_name = 'question_fk_events__title',
        lookup_expr = 'icontains'
    )

    #Cria ordenadores
    order_by = django_filters.OrderingFilter(
        fields = (
            ('question_created_at', 'data_crec'),
            ('-question_created_at', 'data_decr'),
            ('question_likes', 'likes'),
            ('question_dislikes'),
        ),
        field_labels = {
            'question_created_at': 'Data de Criação (Mais Antigas)',
            '-question_created_at': 'Data de criação (Mais Recentes)',
            'question_likes': 'Número de Likes',
            'question_dislikes': 'Número de Dislikes',
        }
    )

    description = django_filters.CharFilter(
        field_name = 'question_description', 
        lookup_expr = 'icontains'
    )

    class Meta:
        model = Questions
        fields = []


class AnswersFilter (django_filters.FilterSet):
    #Filtra por ID da pergunta
    question = django_filters.NumberFilter(field_name = 'answer_fk_question__id')

    user = django_filters.NumberFilter(field_name = 'answer_fk_users__id')

    user_name = django_filters.CharFilter(
        field_name = 'answer_fk_users__fk_user'
        )

    order_by = django_filters.OrderingFilter(
        fields = (
            ('answer_created_at', 'data_cresc'),
            ("-answer_created_at", 'data_descr'),
        ),
        field_labels = {
            'answer_created_at': 'Data (Mais Antigas)',
            '-answer_created_at': 'Data (Mais Recentes)',
        }
    )

    description = django_filters.CharFilter(
        field_name = 'answer_description',
        lookup_expr = 'icontains'
    )

    class Meta:
        model = Answers
        fields = []


class Ans_To_AnsFilter (django_filters.FilterSet):
    #Filtra por ID da pergunta
    answer = django_filters.NumberFilter(field_name = 'ans_to_ans_fk_answer__id')

    user = django_filters.NumberFilter(field_name = 'ans_to_ans_fk_users__id')

    user_name = django_filters.CharFilter(
        field_name = 'ans_to_ans_fk_users__fk_user'
        )

    order_by = django_filters.OrderingFilter(
        fields = (
            ('ans_to_ans_created_at', 'data_cresc'),
            ("-ans_to_ans_created_at", 'data_descr'),
        ),
        field_labels = {
            'ans_to_ans_created_at': 'Data (Mais Antigas)',
            '-ans_to_ans_created_at': 'Data (Mais Recentes)',
        }
    )

    description = django_filters.CharFilter(
        field_name = 'ans_to_ans_description',
        lookup_expr = 'icontains'
    )

    class Meta:
        model = Answer_To_Answer
        fields = []


class ComplaintsFilter (django_filters.FilterSet):
    user = django_filters.NumberFilter(field_name = 'complaint_fk_users__id')

    user_name = django_filters.CharFilter(
        field_name = 'complaint_fk_users__fk_user'
        )
    
    order_by = django_filters.OrderingFilter(
        fields = (
            ('complaint_created_at', 'data_crec'),
            ('-complaint_created_at', 'data_decr'),
        ),
        field_labels = {
            'complaint_created_at': 'Data (Mais Antigas)',
            '-complaint_created_at': 'Data (Mais Recentes)',
        }
    )


    class Meta:
        model = Complaints
        fields = []