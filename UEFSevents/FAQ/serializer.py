from rest_framework import serializers
from .models import Questions, Answers, Complaints

class QuestionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Questions
        fields = '__all__'

class AnswerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Answers
        fields = '__all__'
    
class ComplaintsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Complaints
        fields = '__all__'