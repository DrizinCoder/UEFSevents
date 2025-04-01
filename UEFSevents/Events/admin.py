from django.contrib import admin
from .models import Event
from .models import Space
from .models import Adress

# Register your models here.
admin.site.register(Event)
admin.site.register(Space)
admin.site.register(Adress)