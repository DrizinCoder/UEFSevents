from django.contrib import admin
from .models import Event, Space, Adress

# Register your models here.
admin.site.register(Event)
admin.site.register(Space)
admin.site.register(Adress)