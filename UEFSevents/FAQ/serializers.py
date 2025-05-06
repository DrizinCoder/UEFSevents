from rest_framework import serializers
from .models import Questions, Answers, Complaints


class QuestionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Questions
        fields = '__all__'
        #Evita que o campo de data de criação seja alterado
        read_only_fields = ['question_created_at']


class AnswerSerializer(serializers.ModelSerializer):
    answer_fk_question = serializers.PrimaryKeyRelatedField(
        queryset=Questions.objects.all()
    )

    class Meta:
        model = Answers
        fields = ['id', 'answer_description', 'answer_fk_question', 'answer_created_at']
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


class ComplaintsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Complaints
        fields = '__all__'