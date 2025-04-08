from rest_framework import viewsets
from .models import Event, Adress, Space, Image
from .serializers import EventSerializer, AdressSerializer, ImageSerializer, SpaceSerializer

class EventViewSet(viewsets.ModelViewSet):
    queryset=Event.objects.all()
    serializer_class=EventSerializer

class AdressViewSet(viewsets.ModelViewSet):
    queryset=Adress.objects.all()
    serializer_class=AdressSerializer

class SpaceViewSet(viewsets.ModelViewSet):
    queryset=Space.objects.all()
    serializer_class=SpaceSerializer

class ImageViewSet(viewsets.ModelViewSet):
    queryset=Image.objects.all()
    serializer_class=ImageSerializer