import django_filters
from .models import Event, Space, Adress, Image
from django.db.models import Q


class EventFilter(django_filters.FilterSet):
    event_name = django_filters.CharFilter(
        field_name = 'events__title',
        lookup_expr = 'icontains'
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


class ImageFilter(django_filters.FilterSet):
    search = django_filters.CharFilter(method='filter_search', label="Busca")

    def filter_search(self, queryset, name, value):
        return queryset.filter(
            Q(url__icontains=value)
            )

    class Meta:
        model = Image
        fields = []






