from rest_framework import serializers
from .models import Questions, Answers, Complaints


class QuestionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Questions
        fields = '__all__'
        #Evita que o campo de data de criação seja alterado
        read_only_fields = ['question_created_at']


class AnswerSerializer(serializers.ModelSerializer):
    question_data = QuestionsSerializer(source='answer_fk_question', read_only=True)

    class Meta:
        model = Answers
        fields = '__all__'
        read_only_fields = ['answer_created_at']

    #Valida se a pergunta existe antes de mostrar as respostas
    def validate(self, data):
        if not Questions.objects.filter(id-data.get(('answer_fk_question').id).exists()):
            raise serializers.ValidationError("Pergunta vinculada não existe!")
        return data


class ComplaintsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Complaints
        fields = '__all__'