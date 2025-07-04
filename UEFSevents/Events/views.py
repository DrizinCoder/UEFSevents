from rest_framework import viewsets
from .models import Event, Adress, Space, Image
from .serializers import EventSerializer, AdressSerializer, ImageSerializer, SpaceSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter
from .filters import EventFilter, AdressFilter, SpaceFilter, ImageFilter
from rest_framework import viewsets, permissions
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.db.models import Count


@api_view(['GET'])
def popular_events(request):
    events = Event.objects.annotate(
        num_registrations=Count('eventregistration')
    ).order_by('-num_registrations')
    
    serializer = EventSerializer(events, many=True)
    
    return Response(serializer.data)


class EventViewSet(viewsets.ModelViewSet):
    queryset = Event.objects.all()
    serializer_class = EventSerializer

    #filterset_fields = ['categoria', 'tipo', 'data', 'limite_de_idade', 'adress'] 
    filter_backends = [DjangoFilterBackend, SearchFilter]
    filterset_class = EventFilter    
    
    def get_permissions(self):
        if self.action in ['create', 'update', 'partial_update', 'destroy']:
            return [permissions.IsAuthenticated()]
        return []

    filter_backends = [DjangoFilterBackend, SearchFilter] 
    filterset_fields = ['type_event', 'title', 'start_date', 'age_range', 'adress'] 
    search_fields = ['title', 'start_date', 'age_range'] 



class AdressViewSet(viewsets.ModelViewSet):
    queryset=Adress.objects.all()
    serializer_class=AdressSerializer

    filter_backends = [DjangoFilterBackend, SearchFilter]
    filterset_class = AdressFilter
    def get_permissions(self):
        if self.action in ['create', 'update', 'partial_update', 'destroy']:
            return [permissions.IsAuthenticated()]
        return []    

    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['adress_city', 'adress_state']
    search_fields = ['adress_city', 'adress_state']


class SpaceViewSet(viewsets.ModelViewSet):
    queryset=Space.objects.all()
    serializer_class=SpaceSerializer

    filter_backends = [DjangoFilterBackend, SearchFilter]
    filterset_class = SpaceFilter
    def get_permissions(self):
        if self.action in ['create', 'update', 'partial_update', 'destroy']:
            return [permissions.IsAuthenticated()]
        return []
class ImageViewSet(viewsets.ModelViewSet):
    queryset=Image.objects.all()
    serializer_class=ImageSerializer
    filter_backends = [DjangoFilterBackend, SearchFilter]
    filterset_class = ImageFilter    
    def get_permissions(self):
        if self.action in ['create', 'update', 'partial_update', 'destroy']:
            return [permissions.IsAuthenticated()]
        return []

    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['acessibility']
    search_fields = ['acessibility']
