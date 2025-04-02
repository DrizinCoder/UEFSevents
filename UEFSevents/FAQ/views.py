from django.shortcuts import render
from django.http import HttpResponse
from django.views.generic import ListView, CreateView
from django.urls import reverse_lazy
from django.contrib.auth.mixins import LoginRequiredMixin
from .models import Questions, Answers
from .forms import QuestionForm

#Essa view lê todas as perguntas e suas respectivas respostas e imprime
class ViewRead(ListView):
    model = Questions
    template_name = 'Lista_de_Perguntas.html'
    context_object_name = 'Perguntas'

#Cria a view
class QuestionCreateView(LoginRequiredMixin, CreateView):
    model = Questions
    form_class = QuestionForm
    template_name = 'Pergunta_Form.html'
    success_url = reverse_lazy('faq-list')

    #Define automaticamente o autor da questão/resposta
    def form_valid(self, form):
        if self.request.user.is_authenticated:
            form.instance.author = self.request.user
        return super().form_valid(form)