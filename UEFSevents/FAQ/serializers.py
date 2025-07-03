from rest_framework import serializers
from .models import Questions, Answers, Answer_To_Answer, Complaints, QuestionVote
from Users.serializers import CustomUserSerializer


class AnswerSerializer(serializers.ModelSerializer):
    answer_fk_question = serializers.PrimaryKeyRelatedField(
        queryset=Questions.objects.all()
    )
    answer_fk_user = CustomUserSerializer(read_only=True)

    class Meta:
        model = Answers
        fields = [
            'id', 
            'answer_description', 
            'answer_fk_question', 
            'answer_fk_user',
            'answer_created_at',
        ]
        read_only_fields = ['id', 'answer_created_at']

    def get_question_info(self, obj):
        """Método para retornar informações da pergunta relacionada"""
        return {
            'id': obj.answer_fk_question.id,
            'description': obj.answer_fk_question.question_description
        }

    def validate(self, data):
        question = data.get('answer_fk_question')
        if not question:
            raise serializers.ValidationError(
                {"answer_fk_question": "Este campo é obrigatório."}
            )
        return data
    

class QuestionsSerializer(serializers.ModelSerializer):
    question_fk_user = CustomUserSerializer(read_only=True)
    answers = AnswerSerializer(many=True, read_only=True, source='answers')

    class Meta:
        model = Questions
        fields = '__all__'
        #Evita que o campo de data de criação seja alterado
        read_only_fields = ['question_created_at']


class Ans_To_AnsSerializer(serializers.ModelSerializer):
    ans_to_ans_fk_answer = serializers.PrimaryKeyRelatedField(
        queryset=Answers.objects.all()
    )

    class Meta:
        model = Answer_To_Answer
        fields = ['id', 'ans_to_ans_description', 'ans_to_ans_fk_answer', 'ans_to_ans_created_at']
        read_only_fields = ['id', 'ans_to_ans_created_at']

    def get_question_info(self, obj):
        """Método para retornar informações da pergunta relacionada"""
        return {
            'id': obj.ans_to_ans_fk_answer.id,
            'description': obj.ans_to_ans_fk_answer.answer_description
        }

    def validate(self, data):
        question = data.get('ans_to_ans_fk_answer')
        if not question:
            raise serializers.ValidationError(
                {"ans_to_ans_fk_answer": "Este campo é obrigatório."}
            )
        return data
    

class ComplaintsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Complaints
        fields = '__all__'


class QuestionVoteSerializer(serializers.ModelSerializer):
    class Meta:
        model = QuestionVote
        fields = ['id', 'user', 'question', 'vote_type', 'voted_at']
        read_only_fields = ['id', 'voted_at']
