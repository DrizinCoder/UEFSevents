import django_filters
from .models import Event, Space, Adress, Image
from django.db.models import Q
from django_filters import rest_framework as filters
from django_filters import BaseInFilter, NumberFilter

class EventFilter(django_filters.FilterSet):
    # Busca textual em vários campos
    search = django_filters.CharFilter(
        method='filter_search',
        label='Pesquisar'
    )

    participant_id = django_filters.NumberFilter(
        field_name='participants__id'
        )
    
    # Filtros de categoria/data
    category = django_filters.CharFilter(
        field_name='category',
        lookup_expr='exact'
    )
    creator = django_filters.CharFilter(
        field_name='creator',
        lookup_expr='exact'
    )
    start_date = django_filters.DateFilter(
        field_name='start_date',
        lookup_expr='exact'
    )
    start_date_after = django_filters.DateFilter(
        field_name='start_date',
        lookup_expr='gte'
    )
    start_date_before = django_filters.DateFilter(
        field_name='start_date',
        lookup_expr='lte'
    )

    order_by = django_filters.OrderingFilter(
        fields=(
            ('title', 'title'),
            ('start_date', 'start_date'),
            ('end_date', 'end_date'),
            ('start_time', 'start_time'),
            ('endtime', 'endtime'),
            ('status', 'status'),
            ('category', 'category'),
            ('space', 'space'),
            ('type_event', 'type_event'),
            ('age_range', 'age_range'),
        ),
        field_labels={
            'title': 'título',
            'start_date': 'Data de início',
            'end_date': 'Data de término',
            'start_time': 'Hora de início',
            'endtime': 'Hora de término',
            'status': 'Status',
            'category': 'Categoria',
            'space': 'Espaço',
            'type_event': 'Tipo',
            'age_range': 'Idade mínima',
        }
    )

    description = django_filters.CharFilter(
        field_name='event_description',
        lookup_expr='icontains'
    )

    class Meta:
        model = Event
        fields = []

    def filter_search(self, queryset, name, value):
        """Implementa ?search= valor OR nos campos title, description e category."""
        return queryset.filter(
            Q(title__icontains=value) |
            Q(description__icontains=value) |
            Q(category__icontains=value)
        )



class SpaceFilter(django_filters.FilterSet):
    order_by = django_filters.OrderingFilter(
        fields=(
            ('max_capacity', 'max_capacity'),
            ('name', 'name'),
            ('acessibility', 'acessibility'),
            ('adress', 'adress'),
        ),
        field_labels={
            'max_capacity': 'Capacidade máxima',
            'name': 'Nome',
            'acessibility': 'Acessibilidade',
            'adress': 'Endereço',
        }
    )

    description = django_filters.CharFilter(
        field_name='description',  
        lookup_expr='icontains'
    )

    class Meta:
        model = Space  
        fields = []


class AdressFilter(django_filters.FilterSet):
    search = django_filters.CharFilter(method='filter_search', label="Busca")

    def filter_search(self, queryset, name, value):
        return queryset.filter(
            Q(city__icontains=value) | 
            Q(neighborhood__icontains=value)  # Adicione outros campos
        )

    class Meta:
        model = Adress
        fields = []

class NumberInFilter(BaseInFilter, NumberFilter):
    pass

# 2) Use-o no seu FilterSet
class ImageFilter(django_filters.FilterSet):
    search = django_filters.CharFilter(method='filter_search', label="Busca")

    # Troque NumberFilter por NumberInFilter!
    event_ids = NumberInFilter(
        field_name='events__id',
        lookup_expr='in',
        label='IDs de Evento (lista)'
    )

    def filter_search(self, queryset, name, value):
        return queryset.filter(Q(url__icontains=value))

    class Meta:
        model = Image
        # exponha só esses filtros
        fields = ['event_ids', 'search']

