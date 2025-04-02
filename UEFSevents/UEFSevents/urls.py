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
from Events.views import EventCreateView, event_detail_view, event_view, EventUpdateView, SpaceCreateView, AdressCreateView, event_delete_view,event_view, event_detail_view
from FAQ.views import ViewRead, QuestionCreateView
from Users import views as user_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('event/', event_view ),
    path('event/<int:id>', event_detail_view, name='eventos'),
    path('event/create/', EventCreateView.as_view(), name='event_create'),
    path('space/create/', SpaceCreateView.as_view(), name='space_create'),
    path('adress/create/', AdressCreateView.as_view(), name='adress_create'),
    path('event/update/<int:id>', EventUpdateView.as_view(), name='event_update'),
    path('event/delete/<int:id>/', event_delete_view, name='event_delete'),
    path('faq/', ViewRead.as_view(), name='faq-list'),
    path('nova/', QuestionCreateView.as_view(), name='faq-create'),
    path('user/create/', user_views.create_user, name='user_create'),
    path('user/', user_views.user_list, name='user_list'),
    path('user/<int:user_id>/', user_views.user_detail, name='user_detail'),
]
