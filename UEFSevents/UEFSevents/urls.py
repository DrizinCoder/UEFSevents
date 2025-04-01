"""
URL configuration for UEFSevents project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from Events.views import EventCreateView, event_detail_view, event_view
from FAQ.views import ViewRead, QuestionCreateView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('event/', event_view, name='events-list'),
    path('event/<int:id>', event_detail_view, name='event-detail'),
    path('event/create/', EventCreateView.as_view(), name='event_create'),
    path('faq/', ViewRead.as_view(), name='faq-list'),
    path('nova/', QuestionCreateView.as_view(), name='faq-create')
]
