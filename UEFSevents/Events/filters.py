import django_filters
from .models import Event, Space, Adress, Image
from django.db.models import Q


class EventFilter(django_filters.FilterSet):
    search = django_filters.CharFilter(method='filter_search', label="Busca")

    def filter_search(self, queryset, name, value):
        return queryset.filter(
            Q(title__icontains=value) | 
            Q(description__icontains=value)
        )

    class Meta:
        model = Event
        fields = []


class SpaceFilter(django_filters.FilterSet):
    search = django_filters.CharFilter(method='filter_search', label="Busca")

    def filter_search(self, queryset, name, value):
        return queryset.filter(
            Q(name__icontains=value)
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







