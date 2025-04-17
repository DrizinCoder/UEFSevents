import django_filters
from .models import Event, Space, Adress, Image
from django.db.models import Q


class EventFilter(django_filters.FilterSet):
    search = django_filters.CharFilter(method='filter_search', label="Busca")
    class Meta:
        model = Event
        fields = [
            'title',
            'start_date',
            'end_date',
            'start_time',
            'endtime',
            'status',
            'category',
            'space',
            'type_event',
            'age_range'
        ]


class SpaceFilter(django_filters.FilterSet):
    search = django_filters.CharFilter(method='filter_search', label="Busca eventos")

    class Meta:
        model = Space
        fields = ["max_capacity",
                    "name",
                    "acessibility",
                    "adress",
                    "created_at"
                    ]


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







