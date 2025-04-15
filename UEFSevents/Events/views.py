from rest_framework import viewsets
from .models import Event, Adress, Space, Image
from .serializers import EventSerializer, AdressSerializer, ImageSerializer, SpaceSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter


class EventViewSet(viewsets.ModelViewSet):
    queryset = Event.objects.all()
    serializer_class = EventSerializer
    filter_backends = [DjangoFilterBackend, SearchFilter] 
    filterset_fields = ['categoria', 'tipo', 'data', 'limite_de_idade', 'adress'] 
    search_fields = ['categoria', 'tipo', 'data', 'limite_de_idade'] 
    # ordering = ['']
    # ordering_fields = ['']

class AdressViewSet(viewsets.ModelViewSet):
    queryset=Adress.objects.all()
    serializer_class=AdressSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['cidade', 'estado','']
    search_fields = ['cidade', 'estado','']

class SpaceViewSet(viewsets.ModelViewSet):
    queryset=Space.objects.all()
    serializer_class=SpaceSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['acessibilidade']
    search_fields = ['acessibilidade']

class ImageViewSet(viewsets.ModelViewSet):
    queryset=Image.objects.all()
    serializer_class=ImageSerializer
    filterset_fields = ['titulo']
    search_fields = ['titulo']