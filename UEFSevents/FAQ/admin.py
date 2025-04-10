from django.contrib import admin
from .models import Questions, Answers, Complaints

# Register your models here.
admin.register(Questions)
admin.register(Answers)
admin.register(Complaints)