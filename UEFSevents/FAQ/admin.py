from django.contrib import admin
from .models import Questions, Answers, Complaints

# Register your models here.
admin.site.register(Questions)
admin.site.register(Answers)
admin.site.register(Complaints)