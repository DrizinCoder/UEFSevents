from django import forms
from .models import Questions

class QuestionForm(forms.ModelForm):
    class Meta:
        model = Questions
        fields = ['question_description']
        widgets = {
            'question_description': forms.Textarea(attrs={'rows': 4, 'placeholder': 'Digite sua pergunta'},)
        }