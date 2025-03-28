from django.shortcuts import render
from django.http import HttpResponse
from django.views.generic import ListView
from .models import Questions, Answers

class ViewRead(ListView):
    model = Questions
    template_name = 'Lista_de_Perguntas.html'
    context_object_name = 'Perguntas'